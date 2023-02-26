import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../group/group.dart';

part 'station.g.dart';

@JsonSerializable()
class Station extends Equatable {
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

  const Station(
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
        this.group});

  factory Station.fromJson(Map<String, dynamic> json) => _$StationFromJson(json);

  Map<String, dynamic> toJson() => _$StationToJson(this);

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
    this.group
  ];
}