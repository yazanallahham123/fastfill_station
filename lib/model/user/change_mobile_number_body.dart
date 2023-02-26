import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_mobile_number_body.g.dart';

@JsonSerializable()
class ChangeMobileNumberBody extends Equatable {
  final String? oldMobileNumber;
  final String? newMobileNumber;
  final String? oldMobileNumberOtp_id;
  final String? newMobileNumberOtp_id;

  const ChangeMobileNumberBody(
      {
        this.oldMobileNumber,
        this.newMobileNumber,
        this.oldMobileNumberOtp_id,
        this.newMobileNumberOtp_id});

  factory ChangeMobileNumberBody.fromJson(Map<String, dynamic> json) => _$ChangeMobileNumberBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeMobileNumberBodyToJson(this);

  @override
  List<Object?> get props => [
    this.oldMobileNumber,
    this.newMobileNumber,
    this.oldMobileNumberOtp_id,
    this.newMobileNumberOtp_id
  ];
}