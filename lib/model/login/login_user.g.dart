// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginUser _$LoginUserFromJson(Map<String, dynamic> json) => LoginUser(
      value: json['value'] == null
          ? null
          : Value.fromJson(json['value'] as Map<String, dynamic>),
      formatters: json['formatters'] as List<dynamic>?,
      contentTypes: json['contentTypes'] as List<dynamic>?,
      declaredType: json['declaredType'] as String?,
      statusCode: json['statusCode'] as int?,
    );

Map<String, dynamic> _$LoginUserToJson(LoginUser instance) => <String, dynamic>{
      'value': instance.value,
      'formatters': instance.formatters,
      'contentTypes': instance.contentTypes,
      'declaredType': instance.declaredType,
      'statusCode': instance.statusCode,
    };
