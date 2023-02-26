
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:pinput/pinput.dart';

import '../../bloc/otp/bloc.dart';
import '../../bloc/otp/event.dart';
import '../../bloc/otp/state.dart';
import '../../bloc/user/bloc.dart';

import '../../common_widget/app_widgets/back_button_widget.dart';
import '../../common_widget/app_widgets/custom_loading.dart';
import '../../common_widget/buttons/custom_button.dart';
import '../../helper/app_colors.dart';
import '../../helper/const_styles.dart';
import '../../helper/size_config.dart';
import '../../helper/toast.dart';
import '../../model/otp/otp_code_verification_body.dart';
import '../../model/otp/otp_verification_phone_body.dart';
import '../../utils/misc.dart';

class OTPValidationPage extends StatelessWidget {
  static const route = "/otp_validation_page";

  final OTPVerificationPhoneBody otpVerificationPhoneBody;

  const OTPValidationPage({Key? key, required this.otpVerificationPhoneBody})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      BlocProvider<OTPBloc>(
          create: (BuildContext context) => OTPBloc()..add(OTPInitEvent()),
          child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final otpBloc = BlocProvider.of<OTPBloc>(context);

    return BlocListener<OTPBloc, OTPState>(
      listener: (context, state) async {
        if (state is OTPResendCodeState)
        {
          registerId = state.registerId;
          resendingCode = false;
        } else
        if (state is InitOTPState) {
          if (!otpBloc.isClosed)
            otpBloc.add(OTPInitEvent());
        }
        if (state is ErrorOTPState) {
          pushToast(state.error);
          resendingCode = false;
        }
      },
      child: BlocBuilder(
          bloc: otpBloc,
          builder: (context, OTPState otpState) {
            return _BuildUI(otpBloc: otpBloc, otpState: otpState, registerId: otpVerificationPhoneBody.registerId, phoneNumber: otpVerificationPhoneBody.phoneNumber,);
          }),
    );
  }
}

String code = "";
String registerId = "";
bool resendingCode = false;

class _BuildUI extends StatefulWidget {
  final OTPBloc otpBloc;
  final OTPState otpState;
  final String registerId;
  final String phoneNumber;

  _BuildUI({required this.otpBloc, required this.otpState, required this.registerId, required this.phoneNumber});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}

class _BuildUIState extends State<_BuildUI> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();


  String convertArabicToEnglishNumbers(String input)
  {
    const english = ['0','1','2','3','4','5','6','7','8','9'];
    const arabic = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩'];

    for (int i = 0; i < arabic.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    return input;
  }

  @override
  void initState() {
    super.initState();
    registerId = widget.registerId;
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    SizeConfig().init(context);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1,
        body: SingleChildScrollView(
            child: Stack(children: [
              Container(
                margin: EdgeInsetsDirectional.only(
                    top: SizeConfig().h(175),
                    start: SizeConfig().w(20),
                    end: SizeConfig().w(20)),
                padding: EdgeInsets.symmetric(horizontal: SizeConfig().w(13)),
                decoration:
                BoxDecoration(color: Colors.white, borderRadius: radiusAll20),
                child: Column(
                  children: [
                    Align(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(top: SizeConfig().h(30)),
                        child: Text(
                          translate("labels.verifyAccount"),
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      alignment: AlignmentDirectional.topStart,
                    ),
                    Text(translate("labels.verifyAccountDesc")
                      //+ ": " + ((otpArguments.otpForType == OtpForType.Signup) ? otpArguments.signupBody!.mobileNumber! :
                      //(otpArguments.otpForType == OtpForType.ResetPassword) ? otpArguments.resetPasswordBody!.mobileNumber! : "")
                    ),
                    Align(
                      child: Padding(
                          padding: EdgeInsetsDirectional.only(top: SizeConfig().h(25)),
                          child: Text(translate("labels.yourCodeHere"))),
                      alignment: AlignmentDirectional.topStart,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(top: SizeConfig().h(0)),
                      child:
                      Directionality(
                        // Specify direction if desired
                        textDirection: TextDirection.ltr,
                        child: Pinput(
                          length: 6,
                          controller: pinController,
                          focusNode: focusNode,
                          androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsUserConsentApi,
                          listenForMultipleSmsOnAndroid: true,
                          defaultPinTheme: defaultPinTheme,
                          onClipboardFound: (value) {
                            debugPrint('onClipboardFound: $value');
                            pinController.setText(value);
                          },
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                          onCompleted: (pin) {
                            code = pin;
                          },
                          onChanged: (value) {
                            code = value;
                          },
                          cursor: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 9),
                                width: 22,
                                height: 1,
                                color: focusedBorderColor,
                              ),
                            ],
                          ),
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: focusedBorderColor),
                            ),
                          ),
                          submittedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              color: fillColor,
                              borderRadius: BorderRadius.circular(19),
                              border: Border.all(color: focusedBorderColor),
                            ),
                          ),
                          errorPinTheme: defaultPinTheme.copyBorderWith(
                            border: Border.all(color: Colors.redAccent),
                          ),
                        ),
                      ),


                    ),

                    Align(
                      child: (!resendingCode) ?
                      Padding(
                          padding: EdgeInsetsDirectional.only(top: SizeConfig().h(25)),
                          child: InkWell(
                            child: Text(translate("labels.resendCode"), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                            onTap: () async {
                              setState(() {
                                resendingCode = true;
                                widget.otpBloc.add(OTPResendCodeEvent(widget.phoneNumber));
                              });

                            },
                          )) : Container(child: CustomLoading(),
                        width: 25,
                        height: 25,
                      ),
                      alignment: AlignmentDirectional.bottomEnd,
                    ),

                    if (widget.otpState is LoadingOTPState)
                      const CustomLoading()
                    else
                      Padding(
                          padding: EdgeInsetsDirectional.only(
                              top: SizeConfig().h(10), bottom: SizeConfig().h(25)),
                          child: CustomButton(
                              backColor: buttonColor1,
                              titleColor: Colors.white,
                              borderColor: buttonColor1,
                              title: translate("buttons.validate"),
                              onTap: () {
                                if (code.length == 6) {
                                  hideKeyboard(context);
                                  if (code.isNotEmpty) {
                                    OTPCodeVerificationBody otpCodeVerification = OTPCodeVerificationBody(code: code, registerId: registerId);
                                    Navigator.pop(context, otpCodeVerification);
                                  }
                                }
                              })),
                  ],
                ),
              ),
              BackButtonWidget(context)
            ])));
  }
}
