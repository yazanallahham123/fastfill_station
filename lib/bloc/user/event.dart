import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../model/user/reset_password_body.dart';
import '../../model/user/signup_body.dart';
import '../../model/user/update_profile_body.dart';

abstract class UserEvent extends Equatable{

  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UserInitEvent extends UserEvent {
  const UserInitEvent();
}


class SuccessfulUserOTPVerificationEvent extends UserEvent{
  final SignupBody? signupBody;
  final ResetPasswordBody? resetPasswordBody;
  final UpdateProfileBody? updateProfileBody;
  final bool? removeAccount;

  const SuccessfulUserOTPVerificationEvent(this.signupBody, this.resetPasswordBody, this.updateProfileBody, this.removeAccount);

  @override
  List<Object?> get props => [this.signupBody, this.resetPasswordBody, this.updateProfileBody, this.removeAccount];
}

class ErrorUserOTPVerificationEvent extends UserEvent{
  final String errorMessage;
  const ErrorUserOTPVerificationEvent(this.errorMessage);

  @override
  List<Object?> get props => [this.errorMessage];
}

class CallOTPScreenEvent extends UserEvent{
  final String mobileNumber;
  final SignupBody? signupBody;
  final UpdateProfileBody? updateProfileBody;
  final ResetPasswordBody? resetPasswordBody;
  final bool? removeAccount;

  const CallOTPScreenEvent(this.mobileNumber, this.signupBody, this.updateProfileBody, this.resetPasswordBody, this.removeAccount);

  @override
  List<Object?> get props => [this.mobileNumber, this.signupBody, this.updateProfileBody, this.resetPasswordBody, this.removeAccount];
}

class VerifyOTPEvent extends UserEvent{
  final String registerId;
  final String code;
  final SignupBody? signupBody;
  final String mobileNumber;
  final UpdateProfileBody? updateProfileBody;
  final ResetPasswordBody? resetPasswordBody;
  final bool? removeAccount;

  const VerifyOTPEvent(this.registerId, this.code, this.signupBody, this.mobileNumber, this.updateProfileBody, this.resetPasswordBody, this.removeAccount);

  @override
  List<Object?> get props => [this.registerId, this.code, this.signupBody, this.mobileNumber, this.updateProfileBody, this.resetPasswordBody, this.removeAccount];
}

class ResetPasswordEvent extends UserEvent{
  final ResetPasswordBody? resetPasswordBody;

  const ResetPasswordEvent(this.resetPasswordBody);

  @override
  List<Object?> get props => [this.resetPasswordBody];
}

class UpdateProfileEvent extends UserEvent{
  final UpdateProfileBody updateProfileBody;

  const UpdateProfileEvent(this.updateProfileBody);

  @override
  List<Object?> get props => [this.updateProfileBody];
}

class GetNotificationsEvent extends UserEvent{
  final int page;
  const GetNotificationsEvent(this.page);

  @override
  List<Object?> get props => [this.page];
}

class UploadProfileImageEvent extends UserEvent{
  final File imageFile;

  const UploadProfileImageEvent(this.imageFile);

  @override
  List<Object?> get props => [this.imageFile];
}


class UpdateUserLanguageEvent extends UserEvent {
  final int languageId;

  const UpdateUserLanguageEvent(this.languageId);

  @override
  List<Object?> get props => [this.languageId];
}

class ClearUserNotificationsEvent extends UserEvent {
  const ClearUserNotificationsEvent();
}

class SignupEvent extends UserEvent{
  final SignupBody? signupBody;

  const SignupEvent(this.signupBody);

  @override
  List<Object?> get props => [this.signupBody];
}

class RemoveAccountEvent extends UserEvent{
  const RemoveAccountEvent();
}

class LogoutEvent extends UserEvent{
  const LogoutEvent();
}

class CheckUserByPhoneEvent extends UserEvent {
  final String mobileNumber;
  final SignupBody? signupBody;
  final UpdateProfileBody? updateProfileBody;
  final ResetPasswordBody? resetPasswordBody;
  final bool? removeAccount;

  const CheckUserByPhoneEvent(this.mobileNumber, this.signupBody, this.updateProfileBody, this.resetPasswordBody, this.removeAccount);

  @override
  List<Object?> get props => [this.mobileNumber, this.signupBody, this.updateProfileBody, this.resetPasswordBody, this.removeAccount];
}


