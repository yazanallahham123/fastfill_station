// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_payment_transaction_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationPaymentTransactionResult _$StationPaymentTransactionResultFromJson(
        Map<String, dynamic> json) =>
    StationPaymentTransactionResult(
      id: json['id'] as int?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      userId: json['userId'] as int?,
      date: json['date'] as String?,
      companyId: json['companyId'] as int?,
      fuelTypeId: json['fuelTypeId'] as int?,
      amount: (json['amount'] as num?)?.toDouble(),
      fastfill: (json['fastfill'] as num?)?.toDouble(),
      status: json['status'] as bool?,
      dailyId: json['dailyId'] as int?,
    );

Map<String, dynamic> _$StationPaymentTransactionResultToJson(
        StationPaymentTransactionResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'userId': instance.userId,
      'date': instance.date,
      'companyId': instance.companyId,
      'fuelTypeId': instance.fuelTypeId,
      'amount': instance.amount,
      'fastfill': instance.fastfill,
      'status': instance.status,
      'dailyId': instance.dailyId,
    };
