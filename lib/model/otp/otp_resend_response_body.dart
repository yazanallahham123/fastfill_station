import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'otp_resend_response_body.g.dart';

@JsonSerializable()
class OTPResendResponseBody extends Equatable {
  final String otp_id;
  final String status;
  final int expiry;
  final int resend_count;

  const OTPResendResponseBody({required this.otp_id, required this.status, required this.expiry, required this.resend_count});

  factory OTPResendResponseBody.fromJson(Map<String, dynamic> json) =>
      _$OTPResendResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$OTPResendResponseBodyToJson(this);

  @override
  List<Object?> get props =>
      [this.otp_id, this.status, this.expiry, this.resend_count];
}
