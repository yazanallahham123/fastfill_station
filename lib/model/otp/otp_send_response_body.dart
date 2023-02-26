import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'otp_send_response_body.g.dart';

@JsonSerializable()
class OTPSendResponseBody extends Equatable {
  final String otp_id;
  final String status;
  final int expiry;

  const OTPSendResponseBody({required this.otp_id, required this.status, required this.expiry});

  factory OTPSendResponseBody.fromJson(Map<String, dynamic> json) =>
      _$OTPSendResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$OTPSendResponseBodyToJson(this);

  @override
  List<Object?> get props =>
      [this.otp_id, this.status, this.expiry];
}
