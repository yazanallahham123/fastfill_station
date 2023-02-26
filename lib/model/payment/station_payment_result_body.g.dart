// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_payment_result_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationPaymentResultBody _$StationPaymentResultBodyFromJson(
        Map<String, dynamic> json) =>
    StationPaymentResultBody(
      date: json['date'] as String,
      userName: json['userName'] as String,
      mobileNumber: json['mobileNumber'] as String,
      fuelTypeId: json['fuelTypeId'] as int,
      amount: (json['amount'] as num).toDouble(),
      value: (json['value'] as num).toDouble(),
      status: json['status'] as bool,
      fromList: json['fromList'] as bool,
    );

Map<String, dynamic> _$StationPaymentResultBodyToJson(
        StationPaymentResultBody instance) =>
    <String, dynamic>{
      'date': instance.date,
      'userName': instance.userName,
      'mobileNumber': instance.mobileNumber,
      'fuelTypeId': instance.fuelTypeId,
      'amount': instance.amount,
      'value': instance.value,
      'status': instance.status,
      'fromList': instance.fromList,
    };
