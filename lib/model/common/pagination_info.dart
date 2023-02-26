import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_info.g.dart';

@JsonSerializable()
class PaginationInfo extends Equatable {
  final bool? hasNext;
  final bool? hasPrevious;
  final int? pageNo;
  final int? pageSize;
  final int? totalItems;
  final int? totalPages;

  const PaginationInfo({this.hasNext, this.hasPrevious, this.pageNo, this.pageSize, this.totalItems, this.totalPages});

  factory PaginationInfo.fromJson(Map<String, dynamic> json) =>
      _$PaginationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationInfoToJson(this);

  @override
  List<Object?> get props => [this.hasNext, this.hasPrevious, this.pageNo, this.pageSize, this.totalItems, this.totalPages];
}