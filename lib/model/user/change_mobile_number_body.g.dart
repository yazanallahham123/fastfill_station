// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_mobile_number_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeMobileNumberBody _$ChangeMobileNumberBodyFromJson(
        Map<String, dynamic> json) =>
    ChangeMobileNumberBody(
      oldMobileNumber: json['oldMobileNumber'] as String?,
      newMobileNumber: json['newMobileNumber'] as String?,
      oldMobileNumberOtp_id: json['oldMobileNumberOtp_id'] as String?,
      newMobileNumberOtp_id: json['newMobileNumberOtp_id'] as String?,
    );

Map<String, dynamic> _$ChangeMobileNumberBodyToJson(
        ChangeMobileNumberBody instance) =>
    <String, dynamic>{
      'oldMobileNumber': instance.oldMobileNumber,
      'newMobileNumber': instance.newMobileNumber,
      'oldMobileNumberOtp_id': instance.oldMobileNumberOtp_id,
      'newMobileNumberOtp_id': instance.newMobileNumberOtp_id,
    };
