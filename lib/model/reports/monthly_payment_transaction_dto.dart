import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'monthly_payment_transaction_dto.g.dart';

@JsonSerializable()
class MonthlyPaymentTransactionDto extends Equatable {
  final int year;
  final int month;

  const MonthlyPaymentTransactionDto({
    required this.year,
    required this.month
  });

  factory MonthlyPaymentTransactionDto.fromJson(Map<String, dynamic> json) =>
      _$MonthlyPaymentTransactionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MonthlyPaymentTransactionDtoToJson(this);

  @override
  List<Object?> get props =>
      [  this.year,
        this.month];
}
