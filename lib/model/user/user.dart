import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../group/group.dart';
import '../station/station.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? username;
  final int? roleId;
  final String? mobileNumber;
  final bool? disabled;
  final String? imageURL;
  final int? companyId;
  final Station? company;
  final int? language;
  final int? groupId;
  final Group? group;

  const User(
      {this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.roleId,
        this.mobileNumber,
        this.disabled,
        this.imageURL,
        this.companyId,
        this.company,
      this.language,
      this.groupId,
      this.group});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.roleId,
    this.mobileNumber,
    this.disabled,
    this.imageURL,
    this.companyId,
    this.company,
    this.language,
    this.groupId,
    this.group
  ];
}