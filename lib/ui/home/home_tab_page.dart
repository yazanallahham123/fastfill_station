import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../../bloc/station/bloc.dart';
import '../../bloc/station/event.dart';
import '../../bloc/station/state.dart';
import '../../common_widget/app_widgets/custom_loading.dart';
import '../../common_widget/app_widgets/new_transaction_widget.dart';
import '../../helper/app_colors.dart';
import '../../helper/const_styles.dart';
import '../../helper/methods.dart';
import '../../helper/size_config.dart';
import '../../helper/toast.dart';
import '../../model/station/station_payment_transaction_result.dart';
import '../../utils/local_data.dart';
import '../../utils/misc.dart';

import '../../utils/notifications.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

List<StationPaymentTransactionResult> stationPaymentTransactions = [];
bool hasNext = false;
int currentPage = 1;

String companyName = "";
DateTime filterDate = DateTime.now();
int totalTransactionsCount = 0;
double totalTransactionsValue = 0.0;
bool loadMore = false;

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StationBloc>(
        create: (BuildContext context) =>
            StationBloc()..add(InitStationEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<StationBloc>(context);

    return BlocListener<StationBloc, StationState>(
        listener: (context, state) async {
          if (state is InitStationState)
            {
              if (mounted) {
                setState(() {
                  loadMore = false;
                });
              }
              bloc.add(GetStationPaymentTransactionsEvent(true, DateTime.now(), DateTime.now(), 1));
            }
          else
          if (state is ErrorStationState)
            pushToast(state.error);
          else if (state is GotStationPaymentTransactionsState) {
            hasNext = state.stationPaymentTransactionsWithPagination.paginationInfo!.hasNext!;
            if (state.stationPaymentTransactionsWithPagination
                    .stationPaymentTransactions !=
                null)
              stationPaymentTransactions.addAll(state
                  .stationPaymentTransactionsWithPagination
                  .stationPaymentTransactions!);
            else
              stationPaymentTransactions = [];
            if (!loadMore)
              bloc.add(GetTotalStationPaymentTransactionsEvent(true, DateTime.now(), DateTime.now()));
          }
          else if (state is GotTotalStationPaymentTransactionsState) {
            if (mounted) {
              setState(() {
                totalTransactionsCount = state.totalStationPaymentTransactions.count!;
                totalTransactionsValue = state.totalStationPaymentTransactions.amount!;
                loadMore = false;
              });
            }
          }
        },
        bloc: bloc,
        child: BlocBuilder(
            bloc: bloc,
            builder: (context, StationState state) {
              return _BuildUI(bloc: bloc, state: state);
            }));
  }
}


class _BuildUI extends StatefulWidget {
  final StationBloc bloc;
  final StationState state;

  _BuildUI({required this.bloc, required this.state});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}

class _BuildUIState extends State<_BuildUI>  {
  OverlayEntry? overlayEntry;

  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  ScrollController controller = new ScrollController();

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();

    notificationsController.stream.listen((notificationBody) {
      hideKeyboard(context);
//      if ((notificationBody.typeId??"") == "2") {
//        if (mounted) {
          if (mounted) {
            setState(() {
              loadMore = false;
            });
          }
          widget.bloc.add(GetStationPaymentTransactionsEvent(
              true, DateTime.now(), DateTime.now(), 1));
//        }
//      }
    });


    getCurrentUserValue().then((value) {
      companyName = (isArabic())
          ? value.company!.arabicName!
          : value.company!.englishName!;
    });
  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1,
        body:
        LayoutBuilder(builder: (context, constraints) =>

        RefreshIndicator(onRefresh: () async {
          if (mounted) {
            setState(() {
              loadMore = false;
              filterDate = DateTime.now();
            });
          }
          widget.bloc.add(GetStationPaymentTransactionsEvent(
              true, filterDate, filterDate, 1));
    },
    color: Colors.white,
    backgroundColor: buttonColor1,
    triggerMode: RefreshIndicatorTriggerMode.anywhere,
    child:

        SingleChildScrollView(
            controller: controller,
            child:
            ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child:
                    Stack(children: [
            Column(

          children: [
            Align(
              child: Padding(
                  child: Text(
                    translate("labels.stationInfo"),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: buttonColor1),
                  ),
                  padding: EdgeInsetsDirectional.only(
                      start: SizeConfig().w(25),
                      end: SizeConfig().w(25),
                      top: SizeConfig().h(10))),
              alignment: AlignmentDirectional.topStart,
            ),

                            /*HomeBoxWidget(stationBloc: widget.bloc,
                              stationState: widget.state,
                              totalTransactionsCount: totalTransactionsCount,
                              totalTransactionsValue: totalTransactionsValue,
                              loadMore: loadMore), */

            ((widget.state is LoadingStationState) & (!loadMore)) ?
                                Padding(child: Container(

                                    child: Align(child:
                            CustomLoading(),alignment: AlignmentDirectional.center,),
                                height: 50,
                                  width: 50,

                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 1),
                                      borderRadius: radiusAll14,
                                      color: Colors.white30
                                  ),
                                ),
                                  padding: EdgeInsetsDirectional.only(
                                      start: SizeConfig().w(50),
                                      end: SizeConfig().w(50))
                                ) :

                            (widget.state is LoadingStationState) ? Padding(child: CustomLoading(), padding:
                            EdgeInsetsDirectional.only(
                                start: SizeConfig().w(0),
                                end: SizeConfig().w(0),
                                bottom: SizeConfig().h(0),
                                top: SizeConfig().h(150))
                              ,) :
                            Padding(child:
                            Column(children: [
                            Align(
                              child: Padding(
                                child: Text(
                                  translate("labels.transactions"),
                                  style: TextStyle(
                                    color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                padding: EdgeInsetsDirectional.only(
                                    start: SizeConfig().w(30),
                                    end: SizeConfig().w(30),
                                    bottom: SizeConfig().h(0),
                                    top: SizeConfig().h(0)),
                              ),
                              alignment: AlignmentDirectional.topStart,
                            ),
                            (stationPaymentTransactions.length > 0)
                                ?

                                Column(children: stationPaymentTransactions.map((x) => new
                                NewTransactionWidget(stationPaymentTransactionResult: x, stationState: widget.state,
                                  stationBloc: widget.bloc ,)).toList(),)

                            /*ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index)
                              {
                                return Padding(child: NewTransactionWidget(stationPaymentTransactionResult: stationPaymentTransactions[index], stationBloc: widget.bloc, stationState: widget.state,), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10));
                              },
                              itemCount: stationPaymentTransactions.length,
                            )*/

                                : Align(
                              child: Padding(
                                child: Text(

                                  translate("labels.noTransactions"),
                                  style: TextStyle(color:Colors.white, fontSize: 12),
                                ),
                                padding: EdgeInsetsDirectional.only(
                                    top: SizeConfig().w(15),
                                    start: SizeConfig().w(30),
                                    end: SizeConfig().w(30),
                                    bottom: SizeConfig().w(15)),
                              ),
                              alignment:
                              AlignmentDirectional.topCenter,
                            ),
                            ],), padding: EdgeInsetsDirectional.only(
                                top: SizeConfig().w(0),
                                start: SizeConfig().w(0),
                                end: SizeConfig().w(0),
                                bottom: SizeConfig().w(0)),)
                          ],
            ),
                      ((loadMore) && (widget.state is LoadingStationState))  ? Container(
                        height: constraints.maxHeight,
                          width: constraints.maxWidth,
                          color: Colors.white24,
                          child: Align(child: Text(translate("labels.loading")), alignment: AlignmentDirectional.center,)) : Container(),
                    ]),
              )


            ))));
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (!(widget.state is LoadingStationState)) {
      if (hasNext) {
        if (controller.position.pixels >
            (controller.position.maxScrollExtent * .75)) {
          setState(() {
            loadMore = true;
            currentPage = currentPage + 1;
            widget.bloc.add(GetStationPaymentTransactionsEvent(
                true, filterDate, filterDate, currentPage));
          });
        }
      }
    }
  }
}
