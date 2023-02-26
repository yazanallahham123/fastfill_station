// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_with_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsWithPagination _$NotificationsWithPaginationFromJson(
        Map<String, dynamic> json) =>
    NotificationsWithPagination(
      notifications: (json['notifications'] as List<dynamic>?)
          ?.map((e) => NotificationBody.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginationInfo: json['paginationInfo'] == null
          ? null
          : PaginationInfo.fromJson(
              json['paginationInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationsWithPaginationToJson(
        NotificationsWithPagination instance) =>
    <String, dynamic>{
      'notifications': instance.notifications,
      'paginationInfo': instance.paginationInfo,
    };
