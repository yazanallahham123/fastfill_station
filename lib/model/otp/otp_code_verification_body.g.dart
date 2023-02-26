// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_code_verification_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTPCodeVerificationBody _$OTPCodeVerificationBodyFromJson(
        Map<String, dynamic> json) =>
    OTPCodeVerificationBody(
      code: json['code'] as String,
      registerId: json['registerId'] as String,
    );

Map<String, dynamic> _$OTPCodeVerificationBodyToJson(
        OTPCodeVerificationBody instance) =>
    <String, dynamic>{
      'code': instance.code,
      'registerId': instance.registerId,
    };
