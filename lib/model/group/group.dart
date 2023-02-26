import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group extends Equatable {
  int? id;
  String? arabicName;
  String? englishName;


  Group(
      {this.id,
        this.arabicName,
        this.englishName});

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  @override
  List<Object?> get props => [
    this.id,
    this.arabicName,
    this.englishName,
  ];
}