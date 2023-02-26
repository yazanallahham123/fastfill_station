import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../group/group.dart';

part 'station_with_transactions_total.g.dart';

@JsonSerializable()
class StationWithTransactionsTotal extends Equatable {
  final int? id;
  final String? arabicName;
  final String? englishName;
  final String? code;
  final String? arabicAddress;
  final String? englishAddress;
  final double? longitude;
  final double? latitude;
  final bool? isFavorite;
  final int? groupId;
  final Group? group;
  final int? count;
  final double? amount;

  const StationWithTransactionsTotal(
      {this.id,
        this.arabicName,
        this.englishName,
        this.code,
        this.arabicAddress,
        this.englishAddress,
        this.longitude,
        this.latitude,
        this.isFavorite,
        this.groupId,
        this.group,
        this.count,
        this.amount});

  factory StationWithTransactionsTotal.fromJson(Map<String, dynamic> json) => _$StationWithTransactionsTotalFromJson(json);

  Map<String, dynamic> toJson() => _$StationWithTransactionsTotalToJson(this);

  @override
  List<Object?> get props => [
    this.id,
    this.arabicName,
    this.englishName,
    this.code,
    this.arabicAddress,
    this.englishAddress,
    this.longitude,
    this.latitude,
    this.isFavorite,
    this.groupId,
    this.group,
    this.count,
    this.amount
  ];
}