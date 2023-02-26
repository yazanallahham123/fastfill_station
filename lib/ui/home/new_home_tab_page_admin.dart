import 'dart:io';
import 'package:fastfill_station_app/common_widget/app_widgets/new_station_widget.dart';
import 'package:fastfill_station_app/model/station/station_with_transactions_total.dart';
import 'package:path/path.dart' as pathLib;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:path_provider/path_provider.dart';
import '../../bloc/station/bloc.dart';
import '../../bloc/station/event.dart';
import '../../bloc/station/state.dart';
import '../../common_widget/app_widgets/custom_loading.dart';
import '../../common_widget/app_widgets/home_box_widget.dart';
import '../../common_widget/app_widgets/new_transaction_widget.dart';
import '../../helper/app_colors.dart';
import '../../helper/methods.dart';
import '../../helper/size_config.dart';
import '../../helper/toast.dart';
import '../../main.dart';
import '../../model/station/station.dart';
import '../../model/station/station_payment_transaction_result.dart';

import '../../streams/download_mode_stream.dart';
import '../../utils/local_data.dart';
import '../../utils/misc.dart';

import '../../utils/notifications.dart';

class NewHomeTabAdminPage extends StatefulWidget {
  const NewHomeTabAdminPage({Key? key}) : super(key: key);

  @override
  State<NewHomeTabAdminPage> createState() => _NewHomeTabAdminPageState();
}


List<StationWithTransactionsTotal> stations = [];
bool hasNext = false;
int currentPage = 1;

String companyName = "";
DateTime adminFilterDate = DateTime.now();
int totalTransactionsCount = 0;
double totalTransactionsValue = 0.0;
bool loadMore = false;

final Dio _dio = Dio();

String downloadProgress = "";
bool InDownloadProgress = false;

class _NewHomeTabAdminPageState extends State<NewHomeTabAdminPage> {


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
          if (state is GotAllStationsByGroup)
          {

            if (mounted) {
              setState(() {
                loadMore = false;
                totalTransactionsCount = state.stationsWithPagination.totalCount??0;
                totalTransactionsValue = state.stationsWithPagination.totalAmount??0;
                if (state.stationsWithPagination.paginationInfo != null)
                {
                  hasNext = state.stationsWithPagination.paginationInfo!.hasNext!;
                }
                else
                  hasNext = false;

                if (state.stationsWithPagination.paginationInfo!.pageNo == 1)
                  stations.clear();

                if (state.stationsWithPagination.companies != null) {
                  stations.addAll(state.stationsWithPagination.companies!);
                }
                else {
                  hasNext = false;
                }
              });
            }
          }
          else
          if (state is InitStationState)
          {
            hasNext = false;
            currentPage = 1;
            adminFilterDate = DateTime.now();
            bloc.add(GetAllStationsByGroup(currentPage, true, adminFilterDate, adminFilterDate));

            /*
            filterDate = DateTime.now();
            if (mounted) {
              setState(() {
                loadMore = false;
              });
            }
            if (!bloc.isClosed)
              bloc.add(GetStationPaymentTransactionsEvent(true, filterDate, filterDate, 1));*/
          }
          else
          if (state is ErrorStationState)
            pushToast(state.error);
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
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();

    if (!notificationsController.isClosed) {
      notificationsController.stream.listen((notificationBody) {
        if (mounted) {
          hideKeyboard(context);
//      if ((notificationBody.typeId??"") == "2") {
//        if (mounted) {

          setState(() {
            loadMore = false;
          });

          currentPage = 1;
          hasNext = false;
          adminFilterDate = DateTime.now();

          if (!widget.bloc.isClosed)
            widget.bloc.add(GetAllStationsByGroup(
                1, true, adminFilterDate, adminFilterDate));
        }
      });
    }

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
        RefreshIndicator(
            onRefresh: () async {
              loadMore = false;
              currentPage = 1;
              hasNext = false;
              adminFilterDate = DateTime.now();
              if (!widget.bloc.isClosed)
                widget.bloc.add(GetAllStationsByGroup(1, true, adminFilterDate, adminFilterDate));
            },
            color: Colors.white,
            backgroundColor: buttonColor1,
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            child:
            (InDownloadProgress) ?
            Center(child: Container(child: Text(downloadProgress, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),),) :
            Stack(children: [
              SingleChildScrollView(
                  controller: controller,
                  physics: AlwaysScrollableScrollPhysics(),
                  child:

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

                      HomeBoxWidget(stationBloc: widget.bloc,
                          stationState: widget.state,
                          totalTransactionsCount: totalTransactionsCount,
                          totalTransactionsValue: totalTransactionsValue,
                          loadMore: loadMore,
                          onSetDateFilter: onSetDateFilter),


                      Align(
                        child: Padding(
                          child: Text(
                            translate("labels.stations"),
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
                      ((widget.state is InitStationState) || ((widget.state is LoadingStationState) && (currentPage == 1))) ?
                      Align(child: CustomLoading(), alignment: AlignmentDirectional.center,)
                          :

                      (stations.length > 0)
                          ?
                      (

                          Column(children: stations.map((x) =>
                              Padding(child: NewStationWidget(station: x, stationBloc: widget.bloc, stationState: widget.state,
                              sourceId: 1,
                              ), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0))
                          ).toList(),)

                      )

                          : Align(
                        child: Padding(
                          child: Text(

                            translate("labels.noCompanies"),
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
                    ],
                  )

              ),
              (loadMore) ?
              Container(
                color: Colors.white12,
                child: Align(child: CustomLoading(), alignment: AlignmentDirectional.center,),) :
              Container()

            ])

        ));

  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if ((!(widget.state is LoadingStationState)) && (!loadMore)) {
      if (hasNext) {
        if (controller.position.pixels >
            (controller.position.maxScrollExtent * .75)) {
          if (!loadMore) {
            setState(() {
              loadMore = true;
              currentPage = currentPage + 1;
              if (!widget.bloc.isClosed)
                widget.bloc.add(GetAllStationsByGroup(currentPage, true,adminFilterDate,adminFilterDate));
            });
          }
        }
      }
    }
  }

  onSetDateFilter(DateTime date)
  {
    if (mounted) {
      setState(() {
        hasNext = false;
        adminFilterDate = date;
        currentPage = 1;
        loadMore = false;
        if (!widget.bloc.isClosed)
          widget.bloc.add(GetAllStationsByGroup(currentPage,
              true, adminFilterDate, adminFilterDate));
      });
    }
  }
}
