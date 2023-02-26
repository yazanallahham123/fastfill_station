import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'otp_verification_phone_body.g.dart';

@JsonSerializable()
class OTPVerificationPhoneBody extends Equatable {
  final String registerId;
  final String phoneNumber;

  const OTPVerificationPhoneBody({required this.registerId, required this.phoneNumber});

  factory OTPVerificationPhoneBody.fromJson(Map<String, dynamic> json) =>
      _$OTPVerificationPhoneBodyFromJson(json);

  Map<String, dynamic> toJson() => _$OTPVerificationPhoneBodyToJson(this);

  @override
  List<Object?> get props =>
      [this.registerId, this.phoneNumber];
}
