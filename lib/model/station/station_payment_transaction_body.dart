import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'station_payment_transaction_body.g.dart';

@JsonSerializable()
class StationPaymentTransactionBody extends Equatable {
  final int? userId;
  final String? date;
  final int? companyId;
  final int? fuelTypeId;
  final double? amount;
  final double? fastfill;
  final bool? status;

  const StationPaymentTransactionBody(
      {this.userId,
        this.date,
        this.companyId,
        this.fuelTypeId,
        this.amount,
        this.fastfill,
        this.status});

  factory StationPaymentTransactionBody.fromJson(Map<String, dynamic> json) => _$StationPaymentTransactionBodyFromJson(json);

  Map<String, dynamic> toJson() => _$StationPaymentTransactionBodyToJson(this);

  @override
  List<Object?> get props => [
    this.userId,
    this.date,
    this.companyId,
    this.fuelTypeId,
    this.amount,
    this.fastfill,
    this.status
  ];
}