// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationInfo _$PaginationInfoFromJson(Map<String, dynamic> json) =>
    PaginationInfo(
      hasNext: json['hasNext'] as bool?,
      hasPrevious: json['hasPrevious'] as bool?,
      pageNo: json['pageNo'] as int?,
      pageSize: json['pageSize'] as int?,
      totalItems: json['totalItems'] as int?,
      totalPages: json['totalPages'] as int?,
    );

Map<String, dynamic> _$PaginationInfoToJson(PaginationInfo instance) =>
    <String, dynamic>{
      'hasNext': instance.hasNext,
      'hasPrevious': instance.hasPrevious,
      'pageNo': instance.pageNo,
      'pageSize': instance.pageSize,
      'totalItems': instance.totalItems,
      'totalPages': instance.totalPages,
    };
