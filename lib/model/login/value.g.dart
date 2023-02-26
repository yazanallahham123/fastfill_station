// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Value _$ValueFromJson(Map<String, dynamic> json) => Value(
      token: json['token'] as String?,
      userDetails: json['userDetails'] == null
          ? null
          : User.fromJson(json['userDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ValueToJson(Value instance) => <String, dynamic>{
      'token': instance.token,
      'userDetails': instance.userDetails,
    };
