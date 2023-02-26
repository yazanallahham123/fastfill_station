import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../user/user.dart';

part 'station_payment_transaction_result.g.dart';

@JsonSerializable()
class StationPaymentTransactionResult extends Equatable {
  final int? id;
  final User? user;
  final int? userId;
  final String? date;
  final int? companyId;
  final int? fuelTypeId;
  final double? amount;
  final double? fastfill;
  final bool? status;
  final int? dailyId;

  const StationPaymentTransactionResult(
      {this.id,
        this.user,
        this.userId,
        this.date,
        this.companyId,
        this.fuelTypeId,
        this.amount,
        this.fastfill,
        this.status,
        this.dailyId

      });

  factory StationPaymentTransactionResult.fromJson(Map<String, dynamic> json) => _$StationPaymentTransactionResultFromJson(json);

  Map<String, dynamic> toJson() => _$StationPaymentTransactionResultToJson(this);

  @override
  List<Object?> get props => [
    this.id,
    this.user,
    this.userId,
    this.date,
    this.companyId,
    this.fuelTypeId,
    this.amount,
    this.fastfill,
    this.status,
    this.dailyId
  ];
}