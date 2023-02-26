// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groups_with_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupsWithPagination _$GroupsWithPaginationFromJson(
        Map<String, dynamic> json) =>
    GroupsWithPagination(
      groups: (json['groups'] as List<dynamic>?)
          ?.map((e) => Group.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginationInfo: json['paginationInfo'] == null
          ? null
          : PaginationInfo.fromJson(
              json['paginationInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GroupsWithPaginationToJson(
        GroupsWithPagination instance) =>
    <String, dynamic>{
      'groups': instance.groups,
      'paginationInfo': instance.paginationInfo,
    };
