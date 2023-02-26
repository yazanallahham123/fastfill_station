// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_payment_transaction_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationPaymentTransactionBody _$StationPaymentTransactionBodyFromJson(
        Map<String, dynamic> json) =>
    StationPaymentTransactionBody(
      userId: json['userId'] as int?,
      date: json['date'] as String?,
      companyId: json['companyId'] as int?,
      fuelTypeId: json['fuelTypeId'] as int?,
      amount: (json['amount'] as num?)?.toDouble(),
      fastfill: (json['fastfill'] as num?)?.toDouble(),
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$StationPaymentTransactionBodyToJson(
        StationPaymentTransactionBody instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'date': instance.date,
      'companyId': instance.companyId,
      'fuelTypeId': instance.fuelTypeId,
      'amount': instance.amount,
      'fastfill': instance.fastfill,
      'status': instance.status,
    };
