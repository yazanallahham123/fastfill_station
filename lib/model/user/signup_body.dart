import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signup_body.g.dart';

@JsonSerializable()
class SignupBody extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? password;
  final String? mobileNumber;
  final int? language;

  const SignupBody(
      {
        this.firstName,
        this.lastName,
        this.username,
        this.password,
        this.mobileNumber,
      this.language});

  factory SignupBody.fromJson(Map<String, dynamic> json) => _$SignupBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SignupBodyToJson(this);

  @override
  List<Object?> get props => [
    this.firstName,
    this.lastName,
    this.username,
    this.password,
    this.mobileNumber,
    this.language
  ];
}