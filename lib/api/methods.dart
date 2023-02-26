import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_translate/flutter_translate.dart';

String dioErrorMessageAdapter(DioError error) {
  switch (error.type) {
    case DioErrorType.cancel:
      return translate("messages.requestWasCancelled");
    case DioErrorType.connectTimeout:
      return translate("messages.checkYourInternetConnection");
    case DioErrorType.receiveTimeout:
      return translate("messages.receiveTimeoutInConnection");
    case DioErrorType.response:
      return translate("messages.receivedInvalidStatusCode") +
          error.response!.statusCode.toString();
    case DioErrorType.sendTimeout:
      return translate("messages.receiveTimeoutInSendRequest");
    default:
      return "There is a problem..";
  }
}

Dio certificateClient() {
  final Dio dio = Dio();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
  return dio;
}


