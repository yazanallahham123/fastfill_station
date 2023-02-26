// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordBody _$ResetPasswordBodyFromJson(Map<String, dynamic> json) =>
    ResetPasswordBody(
      mobileNumber: json['mobileNumber'] as String?,
      newPassword: json['newPassword'] as String?,
      verificationId: json['verificationId'] as String?,
    );

Map<String, dynamic> _$ResetPasswordBodyToJson(ResetPasswordBody instance) =>
    <String, dynamic>{
      'mobileNumber': instance.mobileNumber,
      'newPassword': instance.newPassword,
      'verificationId': instance.verificationId,
    };
