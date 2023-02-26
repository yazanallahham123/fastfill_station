// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_resend_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTPResendResponseBody _$OTPResendResponseBodyFromJson(
        Map<String, dynamic> json) =>
    OTPResendResponseBody(
      otp_id: json['otp_id'] as String,
      status: json['status'] as String,
      expiry: json['expiry'] as int,
      resend_count: json['resend_count'] as int,
    );

Map<String, dynamic> _$OTPResendResponseBodyToJson(
        OTPResendResponseBody instance) =>
    <String, dynamic>{
      'otp_id': instance.otp_id,
      'status': instance.status,
      'expiry': instance.expiry,
      'resend_count': instance.resend_count,
    };
