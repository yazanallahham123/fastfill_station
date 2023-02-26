import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_body.g.dart';

@JsonSerializable()
class ResetPasswordBody extends Equatable {
  final String? mobileNumber;
  final String? newPassword;
  final String? verificationId;

  const ResetPasswordBody(
      {
        this.mobileNumber,
        this.newPassword,
        this.verificationId});

  factory ResetPasswordBody.fromJson(Map<String, dynamic> json) => _$ResetPasswordBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordBodyToJson(this);

  @override
  List<Object?> get props => [
    this.mobileNumber,
    this.newPassword,
    this.verificationId
  ];
}