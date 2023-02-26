// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_payment_transactions_with_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationPaymentTransactionsWithPagination
    _$StationPaymentTransactionsWithPaginationFromJson(
            Map<String, dynamic> json) =>
        StationPaymentTransactionsWithPagination(
          stationPaymentTransactions:
              (json['stationPaymentTransactions'] as List<dynamic>?)
                  ?.map((e) => StationPaymentTransactionResult.fromJson(
                      e as Map<String, dynamic>))
                  .toList(),
          paginationInfo: json['paginationInfo'] == null
              ? null
              : PaginationInfo.fromJson(
                  json['paginationInfo'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$StationPaymentTransactionsWithPaginationToJson(
        StationPaymentTransactionsWithPagination instance) =>
    <String, dynamic>{
      'stationPaymentTransactions': instance.stationPaymentTransactions,
      'paginationInfo': instance.paginationInfo,
    };
