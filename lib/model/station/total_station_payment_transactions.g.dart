// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_station_payment_transactions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalStationPaymentTransactions _$TotalStationPaymentTransactionsFromJson(
        Map<String, dynamic> json) =>
    TotalStationPaymentTransactions(
      count: json['count'] as int?,
      amount: (json['amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TotalStationPaymentTransactionsToJson(
        TotalStationPaymentTransactions instance) =>
    <String, dynamic>{
      'count': instance.count,
      'amount': instance.amount,
    };
