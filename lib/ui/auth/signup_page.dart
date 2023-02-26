import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../../common_widget/custom_text_field_widgets/textfield_password_widget.dart';
import '../../helper/app_colors.dart';
import '../../helper/const_styles.dart';
import '../../helper/size_config.dart';
import '../../helper/toast.dart';
import '../../main.dart';
import '../../model/otp/otp_code_verification_body.dart';

import '../../model/otp/otp_verification_phone_body.dart';
import '../../model/user/signup_body.dart';
import '../../utils/local_data.dart';
import '../../utils/misc.dart';
import '../home/home_page.dart';
import 'otp_validation_page.dart';

class SignupPage extends StatefulWidget {
  static const route = "/signup_page";

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
                  state.signupBody,
                  null,
                  null, false));
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
                        state.signupBody,
                        state.mobileNumber,
                        null,
                        null, false));
                  }
                }
              }
            }

          } else
          if (state is CheckedUserByPhoneState) {
            if (state.result)
              pushToast(translate("messages.phoneAlreadyInUse"));
            else {
              if (!userBloc.isClosed) {
                String fullNumber = countryCode + state.mobileNumber;
                userBloc.add(CallOTPScreenEvent(fullNumber, state.signupBody!, null, null, false));
              }
              /*
              await auth.verifyPhoneNumber(
                  phoneNumber: countryCode + state.mobileNumber,
                  timeout: const Duration(seconds: 5),
                  verificationCompleted:
                  await (PhoneAuthCredential credential) async {
                    auth.signInWithCredential(credential).then((value) {
                      print("signInWithCredential");
                      if (!userBloc.isClosed)
                        userBloc.add(SuccessfulUserOTPVerificationEvent(
                            state.signupBody,
                            null));
                    }).catchError((e) {
                      print("Error signInWithCredential");
                      if (!userBloc.isClosed)
                        userBloc.add(ErrorUserOTPVerificationEvent(
                            (e.message != null) ? e.message! : e.code));
                    });
                  },
                  verificationFailed: await (FirebaseAuthException e) async {
                    print("verificationFailed");
                    print(e);
                    userBloc.add(ErrorUserOTPVerificationEvent(
                        (e.message != null)
                            ? e.message! + " " + e.code + countryCode +
                            state.mobileNumber
                            : e.code));
                  },
                  codeSent: await (String verificationId,
                      int? resendToken) async {

                    String verId = verificationId;
                    String smsCode = "";

                    OTPVerificationPhoneBody otpVerificationPhoneBody = OTPVerificationPhoneBody(verificationId: verId, phoneNumber: fullNumber);

                    print("codeSent");
                    if (Platform.isIOS) {
                      OTPCodeVerificationBody? otpCodeVerification = await Navigator.pushNamed(
                          context, OTPValidationPage.route,
                          arguments: otpVerificationPhoneBody) as OTPCodeVerificationBody?;

                      if (otpCodeVerification != null) {
                        smsCode = otpCodeVerification.code;
                        verId = otpCodeVerification.verificationId;
                      }

                      if (smsCode.isNotEmpty) {
                        PhoneAuthCredential credential = PhoneAuthProvider
                            .credential(
                            verificationId: verId, smsCode: smsCode);
                        auth.signInWithCredential(credential).then((value) {
                          print("signInWithCredential 2");
                          if (!userBloc.isClosed)
                            userBloc.add(SuccessfulUserOTPVerificationEvent(
                                state.signupBody,
                                null));
                        }).catchError((e) {
                          print("Error signInWithCredential 2");
                          if (!userBloc.isClosed)
                            userBloc.add(ErrorUserOTPVerificationEvent(
                                (e.message != null) ? e.message! : e.code));
                        });
                      } else {
                        if (!userBloc.isClosed)
                          userBloc.add(ErrorUserOTPVerificationEvent(
                              translate("messages.emptyCode")));
                      }
                    }
                  },
                  codeAutoRetrievalTimeout: await (
                      String verificationId) async {

                    String verId = verificationId;
                    String smsCode = "";

                    OTPVerificationPhoneBody otpVerificationPhoneBody = OTPVerificationPhoneBody(verificationId: verId, phoneNumber: fullNumber);

                    OTPCodeVerificationBody? otpCodeVerification = await Navigator.pushNamed(
                        context, OTPValidationPage.route,
                        arguments: otpVerificationPhoneBody) as OTPCodeVerificationBody?;

                    if (otpCodeVerification != null) {
                      smsCode = otpCodeVerification.code;
                      verId = otpCodeVerification.verificationId;
                    }

                    if (smsCode.isNotEmpty) {
                      PhoneAuthCredential credential = PhoneAuthProvider
                          .credential(
                          verificationId: verId, smsCode: smsCode);
                      auth.signInWithCredential(credential).then((value) {
                        print("signInWithCredential 3");
                        if (!userBloc.isClosed)
                          userBloc.add(SuccessfulUserOTPVerificationEvent(
                              state.signupBody,
                              null));
                      }).catchError((e) {
                        print("Error signInWithCredential 3");
                        if (!userBloc.isClosed)
                          userBloc.add(ErrorUserOTPVerificationEvent(
                              (e.message != null) ? e.message! : e.code));
                      });
                    } else {
                      if (!userBloc.isClosed)
                        userBloc.add(ErrorUserOTPVerificationEvent(
                            translate("messages.emptyCode")));
                    }
                  }).catchError((x){
                    print("detailed error");
                    print(x);
                 });
              */
            }
          } else if (state is ErrorUserState) {

            pushToast(state.error);
          }
          else if (state is SuccessfulUserOTPVerificationState) {
            pushToast(translate(translate("messages.otpCodeIsVerified")));
            if (!userBloc.isClosed)
              userBloc.add(SignupEvent(state.signupBody));
          } else if (state is SignedUpState) {
            await setCurrentUserValue(state.signedUpUser.userDetails!);
            await setTokenValue(state.signedUpUser.token!);
            pushToast(translate("messages.youSignedupSuccessfully"));
            Navigator.pushNamedAndRemoveUntil(
                context, HomePage.route, (Route<dynamic> route) => false);
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
  final firstNameNode = FocusNode();
  final phoneNode = FocusNode();
  final passNode = FocusNode();
  final confirmPassNode = FocusNode();

  final firstNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1,
        body: KeyboardActions(
            config: _buildConfig(context),
            child: SingleChildScrollView(
                child: Container(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Align(
                      child: BackButtonWidget(context),
                      alignment: AlignmentDirectional.topStart,
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(
                          start: SizeConfig().w(20), end: SizeConfig().w(20)),
                      padding: EdgeInsets.symmetric(horizontal: SizeConfig().w(24)),
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: radiusAll20),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                            EdgeInsetsDirectional.only(top: SizeConfig().h(40)),
                            child: CustomTextFieldWidget(
                                errorText: translate("messages.thisFieldMustBeFilledIn"),
                                controller: firstNameController,
                                focusNode: firstNameNode,
                                validator: validateName,
                                hintText: translate("labels.name"),
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) =>
                                    FocusScope.of(context).requestFocus(phoneNode)),
                          ),
                          CustomTextFieldWidget(
                              errorText: translate("messages.phoneNumberValidation"),
                              controller: phoneController,
                              focusNode: phoneNode,
                              validator: validateMobile,
                              hintText: translate("labels.phoneNumber"),
                              textInputType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).requestFocus(passNode)),
                          TextFieldPasswordWidget(
                              errorText: translate("messages.passContain7Char"),

                              controller: passController,
                              focusNode: passNode,
                              validator: validatePassword,
                              hintText: translate("labels.password"),
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) => FocusScope.of(context)
                                  .requestFocus(confirmPassNode)),
                          TextFieldPasswordWidget(
                              errorText: translate("messages.confirmPassword"),
                              controller: confirmPassController,
                              textInputAction: TextInputAction.go,
                              focusNode: confirmPassNode,
                              validator: (x){
                                if (confirmPassController.text != passController.text)
                                  return false;
                                else
                                  return true;
                              },
                              hintText: translate("labels.confirmPassword"),
                              onFieldSubmitted: (_) {
                                _signUp(context);
                              }),
                          if (widget.userState is LoadingUserState)
                            Padding(
                              child: const CustomLoading(),
                              padding: EdgeInsetsDirectional.only(
                                  top: SizeConfig().h(20),
                                  bottom: SizeConfig().h(50)),
                            )
                          else
                            Padding(
                                padding: EdgeInsetsDirectional.only(
                                    top: SizeConfig().h(10),
                                    bottom: SizeConfig().h(35)),
                                child: CustomButton(
                                    backColor: buttonColor1,
                                    titleColor: Colors.white,
                                    borderColor: buttonColor1,
                                    title: translate("buttons.signUp"),
                                    onTap: () {
                                      _signUp(context);
                                      //Navigator.pushNamed(context, OTPValidationPage.route);
                                    }))
                        ],
                      ),
                    ),
                  ]),
                  height: MediaQuery.of(context).size.height,
                ))));
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


  void _signUp(BuildContext context) async {
    if (phoneController.text.isNotEmpty &&
        passController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        confirmPassController.text.isNotEmpty) {
      if (!validateMobile2(phoneController.text))
        FocusScope.of(context).requestFocus(phoneNode);
      else if (!validatePassword(passController.text))
        FocusScope.of(context).requestFocus(passNode);
      else if (!validateName(firstNameController.text))
        FocusScope.of(context).requestFocus(firstNameNode);
      else if (!validatePassword(confirmPassController.text))
        FocusScope.of(context).requestFocus(confirmPassNode);
      else if (confirmPassController.text != passController.text)
        FocusScope.of(context).requestFocus(confirmPassNode);
      else {
        hideKeyboard(context);

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

        int languageId = (languageCode == "en") ? 1 : 2;
        SignupBody signupBody =
        SignupBody(
            firstName: firstNameController.text,
            lastName: firstNameController.text,
            username: pn,
            mobileNumber: pn,
            password: passController.text,
            language: languageId);

        if (!widget.userBloc.isClosed)
          widget.userBloc.add(CheckUserByPhoneEvent(pn, signupBody, null, null, false));

      }
    } else
      pushToast(translate("messages.theseFieldsMustBeFilledIn"));
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    phoneController.dispose();
    passController.dispose();
    confirmPassController.dispose();

    firstNameNode.dispose();
    confirmPassNode.dispose();
    passNode.dispose();
    phoneNode.dispose();
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: Colors.grey[200],
        nextFocus: true,
        actions: [
          KeyboardActionsItem(focusNode: firstNameNode, toolbarButtons: [
                (node) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(phoneNode);
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    translate("buttons.next"),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }
          ]),
          KeyboardActionsItem(focusNode: phoneNode, toolbarButtons: [
                (node) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(passNode);
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    translate("buttons.next"),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }
          ]),
          KeyboardActionsItem(focusNode: passNode, toolbarButtons: [
                (node) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(confirmPassNode);
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    translate("buttons.next"),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }
          ]),
          KeyboardActionsItem(focusNode: confirmPassNode, toolbarButtons: [
                (node) {
              return GestureDetector(
                onTap: () {
                  _signUp(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    translate("buttons.signUp"),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }
          ]),
        ]);
  }
}
