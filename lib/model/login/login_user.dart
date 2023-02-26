import 'package:equatable/equatable.dart';

import 'value.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_user.g.dart';

@JsonSerializable()
class LoginUser extends Equatable {
  final Value? value;
  final List<dynamic>? formatters;
  final List<dynamic>? contentTypes;
  final String? declaredType;
  final int? statusCode;

  const LoginUser(
      {this.value,
        this.formatters,
        this.contentTypes,
        this.declaredType,
        this.statusCode});

  factory LoginUser.fromJson(Map<String, dynamic> json) =>
      _$LoginUserFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserToJson(this);

  @override
  List<Object?> get props => [
    this.value,
    this.formatters,
    this.contentTypes,
    this.declaredType,
    this.statusCode
  ];
}
