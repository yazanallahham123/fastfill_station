import 'package:equatable/equatable.dart';
import 'package:fastfill_station_app/model/station/station_with_transactions_total.dart';
import 'package:json_annotation/json_annotation.dart';

import '../common/pagination_info.dart';
import 'station.dart';

part 'stations_with_pagination.g.dart';

@JsonSerializable()
class StationsWithPagination extends Equatable {
  final List<StationWithTransactionsTotal>? companies;
  final PaginationInfo? paginationInfo;
  final int? totalCount;
  final double? totalAmount;

  const StationsWithPagination(
      {this.companies, this.paginationInfo, this.totalAmount, this.totalCount});

  factory StationsWithPagination.fromJson(Map<String, dynamic> json) => _$StationsWithPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$StationsWithPaginationToJson(this);

  @override
  List<Object?> get props =>
      [this.companies, this.paginationInfo, this.totalAmount, this.totalCount];

}