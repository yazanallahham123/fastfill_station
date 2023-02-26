import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'total_station_payment_transactions.g.dart';

@JsonSerializable()
class TotalStationPaymentTransactions extends Equatable {
  final int? count;
  final double? amount;


  const TotalStationPaymentTransactions(
      {this.count, this.amount});

  factory TotalStationPaymentTransactions.fromJson(Map<String, dynamic> json) => _$TotalStationPaymentTransactionsFromJson(json);

  Map<String, dynamic> toJson() => _$TotalStationPaymentTransactionsToJson(this);

  @override
  List<Object?> get props => [
    this.count,
    this.amount
  ];
}