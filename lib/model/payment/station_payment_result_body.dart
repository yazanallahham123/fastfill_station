import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'station_payment_result_body.g.dart';

@JsonSerializable()
class StationPaymentResultBody extends Equatable {
  final String date;
  final String userName;
  final String mobileNumber;
  final int fuelTypeId;
  final double amount;
  final double value;
  final bool status;
  final bool fromList;

  const StationPaymentResultBody({
    required this.date,
    required this.userName,
    required this.mobileNumber,
    required this.fuelTypeId,
    required this.amount,
    required this.value,
    required this.status,
    required this.fromList
  });

  factory StationPaymentResultBody.fromJson(Map<String, dynamic> json) =>
      _$StationPaymentResultBodyFromJson(json);

  Map<String, dynamic> toJson() => _$StationPaymentResultBodyToJson(this);

  @override
  List<Object?> get props =>
      [  this.date,
         this.userName,
         this.mobileNumber,
         this.fuelTypeId,
         this.amount,
         this.value,
         this.status,
         this.fromList];
}
