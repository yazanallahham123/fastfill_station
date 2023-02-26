import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'monthly_station_payment_transaction.g.dart';

@JsonSerializable()
class MonthlyStationPaymentTransaction extends Equatable {
  final double? amount;
  final int? month;
  final int? year;
  final int? count;

  const MonthlyStationPaymentTransaction(
      {this.amount,
        this.month,
        this.year,
        this.count});

  factory MonthlyStationPaymentTransaction.fromJson(Map<String, dynamic> json) => _$MonthlyStationPaymentTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$MonthlyStationPaymentTransactionToJson(this);

  @override
  List<Object?> get props => [
    this.amount,
    this.month,
    this.year,
    this.count
  ];
}