import 'dart:io';
import 'package:fastfill_station_app/model/station/station_with_transactions_total.dart';
import 'package:fastfill_station_app/ui/home/new_home_tab_page_admin.dart';
import 'package:path/path.dart' as pathLib;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:path_provider/path_provider.dart';
import '../../bloc/station/bloc.dart';
import '../../bloc/station/event.dart';
import '../../bloc/station/state.dart';
import '../../common_widget/app_widgets/back_button_widget.dart';
import '../../common_widget/app_widgets/custom_loading.dart';
import '../../common_widget/app_widgets/home_box_widget.dart';
import '../../common_widget/app_widgets/new_transaction_widget.dart';
import '../../helper/app_colors.dart';
import '../../helper/const_styles.dart';
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

class PaymentTransactionsPage extends StatefulWidget {
  static const route = "/payment_transactions_page";
  final StationWithTransactionsTotal company;
  
  const PaymentTransactionsPage({Key? key, required this.company}) : super(key: key);

  @override
  State<PaymentTransactionsPage> createState() => _PaymentTransactionsPageState();
}

List<StationPaymentTransactionResult> stationPaymentTransactions = [];
bool hasNext = false;
int currentPage = 1;

String companyName = "";
DateTime filterDate = DateTime.now();
int totalTransactionsCount = 0;
double totalTransactionsValue = 0.0;
bool loadMore = false;

final Dio _dio = Dio();

String downloadProgress = "";
bool InDownloadProgress = false;

class _PaymentTransactionsPageState extends State<PaymentTransactionsPage> {

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
            filterDate = adminFilterDate;
            if (mounted) {
              setState(() {
                loadMore = false;
              });
            }
            if (!bloc.isClosed)
              bloc.add(GetStationPaymentTransactionsEventByCompanyId(true, filterDate, filterDate, 1, widget.company.id!));
          }
          else
          if (state is ErrorStationState)
            pushToast(state.error);
          else if (state is GotStationPaymentTransactionsState) {
            hasNext = state.stationPaymentTransactionsWithPagination.paginationInfo!.hasNext!;

            if (state.stationPaymentTransactionsWithPagination.paginationInfo!.pageNo == 1)
              stationPaymentTransactions = [];

            if (state.stationPaymentTransactionsWithPagination
                .stationPaymentTransactions !=
                null) {
              stationPaymentTransactions.addAll(state
                  .stationPaymentTransactionsWithPagination
                  .stationPaymentTransactions!);
            }
            else
              stationPaymentTransactions = [];
            if (!loadMore) {
              if (!bloc.isClosed)
                bloc.add(GetTotalStationPaymentTransactionsEventByCompanyId(true, filterDate, filterDate, widget.company.id!));
            }
            else {
              if (mounted) {
                setState(() {
                  loadMore = false;
                });
              }
            }
          }
          else if (state is GotTotalStationPaymentTransactionsState) {
            if (mounted) {
              setState(() {
                totalTransactionsCount = state.totalStationPaymentTransactions.count!;
                totalTransactionsValue = state.totalStationPaymentTransactions.amount!;
                loadMore = false;
              });
            }
          } else if (state is GotPaymentTransactionPDFState) {


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
          }
        },
        bloc: bloc,
        child: BlocBuilder(
            bloc: bloc,
            builder: (context, StationState state) {
              return _BuildUI(bloc: bloc, state: state, company: widget.company,);
            }));
  }
}


class _BuildUI extends StatefulWidget {
  final StationBloc bloc;
  final StationState state;
  final StationWithTransactionsTotal company;

  _BuildUI({required this.bloc, required this.state, required this.company});

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
          filterDate = DateTime.now();

          if (!widget.bloc.isClosed)
            widget.bloc.add(GetStationPaymentTransactionsEventByCompanyId(
                true, filterDate, filterDate, 1, widget.company.id!));
        }
//        }
//      }
      });
    }

    if (!updateDownloadModeStreamController.isClosed) {
      updateDownloadModeStreamController.stream.listen((event) {
        if (mounted) {
          setState(() {
            if (downloadOption == 0)
            {
              widget.bloc.add(GetPaymentTransactionsPDFByCompanyIdEvent(true, filterDate, filterDate, widget.company.id!));
            }
          });
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
        body: SafeArea(child:

        Stack(children: [

          Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, SizeConfig().h(120), 0, 0),
              child:
          RefreshIndicator(
            onRefresh: () async {
              loadMore = false;
              currentPage = 1;
              hasNext = false;
              filterDate = DateTime.now();
              if (!widget.bloc.isClosed)
                widget.bloc.add(GetStationPaymentTransactionsEventByCompanyId(
                    true, filterDate, filterDate, 1, widget.company.id!));
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


                      HomeBoxWidget(stationBloc: widget.bloc,
                          stationState: widget.state,
                          totalTransactionsCount: totalTransactionsCount,
                          totalTransactionsValue: totalTransactionsValue,
                          loadMore: loadMore,
                          onSetDateFilter: onSetDateFilter,
                          company: widget.company),


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
                      ((widget.state is InitStationState) || ((widget.state is LoadingStationState) && (currentPage == 1))) ?
                      Align(child: CustomLoading(), alignment: AlignmentDirectional.center,)
                          :

                      (stationPaymentTransactions.length > 0)
                          ?
                      (

                          Column(children: stationPaymentTransactions.map((x) =>
                              Padding(child: NewTransactionWidget(stationPaymentTransactionResult: x, stationBloc: widget.bloc, stationState: widget.state,), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0))
                          ).toList(),)
                          /*ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index)
                              {
                                  return Padding(child: NewTransactionWidget(stationPaymentTransactionResult: stationPaymentTransactions[index], stationBloc: widget.bloc, stationState: widget.state,), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10));
                              },
                              itemCount: stationPaymentTransactions.length,
                            ),*/



                      )

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
                    ],
                  )

              ),
              (loadMore) ?
              Container(
                color: Colors.white12,
                child: Align(child: CustomLoading(), alignment: AlignmentDirectional.center,),) :
              Container()

            ])

        )),

        Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child:
        Row(children: [

        BackButtonWidget(context),
          Text(
            translate("labels.stationInfo"),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: buttonColor1),
          ),
        ])),
          Padding(child: InkWell(
              onTap: () async {
                downloadOption = 0;
                downloadMode = !downloadMode;
                updateDownloadModeStreamController.sink.add(downloadMode);
              },
              child:
              Container(
                  decoration: BoxDecoration(
                      color: backgroundColor4, borderRadius: radiusAll10),
                  padding: EdgeInsets.all(8),
                  child:
                  Row(children: [
                    Padding(child:
                    Image(image: AssetImage("assets/download_icon.png"),
                        width: 25, height: 25
                    ), padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),),

                    Text(
                      translate("buttons.download"),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: buttonColor1),
                    ),
                  ],))
          ), padding: EdgeInsetsDirectional.fromSTEB(0, 85, 0, 0),),

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
                widget.bloc.add(GetStationPaymentTransactionsEventByCompanyId(
                    true, filterDate, filterDate, currentPage, widget.company.id!));
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
        filterDate = date;
        currentPage = 1;
        loadMore = false;
        if (!widget.bloc.isClosed)
          widget.bloc.add(GetStationPaymentTransactionsEventByCompanyId(
              true, filterDate, filterDate, 1, widget.company.id!));
      });
    }
  }
}
