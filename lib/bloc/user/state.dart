import 'package:equatable/equatable.dart';
import '../../model/notification/notifications_with_pagination.dart';
import '../../model/user/reset_password_body.dart';
import '../../model/user/signedup_user.dart';
import '../../model/user/signup_body.dart';
import '../../model/user/update_profile_body.dart';

abstract class UserState extends Equatable{

  const UserState();

  @override
  List<Object?> get props => [];
}

class InitUserState extends UserState{
  const InitUserState();
}

class LoadingUserState extends UserState{
  const LoadingUserState();
}

class ErrorUserState extends UserState{
  final String error;

  const ErrorUserState(this.error);

  @override
  List<Object?> get props => [this.error];
}


class PasswordResetState extends UserState{
  final String passwordReset;

  const PasswordResetState(this.passwordReset);

  @override
  List<Object?> get props => [this.passwordReset];
}

class UserProfileUpdated extends UserState{
  final String profileUpdated;

  const UserProfileUpdated(this.profileUpdated);

  @override
  List<Object?> get props => [this.profileUpdated];

}

class GotNotificationsState extends UserState{
  final NotificationsWithPagination notifications;

  const GotNotificationsState(this.notifications);

  @override
  List<Object?> get props => [this.notifications];

}

class UploadedProfilePhoto extends UserState{
  final String profilePhotoURL;

  const UploadedProfilePhoto(this.profilePhotoURL);

  @override
  List<Object?> get props => [this.profilePhotoURL];

}


class UpdatedUserLanguageState extends UserState{
  final bool result;

  const UpdatedUserLanguageState(this.result);

  @override
  List<Object?> get props => [this.result];
}

class ClearedUserNotificationsState extends UserState {
  final bool result;

  const ClearedUserNotificationsState(this.result);

  @override
  List<Object?> get props => [this.result];
}

class SignedUpState extends UserState{
  final SignedUpUser signedUpUser;

  const SignedUpState(this.signedUpUser);

  @override
  List<Object?> get props => [this.signedUpUser];
}

class RemovedAccountState extends UserState{
  final bool result;

  const RemovedAccountState(this.result);

  @override
  List<Object?> get props => [this.result];
}

class LoggedOutState extends UserState{
  final bool result;

  const LoggedOutState(this.result);

  @override
  List<Object?> get props => [this.result];
}


class CalledOTPScreenState extends UserState{
  final String registerId;
  final String mobileNumber;
  final SignupBody? signupBody;
  final UpdateProfileBody? updateProfileBody;
  final ResetPasswordBody? resetPasswordBody;
  final bool? removeAccount;

  const CalledOTPScreenState(this.registerId, this.mobileNumber, this.signupBody, this.updateProfileBody, this.resetPasswordBody, this.removeAccount);

  @override
  List<Object?> get props => [this.registerId, this.mobileNumber, this.signupBody, this.updateProfileBody, this.resetPasswordBody, this.removeAccount];
}

class SuccessfulUserOTPVerificationState extends UserState{
  final SignupBody? signupBody;
  final ResetPasswordBody? resetPasswordBody;
  final UpdateProfileBody? updateProfileBody;
  final bool? removeAccount;

  const SuccessfulUserOTPVerificationState(this.signupBody, this.resetPasswordBody, this.updateProfileBody, this.removeAccount);

  @override
  List<Object?> get props => [this.signupBody, this.resetPasswordBody, this.updateProfileBody, this.removeAccount];
}

class CheckedUserByPhoneState extends UserState {
  final bool result;
  final String mobileNumber;
  final SignupBody? signupBody;
  final UpdateProfileBody? updateProfileBody;
  final ResetPasswordBody? resetPasswordBody;
  final bool? removeAccount;

  const CheckedUserByPhoneState(this.result, this.mobileNumber, this.signupBody, this.updateProfileBody, this.resetPasswordBody, this.removeAccount);

  @override
  List<Object?> get props => [this.result, this.mobileNumber, this.signupBody,  this.updateProfileBody, this.resetPasswordBody, this.removeAccount];
}

class VerifiedOTPCode extends UserState {
  final bool result;
  final String registerId;
  final SignupBody? signupBody;
  final String mobileNumber;
  final UpdateProfileBody? updateProfileBody;
  final ResetPasswordBody? resetPasswordBody;
  final bool? removeAccount;

  const VerifiedOTPCode(this.result, this.signupBody, this.mobileNumber, this.registerId, this.updateProfileBody, this.resetPasswordBody, this.removeAccount);

  @override
  List<Object?> get props => [this.result, this.signupBody, this.mobileNumber, this.registerId, this.updateProfileBody, this.resetPasswordBody, this.removeAccount];
}


