// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileBody _$UpdateProfileBodyFromJson(Map<String, dynamic> json) =>
    UpdateProfileBody(
      name: json['name'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      imageURL: json['imageURL'] as String?,
    );

Map<String, dynamic> _$UpdateProfileBodyToJson(UpdateProfileBody instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mobileNumber': instance.mobileNumber,
      'imageURL': instance.imageURL,
    };
