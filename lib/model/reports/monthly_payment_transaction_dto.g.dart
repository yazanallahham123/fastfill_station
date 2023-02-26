// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_payment_transaction_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonthlyPaymentTransactionDto _$MonthlyPaymentTransactionDtoFromJson(
        Map<String, dynamic> json) =>
    MonthlyPaymentTransactionDto(
      year: json['year'] as int,
      month: json['month'] as int,
    );

Map<String, dynamic> _$MonthlyPaymentTransactionDtoToJson(
        MonthlyPaymentTransactionDto instance) =>
    <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
    };
