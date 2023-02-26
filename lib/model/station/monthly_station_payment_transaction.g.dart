// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_station_payment_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonthlyStationPaymentTransaction _$MonthlyStationPaymentTransactionFromJson(
        Map<String, dynamic> json) =>
    MonthlyStationPaymentTransaction(
      amount: (json['amount'] as num?)?.toDouble(),
      month: json['month'] as int?,
      year: json['year'] as int?,
      count: json['count'] as int?,
    );

Map<String, dynamic> _$MonthlyStationPaymentTransactionToJson(
        MonthlyStationPaymentTransaction instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'month': instance.month,
      'year': instance.year,
      'count': instance.count,
    };
