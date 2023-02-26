import 'package:equatable/equatable.dart';
import 'package:fastfill_station_app/model/station/monthly_station_payment_transaction.dart';
import 'package:json_annotation/json_annotation.dart';

import '../common/pagination_info.dart';

part 'monthly_station_payment_transactions_with_pagination.g.dart';

@JsonSerializable()
class MonthlyStationPaymentTransactionsWithPagination extends Equatable {
  final List<MonthlyStationPaymentTransaction>? monthlyStationPaymentTransactions;
  final PaginationInfo? paginationInfo;

  const MonthlyStationPaymentTransactionsWithPagination(
      {this.monthlyStationPaymentTransactions, this.paginationInfo});

  factory MonthlyStationPaymentTransactionsWithPagination.fromJson(Map<String, dynamic> json) => _$MonthlyStationPaymentTransactionsWithPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$MonthlyStationPaymentTransactionsWithPaginationToJson(this);

  @override
  List<Object?> get props =>
      [this.monthlyStationPaymentTransactions, this.paginationInfo];

}