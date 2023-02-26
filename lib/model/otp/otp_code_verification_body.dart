import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'otp_code_verification_body.g.dart';

@JsonSerializable()
class OTPCodeVerificationBody extends Equatable {
  final String code;
  final String registerId;

  const OTPCodeVerificationBody({required this.code, required this.registerId});

  factory OTPCodeVerificationBody.fromJson(Map<String, dynamic> json) =>
      _$OTPCodeVerificationBodyFromJson(json);

  Map<String, dynamic> toJson() => _$OTPCodeVerificationBodyToJson(this);

  @override
  List<Object?> get props =>
      [this.code, this.registerId];
}
