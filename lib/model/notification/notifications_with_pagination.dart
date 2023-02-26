import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../common/pagination_info.dart';
import 'notification_body.dart';

part 'notifications_with_pagination.g.dart';

@JsonSerializable()
class NotificationsWithPagination extends Equatable {
  final List<NotificationBody>? notifications;
  final PaginationInfo? paginationInfo;

  const NotificationsWithPagination(
      {this.notifications, this.paginationInfo});

  factory NotificationsWithPagination.fromJson(Map<String, dynamic> json) => _$NotificationsWithPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsWithPaginationToJson(this);

  @override
  List<Object?> get props =>
      [this.notifications, this.paginationInfo];

}