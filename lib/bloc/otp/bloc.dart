import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../../api/methods.dart';
import '../../api/retrofit.dart';
import 'event.dart';
import 'state.dart';

class OTPBloc extends Bloc<OTPEvent, OTPState>{
  late ApiClient mClient;

  OTPBloc() : super(InitOTPState()) {
    mClient = ApiClient(certificateClient());
    on<OTPInitEvent>((event, emit) {
      emit(InitOTPState());
    });


    on<OTPResendCodeEvent>((event, emit) async {
      try {
        emit(LoadingOTPState());
        await mClient.otpSendCode(event.mobileNumber).then((v) {
          emit(OTPResendCodeState(v));
        });
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorOTPState(translate("messages.couldNotResendOTP")));
        else {
          print("Error" + e.toString());
          emit(ErrorOTPState(dioErrorMessageAdapter(e)));
        }
      }
    });

  }
}
