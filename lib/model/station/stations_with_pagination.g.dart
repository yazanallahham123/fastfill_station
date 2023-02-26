// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stations_with_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationsWithPagination _$StationsWithPaginationFromJson(
        Map<String, dynamic> json) =>
    StationsWithPagination(
      companies: (json['companies'] as List<dynamic>?)
          ?.map((e) =>
              StationWithTransactionsTotal.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginationInfo: json['paginationInfo'] == null
          ? null
          : PaginationInfo.fromJson(
              json['paginationInfo'] as Map<String, dynamic>),
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      totalCount: json['totalCount'] as int?,
    );

Map<String, dynamic> _$StationsWithPaginationToJson(
        StationsWithPagination instance) =>
    <String, dynamic>{
      'companies': instance.companies,
      'paginationInfo': instance.paginationInfo,
      'totalCount': instance.totalCount,
      'totalAmount': instance.totalAmount,
    };
