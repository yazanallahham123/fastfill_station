import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_firebase_token_body.g.dart';

@JsonSerializable()
class UpdateFirebaseTokenBody extends Equatable {
  final String? firebaseToken;

  const UpdateFirebaseTokenBody(
      {this.firebaseToken});

  factory UpdateFirebaseTokenBody.fromJson(Map<String, dynamic> json) => _$UpdateFirebaseTokenBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateFirebaseTokenBodyToJson(this);

  @override
  List<Object?> get props => [
    this.firebaseToken
  ];
}