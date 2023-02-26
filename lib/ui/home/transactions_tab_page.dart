import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../../bloc/station/bloc.dart';
import '../../bloc/station/event.dart';
import '../../bloc/station/state.dart';
import '../../common_widget/app_widgets/custom_loading.dart';
import '../../helper/app_colors.dart';
import '../../helper/size_config.dart';
import '../../helper/toast.dart';
import '../../model/station/station_payment_transaction_result.dart';
import '../../utils/misc.dart';
import '../../utils/notifications.dart';
import '../../common_widget/app_widgets/transaction_widget.dart';

class TransactionsTabPage extends StatefulWidget {
  const TransactionsTabPage({Key? key}) : super(key: key);

  @override
  State<TransactionsTabPage> createState() => _TransactionsTabPageState();
}

List<StationPaymentTransactionResult> allStationPaymentTransactions = [];

class _TransactionsTabPageState extends State<TransactionsTabPage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StationBloc>(
        create: (BuildContext context) => StationBloc()..add(InitStationEvent()), //.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<StationBloc>(context);

    return BlocListener<StationBloc, StationState>(
        listener: (context, state) async {
          if (state is ErrorStationState)
            pushToast(state.error);
          else if (state is GotStationPaymentTransactionsState) {
            if (mounted) {
              setState(() {
                allStationPaymentTransactions = state.stationPaymentTransactionsWithPagination.stationPaymentTransactions!;
              });
            }
          }
          else if (state is InitStationState){
            bloc.add(GetStationPaymentTransactionsEvent(false, DateTime.now(), DateTime.now(), 1));
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

class _BuildUIState extends State<_BuildUI> {

  @override
  void initState() {
    super.initState();

    notificationsController.stream.listen((notificationBody) {

      hideKeyboard(context);
      if ((notificationBody.typeId??"") == "2") {
        if (mounted) {
          widget.bloc.add(GetStationPaymentTransactionsEvent(
              false, DateTime.now(), DateTime.now(), 1));
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {



    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1,
        body:
        RefreshIndicator(onRefresh: () async {
          widget.bloc.add(GetStationPaymentTransactionsEvent(false, DateTime.now(), DateTime.now(), 1));
        },
            color: Colors.white,
            backgroundColor: buttonColor1,
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child:
        SingleChildScrollView(
            child:

            Column(
              children: [
                Align(
                  child: Padding(
                      child: Text(
                        translate("labels.transactions"),
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

                Padding(child:
                (widget.state is LoadingStationState) ? CustomLoading() : (allStationPaymentTransactions.length > 0) ?
                Column(children: allStationPaymentTransactions.map((i) =>
                    TransactionWidget(
                      stationPaymentTransactionResult: i,
                      stationBloc: widget.bloc,
                      stationState: widget.state,
                    )
                ).toList(),)
                  : Text(translate("labels.noTransactions"), style: TextStyle(color: Colors.white),)
                  ,padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),)
              ],
            ))));
  }
}