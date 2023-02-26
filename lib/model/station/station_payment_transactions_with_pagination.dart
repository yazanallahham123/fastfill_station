import 'package:equatable/equatable.dart';
import 'package:fastfill_station_app/model/station/station_payment_transaction_result.dart';
import 'package:json_annotation/json_annotation.dart';

import '../common/pagination_info.dart';

part 'station_payment_transactions_with_pagination.g.dart';

@JsonSerializable()
class StationPaymentTransactionsWithPagination extends Equatable {
  final List<StationPaymentTransactionResult>? stationPaymentTransactions;
  final PaginationInfo? paginationInfo;

  const StationPaymentTransactionsWithPagination(
      {this.stationPaymentTransactions, this.paginationInfo});

  factory StationPaymentTransactionsWithPagination.fromJson(Map<String, dynamic> json) => _$StationPaymentTransactionsWithPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$StationPaymentTransactionsWithPaginationToJson(this);

  @override
  List<Object?> get props =>
      [this.stationPaymentTransactions, this.paginationInfo];

}