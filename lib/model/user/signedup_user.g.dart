// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signedup_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignedUpUser _$SignedUpUserFromJson(Map<String, dynamic> json) => SignedUpUser(
      token: json['token'] as String?,
      userDetails: json['userDetails'] == null
          ? null
          : User.fromJson(json['userDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignedUpUserToJson(SignedUpUser instance) =>
    <String, dynamic>{
      'token': instance.token,
      'userDetails': instance.userDetails,
    };
