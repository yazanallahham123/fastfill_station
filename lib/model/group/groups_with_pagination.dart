import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../common/pagination_info.dart';
import 'group.dart';

part 'groups_with_pagination.g.dart';

@JsonSerializable()
class GroupsWithPagination extends Equatable {
  List<Group>? groups;
  PaginationInfo? paginationInfo;

  GroupsWithPagination(
      {this.groups,
        this.paginationInfo});

  factory GroupsWithPagination.fromJson(Map<String, dynamic> json) => _$GroupsWithPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$GroupsWithPaginationToJson(this);

  @override
  List<Object?> get props => [
    this.groups,
    this.paginationInfo
  ];
}