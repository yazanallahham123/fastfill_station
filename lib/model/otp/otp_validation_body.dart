import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'otp_validation_body.g.dart';

@JsonSerializable()
class OTPValidationBody extends Equatable {
  final String? code;

  const OTPValidationBody({this.code});

  factory OTPValidationBody.fromJson(Map<String, dynamic> json) =>
      _$OTPValidationBodyFromJson(json);

  Map<String, dynamic> toJson() => _$OTPValidationBodyToJson(this);

  @override
  List<Object?> get props =>
      [this.code];
}
