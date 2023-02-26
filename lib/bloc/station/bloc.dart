import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import '../../api/methods.dart';
import '../../api/retrofit.dart';
import '../../utils/local_data.dart';
import 'event.dart';
import 'state.dart';

class StationBloc extends Bloc<StationEvent, StationState> {
  late ApiClient mClient;

  StationBloc() : super(InitStationState()) {
    mClient = ApiClient(certificateClient());
     on<InitStationEvent>((event, emit){
       emit(InitStationState());
     });

    on<GetAllStationsByGroup>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getAllCompaniesByGroup(token, event.page, 10, event.filterByDate, DateFormat("yyyy-MM-dd", "en_US").format(event.filterFromDate), DateFormat("yyyy-MM-dd", "en_US").format(event.filterToDate)).then((v) {
            emit(GotAllStationsByGroup(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotGetAllStationsByGroup")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotGetAllStationsByGroup")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<GetMonthlyStationPaymentTransactionsEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getMonthlyStationPaymentTransactions(token, event.page, 10).then((v) {
              emit(GotMonthlyStationPaymentTransactionsState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotLoadTransaction")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotLoadTransaction")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<GetTotalStationPaymentTransactionsEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getTotalStationPaymentTransactions(token, event.filterByDate, DateFormat("yyyy-MM-dd", "en_US").format(event.filterFromDate), DateFormat("yyyy-MM-dd", "en_US").format(event.filterToDate)).then((v) {
              emit(GotTotalStationPaymentTransactionsState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotLoadTotalTransactions")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotLoadTotalTransactions")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<GetStationPaymentTransactionsEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getStationPaymentTransactions(token, event.page, 10, event.filterByDate, DateFormat("yyyy-MM-dd", "en_US").format(event.filterFromDate), DateFormat("yyyy-MM-dd","en_US").format(event.filterToDate)).then((v) {
              emit(GotStationPaymentTransactionsState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotLoadTransaction")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotLoadTransaction")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<ClearStationTransactionsEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.clearUserTransactions(token).then((v) {
              emit(ClearedStationTransactionsState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotClearUserNotifications")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotClearUserNotifications")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });


    on<GetMonthlyPaymentTransactionPDFEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getMonthlyCompanyPaymentTransactionsPDF(token, event.monthlyPaymentTransactionList).then((v) {
            emit(GotMonthlyPaymentTransactionPDFState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotGetPaymentTransactionPDF")));
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorStationState(
                translate("messages.couldNotGetPaymentTransactionPDF")));
          else {
            print("Error" + e.toString());
            emit(ErrorStationState(dioErrorMessageAdapter(e)));
          }
        }
        else
        {
          emit(ErrorStationState(
              translate("messages.couldNotGetPaymentTransactionPDF")));

        }
      }
    });

    on<GetPaymentTransactionsPDFEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getPaymentTransactionPDF(token, event.filterByDate, DateFormat("yyyy-MM-dd", "en_US").format(event.filterFromDate), DateFormat("yyyy-MM-dd", "en_US").format(event.filterToDate)).then((v) {
            emit(GotPaymentTransactionPDFState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotGetPaymentTransactionPDF")));
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorStationState(
                translate("messages.couldNotGetPaymentTransactionPDF")));
          else {
            print("Error" + e.toString());
            emit(ErrorStationState(dioErrorMessageAdapter(e)));
          }
        }
        else
          {
            emit(ErrorStationState(
                translate("messages.couldNotGetPaymentTransactionPDF")));

          }
      }
    });


    on<GetStationPaymentTransactionsEventByCompanyId>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getStationPaymentTransactionsByCompanyId(token, event.page, 10, event.filterByDate, DateFormat("yyyy-MM-dd", "en_US").format(event.filterFromDate), DateFormat("yyyy-MM-dd","en_US").format(event.filterToDate), event.companyId).then((v) {
            emit(GotStationPaymentTransactionsState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotLoadTransaction")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotLoadTransaction")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });


    on<GetMonthlyStationPaymentTransactionsByCompanyIdEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getMonthlyStationPaymentTransactionsByCompanyId(token, event.page, 10, event.companyId).then((v) {
            emit(GotMonthlyStationPaymentTransactionsState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotLoadTransaction")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotLoadTransaction")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });




    on<GetMonthlyPaymentTransactionPDFByCompanyIdEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getMonthlyCompanyPaymentTransactionsPDFByCompanyId(token, event.monthlyPaymentTransactionList, event.companyId).then((v) {
            emit(GotMonthlyPaymentTransactionPDFState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotGetPaymentTransactionPDF")));
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorStationState(
                translate("messages.couldNotGetPaymentTransactionPDF")));
          else {
            print("Error" + e.toString());
            emit(ErrorStationState(dioErrorMessageAdapter(e)));
          }
        }
        else
        {
          emit(ErrorStationState(
              translate("messages.couldNotGetPaymentTransactionPDF")));

        }
      }
    });

    on<GetPaymentTransactionsPDFByCompanyIdEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getPaymentTransactionPDFByCompanyId(token, event.filterByDate, DateFormat("yyyy-MM-dd", "en_US").format(event.filterFromDate), DateFormat("yyyy-MM-dd", "en_US").format(event.filterToDate), event.companyId).then((v) {
            emit(GotPaymentTransactionPDFState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotGetPaymentTransactionPDF")));
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorStationState(
                translate("messages.couldNotGetPaymentTransactionPDF")));
          else {
            print("Error" + e.toString());
            emit(ErrorStationState(dioErrorMessageAdapter(e)));
          }
        }
        else
        {
          emit(ErrorStationState(
              translate("messages.couldNotGetPaymentTransactionPDF")));

        }
      }
    });

    on<GetTotalStationPaymentTransactionsEventByCompanyId>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getTotalStationPaymentTransactionsByCompanyId(token, event.filterByDate, DateFormat("yyyy-MM-dd", "en_US").format(event.filterFromDate), DateFormat("yyyy-MM-dd", "en_US").format(event.filterToDate), event.companyId).then((v) {
            emit(GotTotalStationPaymentTransactionsState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotLoadTotalTransactions")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotLoadTotalTransactions")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });
  }
}


