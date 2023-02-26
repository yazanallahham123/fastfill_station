import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_profile_body.g.dart';

@JsonSerializable()
class UpdateProfileBody extends Equatable {
  final String? name;
  final String? mobileNumber;
  final String? imageURL;

  const UpdateProfileBody(
      {this.name,
        this.mobileNumber,
        this.imageURL});

  factory UpdateProfileBody.fromJson(Map<String, dynamic> json) => _$UpdateProfileBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileBodyToJson(this);

  @override
  List<Object?> get props => [
    this.name,
    this.mobileNumber,
    this.imageURL
  ];
}