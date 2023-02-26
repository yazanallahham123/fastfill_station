import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'otp_verify_response_body.g.dart';

@JsonSerializable()
class OTPVerifyResponseBody extends Equatable {
  final String status;

  const OTPVerifyResponseBody({required this.status});

  factory OTPVerifyResponseBody.fromJson(Map<String, dynamic> json) =>
      _$OTPVerifyResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$OTPVerifyResponseBodyToJson(this);

  @override
  List<Object?> get props =>
      [this.status];
}
