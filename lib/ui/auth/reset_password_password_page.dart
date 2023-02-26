import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../bloc/user/bloc.dart';
import '../../bloc/user/event.dart';
import '../../bloc/user/state.dart';
import '../../common_widget/app_widgets/back_button_widget.dart';
import '../../common_widget/app_widgets/custom_loading.dart';
import '../../common_widget/buttons/custom_button.dart';
import '../../common_widget/custom_text_field_widgets/methods.dart';
import '../../common_widget/custom_text_field_widgets/textfield_password_widget.dart';
import '../../helper/app_colors.dart';
import '../../helper/const_styles.dart';
import '../../helper/size_config.dart';
import '../../helper/toast.dart';
import '../../model/user/reset_password_body.dart';
import '../../utils/misc.dart';
import 'login_page.dart';

class ResetPassword_PasswordPage extends StatelessWidget {
  static const route = "/resetpassword_password_page";

  final ResetPasswordBody resetPasswordBody;

  const ResetPassword_PasswordPage({Key? key, required this.resetPasswordBody})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc()..add(UserInitEvent()),
          child: Builder(builder: (context) => _buildPage(context)));
  }


  Widget _buildPage(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
        listener: (context, state) async {
          if (state is ErrorUserState)
            pushToast(state.error);
          else if (state is PasswordResetState) {
            if (state.passwordReset == "Updated successfully.") {
              pushToast(translate("messages.passwordResetIsSuccessful"));


              Navigator.pushNamedAndRemoveUntil(context, LoginPage.route,(Route<dynamic> route) => false);
            }
            else
              pushToast(translate("messages.passwordResetIsNotSuccessful"));
          }
        },
        child: BlocBuilder(
            bloc: userBloc,
            builder: (context, UserState userState) {
              return _BuildUI(userBloc: userBloc, userState: userState, resetPasswordBody: resetPasswordBody);
            })
    );
  }
}


class _BuildUI extends StatelessWidget {
  final UserBloc userBloc;
  final UserState userState;
  final ResetPasswordBody resetPasswordBody;

  //final phoneController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  //final phoneNode = FocusNode();
  final newPasswordNode = FocusNode();
  final confirmNewPasswordNode = FocusNode();


  _BuildUI({required this.userBloc, required this.userState, required this.resetPasswordBody});

  @override
  Widget build(BuildContext context) {

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
                padding: EdgeInsets.symmetric(horizontal: SizeConfig().w(24)),
                decoration:
                BoxDecoration(color: Colors.white, borderRadius: radiusAll20),
                child: Column(
                  children: [
                Padding(
                padding: EdgeInsetsDirectional.only(top: SizeConfig().h(40)),
              child:
              TextFieldPasswordWidget(
                        controller: newPasswordController,
                        focusNode: newPasswordNode,
                        hintText: translate("labels.newPassword"),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(confirmNewPasswordNode);
                        })),
                    TextFieldPasswordWidget(
                        controller: confirmNewPasswordController,
                        focusNode: confirmNewPasswordNode,
                        hintText: translate("labels.confirmNewPassword"),
                        textInputAction: TextInputAction.go,
                        onFieldSubmitted: (_) {
                          _resetPassword(context);
                        }),

                    if (userState is LoadingUserState)
                      Padding(child: const CustomLoading(),
                        padding: EdgeInsetsDirectional.only(top: SizeConfig().h(10), bottom:SizeConfig().h(35)),)
                    else
                    Padding(
                        padding: EdgeInsetsDirectional.only(
                            top: SizeConfig().h(10), bottom: SizeConfig().h(35)),
                        child: CustomButton(
                            backColor: buttonColor1,
                            titleColor: Colors.white,
                            borderColor: buttonColor1,
                            title: translate("buttons.resetPassword"),
                            onTap: () {
                              _resetPassword(context);
                              //Navigator.pushNamed(context, OTPValidationPage.route);
                            })),
                  ],
                ),
              ),
              // Back Button
              BackButtonWidget(context)
            ])));
  }

  void _resetPassword(BuildContext context) async {

    if (newPasswordController.text.isNotEmpty) { //&& newPasswordController.text.isNotEmpty) {
      if (!validateName(newPasswordController.text))
        FocusScope.of(context).requestFocus(newPasswordNode);
      else
      if (!validateName(confirmNewPasswordController.text))
        FocusScope.of(context).requestFocus(confirmNewPasswordNode);
      else
      if (confirmNewPasswordController.text != newPasswordController.text)
        FocusScope.of(context).requestFocus(confirmNewPasswordNode);
      else {


        hideKeyboard(context);
        String pn = "";
        if (resetPasswordBody.mobileNumber != null) {
          if ((resetPasswordBody.mobileNumber!.length == 9) ||
              (resetPasswordBody.mobileNumber!.length == 10)) {
            if ((resetPasswordBody.mobileNumber!.length == 10) &&
                (resetPasswordBody.mobileNumber!.substring(0, 1) == "0")) {
              pn = resetPasswordBody.mobileNumber!
                  .substring(1, resetPasswordBody.mobileNumber!.length);
            } else {
              if (resetPasswordBody.mobileNumber!.length == 9) {
                pn = resetPasswordBody.mobileNumber!;
              }
            }
          }
        }

        userBloc.add(ResetPasswordEvent(ResetPasswordBody(
          newPassword: newPasswordController.text,
          mobileNumber: pn,
          verificationId: resetPasswordBody.verificationId
        )));
      }
    } else
      pushToast(translate("messages.theseFieldsMustBeFilledIn"));
  }
}

