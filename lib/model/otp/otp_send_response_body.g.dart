// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_send_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTPSendResponseBody _$OTPSendResponseBodyFromJson(Map<String, dynamic> json) =>
    OTPSendResponseBody(
      otp_id: json['otp_id'] as String,
      status: json['status'] as String,
      expiry: json['expiry'] as int,
    );

Map<String, dynamic> _$OTPSendResponseBodyToJson(
        OTPSendResponseBody instance) =>
    <String, dynamic>{
      'otp_id': instance.otp_id,
      'status': instance.status,
      'expiry': instance.expiry,
    };
