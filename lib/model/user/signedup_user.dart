import 'package:equatable/equatable.dart';
import 'package:fastfill_station_app/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signedup_user.g.dart';

@JsonSerializable()
class SignedUpUser extends Equatable {
  final String? token;
  final User? userDetails;

  const SignedUpUser(
      {this.token,
        this.userDetails});

  factory SignedUpUser.fromJson(Map<String, dynamic> json) =>
      _$SignedUpUserFromJson(json);

  Map<String, dynamic> toJson() => _$SignedUpUserToJson(this);

  @override
  List<Object?> get props => [
    this.token,
    this.userDetails
  ];
}
