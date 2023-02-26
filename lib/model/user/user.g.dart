// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      username: json['username'] as String?,
      roleId: json['roleId'] as int?,
      mobileNumber: json['mobileNumber'] as String?,
      disabled: json['disabled'] as bool?,
      imageURL: json['imageURL'] as String?,
      companyId: json['companyId'] as int?,
      company: json['company'] == null
          ? null
          : Station.fromJson(json['company'] as Map<String, dynamic>),
      language: json['language'] as int?,
      groupId: json['groupId'] as int?,
      group: json['group'] == null
          ? null
          : Group.fromJson(json['group'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'username': instance.username,
      'roleId': instance.roleId,
      'mobileNumber': instance.mobileNumber,
      'disabled': instance.disabled,
      'imageURL': instance.imageURL,
      'companyId': instance.companyId,
      'company': instance.company,
      'language': instance.language,
      'groupId': instance.groupId,
      'group': instance.group,
    };
