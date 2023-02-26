// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_station_payment_transactions_with_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonthlyStationPaymentTransactionsWithPagination
    _$MonthlyStationPaymentTransactionsWithPaginationFromJson(
            Map<String, dynamic> json) =>
        MonthlyStationPaymentTransactionsWithPagination(
          monthlyStationPaymentTransactions:
              (json['monthlyStationPaymentTransactions'] as List<dynamic>?)
                  ?.map((e) => MonthlyStationPaymentTransaction.fromJson(
                      e as Map<String, dynamic>))
                  .toList(),
          paginationInfo: json['paginationInfo'] == null
              ? null
              : PaginationInfo.fromJson(
                  json['paginationInfo'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MonthlyStationPaymentTransactionsWithPaginationToJson(
        MonthlyStationPaymentTransactionsWithPagination instance) =>
    <String, dynamic>{
      'monthlyStationPaymentTransactions':
          instance.monthlyStationPaymentTransactions,
      'paginationInfo': instance.paginationInfo,
    };
