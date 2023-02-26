import 'dart:io';
import 'package:fastfill_station_app/common_widget/app_widgets/new_station_widget.dart';
import 'package:fastfill_station_app/model/station/station_with_transactions_total.dart';
import 'package:path/path.dart' as pathLib;
import 'package:dio/dio.dart';
import 'package:fastfill_station_app/common_widget/app_widgets/monthly_transaction_widget.dart';
import 'package:fastfill_station_app/main.dart';
import 'package:fastfill_station_app/model/reports/monthly_payment_transaction_dto.dart';
import 'package:fastfill_station_app/ui/language/language_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:path_provider/path_provider.dart';

import '../../bloc/station/bloc.dart';
import '../../bloc/station/event.dart';
import '../../bloc/station/state.dart';
import '../../common_widget/app_widgets/custom_loading.dart';
import '../../common_widget/buttons/custom_button.dart';
import '../../helper/app_colors.dart';
import '../../helper/const_styles.dart';
import '../../helper/size_config.dart';
import '../../helper/toast.dart';
import '../../model/station/monthly_station_payment_transaction.dart';
import '../../model/station/station.dart';
import '../../streams/add_remove_monthly_station_payment_transaction_stream.dart';
import '../../streams/download_mode_stream.dart';
import '../../utils/misc.dart';
import '../../utils/notifications.dart';

class NewTransactionsTabAdminPage extends StatefulWidget {
  const NewTransactionsTabAdminPage({Key? key}) : super(key: key);

  @override
  State<NewTransactionsTabAdminPage> createState() => _NewTransactionsTabAdminPageState();
}

List<StationWithTransactionsTotal> stations = [];
bool hasNext = false;
int currentPage = 1;
bool loadMore = false;

class _NewTransactionsTabAdminPageState extends State<NewTransactionsTabAdminPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StationBloc>(
        create: (BuildContext context) =>
        StationBloc()..add(InitStationEvent()), //.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<StationBloc>(context);

    return BlocListener<StationBloc, StationState>(
        listener: (context, state) async {
          if (state is InitStationState) {
            stations = [];
            currentPage = 1;
            loadMore = false;
            bloc.add(GetAllStationsByGroup(1, false, DateTime.now(),  DateTime.now()));
          }  else if (state is ErrorStationState) {
            pushToast(state.error);
          } else if (state is GotAllStationsByGroup) {
            if (mounted) {
              setState(() {
                loadMore = false;
                if (state.stationsWithPagination
                    .paginationInfo !=
                    null)
                  hasNext = state
                      .stationsWithPagination
                      .paginationInfo!
                      .hasNext!;
                else
                  hasNext = false;

                if (state.stationsWithPagination
                    .companies !=
                    null)
                  stations.addAll(state
                      .stationsWithPagination
                      .companies!);
                else {
                  hasNext = false;
                }

                print("Current Page:");
                print(currentPage);
                print("hasNext:");
                print(hasNext);
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

class _BuildUIState extends State<_BuildUI> {
  ScrollController controller = new ScrollController();

  @override
  void initState() {
    super.initState();

    controller = ScrollController()..addListener(_scrollListener);

    if (!notificationsController.isClosed) {
      notificationsController.stream.listen((notificationBody) {
        if (mounted) {
          hideKeyboard(context);
          stations = [];
          currentPage = 1;
          loadMore = false;
          if (!widget.bloc.isClosed)
            widget.bloc.add(GetAllStationsByGroup(1,false, DateTime.now(),  DateTime.now()));
        }
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1,
        body: Column(
          children: [
            Align(
              child: Padding(
                  child: Row(
                    mainAxisAlignment: (!downloadMode)
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    children: [
                      Text(
                        translate("labels.stations"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: buttonColor1),
                      ),
                    ],
                  ),
                  padding: EdgeInsetsDirectional.only(
                      start: SizeConfig().w(25),
                      end: SizeConfig().w(25),
                      top: SizeConfig().h(10))),
              alignment: AlignmentDirectional.topStart,
            ),

            ((widget.state is InitStationState) || ((widget.state is LoadingStationState) && (currentPage == 1))) ?
            Align(child: CustomLoading(), alignment: AlignmentDirectional.center,)
                :
            Expanded(
                child:
                    LayoutBuilder(
                    builder: (context, constraints) => RefreshIndicator(
                        onRefresh: () async {
                          currentPage = 1;
                          stations = [];
                          loadMore = false;
                          hasNext = false;
                          if (!widget.bloc.isClosed)
                            widget.bloc.add(
                                GetAllStationsByGroup(
                                    1,false, DateTime.now(),  DateTime.now()));
                        },
                        color: Colors.white,
                        backgroundColor: buttonColor1,
                        triggerMode: RefreshIndicatorTriggerMode.anywhere,
                        child: (stations.length == 0)
                            ? SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    minHeight: constraints.maxHeight),
                                child: Center(
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [
                                        Align(
                                          child: Text(
                                            translate(
                                                "labels.noStations"),
                                            style: TextStyle(
                                                color: Colors.white),
                                          ),
                                          alignment:
                                          AlignmentDirectional.center,
                                        )
                                      ],
                                    ))))
                            : Stack(children: [
                          ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            controller: controller,
                            itemBuilder: (context, index) {
                              return Padding(
                                  child: NewStationWidget(
                                    stationBloc: widget.bloc,
                                    stationState: widget.state,
                                    station: stations[index],
                                    sourceId: 2,
                                  ),
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0));
                            },
                            itemCount: stations.length,
                          ),
                          (loadMore)
                              ? Container(
                            color: Colors.white12,
                            child: Align(
                              child: CustomLoading(),
                              alignment:
                              AlignmentDirectional.center,
                            ),
                          )
                              : Container()
                        ])))),
          ],
        ));
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if ((!(widget.state is LoadingStationState)) && (!loadMore)) {
      if (hasNext) {
        if (controller.position.pixels >
            (controller.position.maxScrollExtent * .75)) {
          setState(() {
            loadMore = true;
            currentPage = currentPage + 1;
            if (!widget.bloc.isClosed)
              widget.bloc
                  .add(GetAllStationsByGroup(currentPage,false, DateTime.now(),  DateTime.now()));
          });
        }
      }
    }
  }
}
