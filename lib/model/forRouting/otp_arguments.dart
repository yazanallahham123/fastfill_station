
import '../user/change_mobile_number_body.dart';
import '../user/reset_password_body.dart';
import 'enums.dart';

class OTPArguments {
  final OtpForType otpForType;
  final ResetPasswordBody? resetPasswordBody;
  final ChangeMobileNumberBody? changeMobileNumberBody;
  const OTPArguments({required this.otpForType, this.resetPasswordBody, this.changeMobileNumberBody});
}