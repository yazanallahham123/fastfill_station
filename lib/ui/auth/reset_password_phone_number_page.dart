import 'dart:io';
import 'dart:math';

import 'package:fastfill_station_app/ui/auth/reset_password_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';

import '../../bloc/user/bloc.dart';
import '../../bloc/user/event.dart';
import '../../bloc/user/state.dart';
import '../../common_widget/app_widgets/back_button_widget.dart';
import '../../common_widget/app_widgets/custom_loading.dart';
import '../../common_widget/buttons/custom_button.dart';
import '../../common_widget/custom_text_field_widgets/custom_textfield_widget.dart';
import '../../common_widget/custom_text_field_widgets/methods.dart';
import '../../helper/app_colors.dart';
import '../../helper/const_styles.dart';
import '../../helper/size_config.dart';
import '../../helper/toast.dart';
import '../../model/otp/otp_code_verification_body.dart';
import '../../model/otp/otp_verification_phone_body.dart';
import '../../model/user/reset_password_body.dart';
import '../../utils/misc.dart';
import 'login_page.dart';
import 'otp_validation_page.dart';

class ResetPassword_PhoneNumberPage extends StatefulWidget {
  static const route = "/resetpassword_phonenumber_page";

  @override
  State<ResetPassword_PhoneNumberPage> createState() => _ResetPassword_PhoneNumberPageState();
}

class _ResetPassword_PhoneNumberPageState extends State<ResetPassword_PhoneNumberPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
        create: (BuildContext context) => UserBloc()..add(UserInitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
        listener: (context, state) async {
          if (state is VerifiedOTPCode)
          {
            if (state.result) {
              userBloc.add(SuccessfulUserOTPVerificationEvent(
                  null,
                  ResetPasswordBody(
                      verificationId: state.registerId,
                      newPassword: state.resetPasswordBody!.newPassword,
                      mobileNumber: state.resetPasswordBody!.mobileNumber), null, false));
            }
            else
            {
              userBloc.add(ErrorUserOTPVerificationEvent(translate("messages.otpCodeIsIncorrect")));
            }
          }
          else
          if (state is CalledOTPScreenState)
          {
            OTPVerificationPhoneBody otpVerificationPhoneBody = OTPVerificationPhoneBody(registerId: state.registerId, phoneNumber: state.mobileNumber);
            OTPCodeVerificationBody? otpCodeVerification = await Navigator.pushNamed(
                context, OTPValidationPage.route,
                arguments: otpVerificationPhoneBody) as OTPCodeVerificationBody?;

            if (otpCodeVerification != null)
            {
              if (otpCodeVerification.code != null)
              {
                if (otpCodeVerification.code.isNotEmpty)
                {
                  if (!userBloc.isClosed) {
                    userBloc.add(VerifyOTPEvent(
                        otpCodeVerification.registerId,
                        otpCodeVerification.code,
                        null,
                        state.mobileNumber,
                        null,
                        state.resetPasswordBody, false));
                  }
                }
              }
            }
          }
          else
          if (state is CheckedUserByPhoneState)
          {
            if (state.result)
            {
              if (!userBloc.isClosed) {
                String fullNumber = countryCode+state.mobileNumber;
                userBloc.add(CallOTPScreenEvent(fullNumber, null, null, state.resetPasswordBody, false));
              }
            }
            else
            {
              pushToast(translate(translate("messages.couldNotFindPhoneNumber")));
            }
          }
          else
          if (state is ErrorUserState)
            pushToast(state.error);
          else if (state is SuccessfulUserOTPVerificationState) {
            pushToast(translate(translate("messages.otpCodeIsVerified")));

            Navigator.pushNamed(context, ResetPassword_PasswordPage.route,
                arguments: state.resetPasswordBody);
          }
        },
        child: BlocBuilder(
            bloc: userBloc,
            builder: (context, UserState userState) {
              return _BuildUI(userBloc: userBloc, userState: userState);
            }));
  }
}

class _BuildUI extends StatefulWidget {
  final UserBloc userBloc;
  final UserState userState;


  _BuildUI({required this.userBloc, required this.userState});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}

class _BuildUIState extends State<_BuildUI> {
  final phoneController = TextEditingController();

  final phoneNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1,
        body:
        KeyboardActions(
            config: _buildConfig(context),
            child:
            SingleChildScrollView(
                child: Stack(children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(
                        top: SizeConfig().h(175),
                        start: SizeConfig().w(20),
                        end: SizeConfig().w(20)),
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig().w(24)),
                    decoration:
                    BoxDecoration(color: Colors.white, borderRadius: radiusAll20),
                    child: Column(
                      children: [
                        Padding(
                            padding:
                            EdgeInsetsDirectional.only(top: SizeConfig().h(40)),
                            child: CustomTextFieldWidget(
                                controller: phoneController,
                                focusNode: phoneNode,
                                validator: validateMobile,
                                hintText: translate("labels.phoneNumber"),
                                textInputType: TextInputType.phone,
                                errorText: translate("messages.phoneNumberValidation"),
                                textInputAction: TextInputAction.go,
                                onFieldSubmitted: (_) {
                                  _resetPassword(context);
                                })),
                        if (widget.userState is LoadingUserState)
                          Padding(
                            child: const CustomLoading(),
                            padding: EdgeInsetsDirectional.only(
                                top: SizeConfig().h(10), bottom: SizeConfig().h(35)),
                          )
                        else
                          Padding(
                              padding: EdgeInsetsDirectional.only(
                                  top: SizeConfig().h(10), bottom: SizeConfig().h(35)),
                              child: CustomButton(
                                  backColor: buttonColor1,
                                  titleColor: Colors.white,
                                  borderColor: buttonColor1,
                                  title: translate("buttons.next"),
                                  onTap: () {
                                    _resetPassword(context);
                                  })),
                      ],
                    ),
                  ),
                  // Back Button
                  BackButtonWidget(context)
                ]))));
  }


  String convertArabicToEnglishNumbers(String input)
  {
    const english = ['0','1','2','3','4','5','6','7','8','9'];
    const arabic = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩'];

    for (int i = 0; i < arabic.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    return input;
  }

  void _resetPassword(BuildContext context) async {
    if (phoneController.text.isNotEmpty) {
      if (!validateMobile(phoneController.text))
        FocusScope.of(context).requestFocus(phoneNode);
      else {

        String pn = "";

        if (phoneController.text != null) {
          if ((phoneController.text.length == 9) ||
              (phoneController.text.length == 10)) {
            if ((phoneController.text.length == 10) &&
                (phoneController.text.substring(0, 1) == "0")) {
              pn = phoneController.text
                  .substring(1, phoneController.text.length);
            } else {
              if (phoneController.text.length == 9) {
                pn = phoneController.text;
              }
            }
          }
        }

        pn = convertArabicToEnglishNumbers(pn);

        ResetPasswordBody rpb = ResetPasswordBody(
            verificationId: "ResetPassword",
            newPassword: "",
            mobileNumber: pn);

        if (!widget.userBloc.isClosed)
          widget.userBloc.add(CheckUserByPhoneEvent(pn, null, null, rpb, false));

      }
    } else
      pushToast(translate("messages.theseFieldsMustBeFilledIn"));
  }

  KeyboardActionsConfig _buildConfig(BuildContext context){
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: Colors.grey[200],
        nextFocus: true,
        actions: [
          KeyboardActionsItem(focusNode: phoneNode, toolbarButtons: [
                (node) {
              return GestureDetector(
                onTap: () {
                  _resetPassword(context);
                }
                ,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(translate("buttons.apply"), style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              );
            }
          ]),

        ]);
  }
}
