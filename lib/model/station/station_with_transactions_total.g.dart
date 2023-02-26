// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_with_transactions_total.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationWithTransactionsTotal _$StationWithTransactionsTotalFromJson(
        Map<String, dynamic> json) =>
    StationWithTransactionsTotal(
      id: json['id'] as int?,
      arabicName: json['arabicName'] as String?,
      englishName: json['englishName'] as String?,
      code: json['code'] as String?,
      arabicAddress: json['arabicAddress'] as String?,
      englishAddress: json['englishAddress'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      isFavorite: json['isFavorite'] as bool?,
      groupId: json['groupId'] as int?,
      group: json['group'] == null
          ? null
          : Group.fromJson(json['group'] as Map<String, dynamic>),
      count: json['count'] as int?,
      amount: (json['amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StationWithTransactionsTotalToJson(
        StationWithTransactionsTotal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'arabicName': instance.arabicName,
      'englishName': instance.englishName,
      'code': instance.code,
      'arabicAddress': instance.arabicAddress,
      'englishAddress': instance.englishAddress,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'isFavorite': instance.isFavorite,
      'groupId': instance.groupId,
      'group': instance.group,
      'count': instance.count,
      'amount': instance.amount,
    };
