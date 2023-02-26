import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_user_language_body.g.dart';

@JsonSerializable()
class UpdateUserLanguageBody extends Equatable {
  final int? languageId;

  const UpdateUserLanguageBody(
      {
        this.languageId});

  factory UpdateUserLanguageBody.fromJson(Map<String, dynamic> json) => _$UpdateUserLanguageBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserLanguageBodyToJson(this);

  @override
  List<Object?> get props => [
    this.languageId
  ];
}