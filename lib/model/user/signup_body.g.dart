// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupBody _$SignupBodyFromJson(Map<String, dynamic> json) => SignupBody(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      language: json['language'] as int?,
    );

Map<String, dynamic> _$SignupBodyToJson(SignupBody instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'username': instance.username,
      'password': instance.password,
      'mobileNumber': instance.mobileNumber,
      'language': instance.language,
    };
