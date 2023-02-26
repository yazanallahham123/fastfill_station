// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginBody _$LoginBodyFromJson(Map<String, dynamic> json) => LoginBody(
      password: json['password'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      language: json['language'] as int?,
    );

Map<String, dynamic> _$LoginBodyToJson(LoginBody instance) => <String, dynamic>{
      'password': instance.password,
      'mobileNumber': instance.mobileNumber,
      'language': instance.language,
    };
