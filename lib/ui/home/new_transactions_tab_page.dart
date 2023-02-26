import 'dart:io';
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
import '../../streams/add_remove_monthly_station_payment_transaction_stream.dart';
import '../../streams/download_mode_stream.dart';
import '../../utils/misc.dart';
import '../../utils/notifications.dart';

class NewTransactionsTabPage extends StatefulWidget {
  const NewTransactionsTabPage({Key? key}) : super(key: key);

  @override
  State<NewTransactionsTabPage> createState() => _NewTransactionsTabPageState();
}

List<MonthlyStationPaymentTransaction> paymentTransactions = [];
List<MonthlyStationPaymentTransaction> selectedPaymentTransactions = [];
bool hasNext = false;
int currentPage = 1;
bool loadMore = false;
final Dio _dio = Dio();

String downloadProgress = "";
bool InDownloadProgress = false;

class _NewTransactionsTabPageState extends State<NewTransactionsTabPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StationBloc>(
        create: (BuildContext context) =>
            StationBloc()..add(InitStationEvent()), //.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Future<String?> findLocalPath() async {
    var externalStorageDirPath;

    if (Platform.isAndroid) {
      try {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory!.path;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory!.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }

    return externalStorageDirPath;
  }

  void _onReceiveProgress(int received, int total) {
    if (total != -1) {
      String p = (received / total * 100).toStringAsFixed(0) + "%";
      if (mounted) {
        setState(() {
          downloadProgress = p;
        });
      }
      print(p);
    }
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<StationBloc>(context);

    return BlocListener<StationBloc, StationState>(
        listener: (context, state) async {
          if (state is InitStationState) {
            paymentTransactions = [];
            currentPage = 1;
            loadMore = false;
            bloc.add(GetMonthlyStationPaymentTransactionsEvent(1));
          } else if (state is GotMonthlyPaymentTransactionPDFState) {

            if (mounted) {
              setState(() {
                downloadProgress = "0%";
                InDownloadProgress = true;
              });
            }


            String urlPDF = state.reportURL.url;

            String path = ((await findLocalPath())!);

            final now = DateTime.now();
            String fileName = now.microsecondsSinceEpoch.toString() + '.pdf';

            String pathAndFileName = pathLib.join(path, fileName);

            Map<String, dynamic> result = {
              'isSuccess': false,
              'filePath': null,
              'error': null,
            };

            try {
              final response = await _dio.download(urlPDF, pathAndFileName,
                  onReceiveProgress: _onReceiveProgress);
              result['isSuccess'] = response.statusCode == 200;
              result['filePath'] = pathAndFileName;
            } catch (ex) {
              print(ex.toString());
              if (mounted) {
                setState(() {
                  InDownloadProgress = false;
                });
              }
            } finally {
              if (mounted) {
                setState(() {
                  InDownloadProgress = false;
                });
              }
              showNotification(result);
            }
          } else if (state is ClearedStationTransactionsState) {
            paymentTransactions = [];
            currentPage = 1;
            loadMore = false;
            bloc.add(GetMonthlyStationPaymentTransactionsEvent(1));
          } else if (state is ErrorStationState) {
            pushToast(state.error);
          } else if (state is GotMonthlyStationPaymentTransactionsState) {
            if (mounted) {
              setState(() {
                loadMore = false;
                if (state.monthlyStationPaymentTransactionsWithPagination
                        .paginationInfo !=
                    null)
                  hasNext = state
                      .monthlyStationPaymentTransactionsWithPagination
                      .paginationInfo!
                      .hasNext!;
                else
                  hasNext = false;

                if (state.monthlyStationPaymentTransactionsWithPagination
                        .monthlyStationPaymentTransactions !=
                    null)
                  paymentTransactions.addAll(state
                      .monthlyStationPaymentTransactionsWithPagination
                      .monthlyStationPaymentTransactions!);
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

  Future<String?> findLocalPath() async {
    var externalStorageDirPath;

    if (Platform.isAndroid) {
      try {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory!.path;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory!.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }

    return externalStorageDirPath;
  }

  @override
  void initState() {
    super.initState();

    controller = ScrollController()..addListener(_scrollListener);

    if (!notificationsController.isClosed) {
      notificationsController.stream.listen((notificationBody) {
        if (mounted) {
          hideKeyboard(context);
          paymentTransactions = [];
          currentPage = 1;
          loadMore = false;
          if (!widget.bloc.isClosed)
            widget.bloc.add(GetMonthlyStationPaymentTransactionsEvent(1));
        }
      });
    }

    if (!updateDownloadModeStreamController.isClosed) {
      updateDownloadModeStreamController.stream.listen((event) {
        if (homePageIndex == 1) {
          selectedPaymentTransactions.clear();
          if (mounted) {
            setState(() {
              downloadMode = event;
            });
          }
        }
      });
    }

    if (!addRemoveMonthlyStationPaymentTransactionStreamController.isClosed) {
      addRemoveMonthlyStationPaymentTransactionStreamController.stream
          .listen((event) {
        print(event);
        if (selectedPaymentTransactions
            .any((x) => x.year == event.year && x.month == event.month))
          selectedPaymentTransactions.removeWhere(
              (x) => x.year == event.year && x.month == event.month);
        else
          selectedPaymentTransactions.add(event);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: ((downloadMode) &&
                (!(widget.state is LoadingStationState) &&
                    (!(widget.state is InitStationState)) &&
                    (!loadMore)))
            ? Padding(
                child: InkWell(
                    onTap: () async {
                      List<MonthlyPaymentTransactionDto>
                          monthlyPaymentTransactionList = [];
                      selectedPaymentTransactions.forEach((spt) {
                        MonthlyPaymentTransactionDto
                            monthlyPaymentTransactionDto =
                            MonthlyPaymentTransactionDto(
                                month: spt.month!, year: spt.year!);
                        monthlyPaymentTransactionList
                            .add(monthlyPaymentTransactionDto);
                      });
                      if (monthlyPaymentTransactionList.length > 0)
                        if (!widget.bloc.isClosed)
                          widget.bloc.add(GetMonthlyPaymentTransactionPDFEvent(
                            monthlyPaymentTransactionList));

                      if (mounted) {
                        setState(() {
                          downloadMode = false;
                        });
                      }

                      //showWaitDialog(context);
                    },
                    child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            color: buttonColor1, borderRadius: radiusAll10),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              translate("buttons.done"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: backgroundColor1),
                            ),
                          ],
                        ))),
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
              )
            : Container(),
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
                        translate((!downloadMode)
                            ? "labels.monthlyTransactions"
                            : "labels.selectMonthsToDownload"),
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
            Expanded(
                child: (InDownloadProgress) ?
                    Center(child: Container(child: Text(downloadProgress, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),),)
                    : ((widget.state is InitStationState) ||
                        ((widget.state is LoadingStationState) && (!loadMore)))
                    ? Center(
                        child: CustomLoading(),
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) => RefreshIndicator(
                            onRefresh: () async {
                              currentPage = 1;
                              paymentTransactions = [];
                              loadMore = false;
                              hasNext = false;
                              if (!widget.bloc.isClosed)
                                widget.bloc.add(
                                    GetMonthlyStationPaymentTransactionsEvent(
                                        1));
                            },
                            color: Colors.white,
                            backgroundColor: buttonColor1,
                            triggerMode: RefreshIndicatorTriggerMode.anywhere,
                            child: (paymentTransactions.length == 0)
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
                                                    "labels.noTransactions"),
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
                                            child: MonthlyTransactionWidget(
                                              stationBloc: widget.bloc,
                                              stationState: widget.state,
                                              monthlyStationPaymentTransaction:
                                                  paymentTransactions[index],
                                            ),
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 0));
                                      },
                                      itemCount: paymentTransactions.length,
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
                  .add(GetMonthlyStationPaymentTransactionsEvent(currentPage));
          });
        }
      }
    }
  }

  void showWaitDialog(BuildContext context) {
    // set up the buttons
    Widget okButton = TextButton(
      child: Text(
        translate("buttons.ok"),
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        hideKeyboard(context);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(translate("labels.download")),
      content: Text(translate("messages.waitForDownload")),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
