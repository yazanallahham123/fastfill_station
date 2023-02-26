// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verification_phone_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTPVerificationPhoneBody _$OTPVerificationPhoneBodyFromJson(
        Map<String, dynamic> json) =>
    OTPVerificationPhoneBody(
      registerId: json['registerId'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$OTPVerificationPhoneBodyToJson(
        OTPVerificationPhoneBody instance) =>
    <String, dynamic>{
      'registerId': instance.registerId,
      'phoneNumber': instance.phoneNumber,
    };
