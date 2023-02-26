import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fastfill_station_app/model/user/update_user_language_body.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../../api/methods.dart';
import '../../api/retrofit.dart';
import '../../utils/local_data.dart';
import 'event.dart';
import 'state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late ApiClient mClient;

  UserBloc() : super(InitUserState()) {
    mClient = ApiClient(certificateClient());
     on<UserInitEvent>((event, emit){
       emit(InitUserState());
     });



    on<LogoutEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.logout(token).then((v) {
            emit(LoggedOutState(v));
          });
        }
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.couldNotLogout")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }
    });


    on<UpdateUserLanguageEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          UpdateUserLanguageBody uulb = UpdateUserLanguageBody(languageId: event.languageId);
          await mClient.updateUserLanguage(token, uulb).then((v) {
            emit(UpdatedUserLanguageState(v));
          });
        }
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.couldNotUpdateUserLanguage")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }
    });

    on<GetNotificationsEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getNotifications(token, event.page, 10).then((v) {
            emit(GotNotificationsState(v));
          });
        }
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.couldNotGetNotifications")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }
    });

    on<SignupEvent>((event, emit) async {
      try {
        emit(LoadingUserState());

        await mClient.signup(event.signupBody).then((v) {
          emit(SignedUpState(v));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.phoneNumberOrPasswordIncorrect")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }
      //_loginUser(event).
    });

    on<UploadProfileImageEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.uploadProfilePhoto(token, event.imageFile).then((v) {
            if (v.url != null)
              emit(UploadedProfilePhoto(v.url!));
            else
              emit(ErrorUserState(
                  translate("messages.couldNotUploadProfilePhoto")));
          });
        }
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.couldNotUploadProfilePhoto")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }

    });


    on<SuccessfulUserOTPVerificationEvent>((event, emit){
      emit(SuccessfulUserOTPVerificationState(event.signupBody, event.resetPasswordBody, event.updateProfileBody, event.removeAccount));
    });

    on<ErrorUserOTPVerificationEvent>((event, emit) {
      emit(ErrorUserState(event.errorMessage));
    });


    on<VerifyOTPEvent>((event, emit) async {
      try {
        emit(LoadingUserState());

        await mClient.otpVerifyCode(event.registerId, event.code).then((v) {
          emit(VerifiedOTPCode(v, event.signupBody, event.mobileNumber, event.registerId, event.updateProfileBody, event.resetPasswordBody, event.removeAccount));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.couldNotVerifyOTPCode")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }
    });


    on<CheckUserByPhoneEvent>((event, emit) async {
      try {
        emit(LoadingUserState());

        await mClient.checkUserByPhone(event.mobileNumber).then((v) {
          emit(CheckedUserByPhoneState(v, event.mobileNumber, event.signupBody, event.updateProfileBody, event.resetPasswordBody, event.removeAccount));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.couldNotCheckPhoneNumber")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }
      //_loginUser(event).
    });

    on<CallOTPScreenEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        await mClient.otpSendCode(event.mobileNumber).then((v) {
          emit(CalledOTPScreenState(v, event.mobileNumber, event.signupBody, event.updateProfileBody, event.resetPasswordBody,  event.removeAccount));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.couldNotSendOtp")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }

    });

    on<UpdateProfileEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.updateUserProfile(token, event.updateProfileBody).then((v) {
            emit(UserProfileUpdated(v));
          });
        }
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.couldNotUpdateUserProfile")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }
    });

    on<ResetPasswordEvent>((event, emit) async {
      try {
        emit(LoadingUserState());

        await mClient.resetPassword(event.resetPasswordBody).then((v) {
          emit(PasswordResetState(v));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.phoneNumberOrPasswordIncorrect")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }

    });

    on<ClearUserNotificationsEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.clearUserNotifications(token).then((v) {
              emit(ClearedUserNotificationsState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotClearUserNotifications")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorUserState(translate("messages.couldNotClearUserNotifications")));
        else {
          print("Error" + e.toString());
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
        }
      }
    });
  }
}


