import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_result.g.dart';

@JsonSerializable()
class UploadResult extends Equatable {
  final String? url;
  const UploadResult(
      {this.url});

  factory UploadResult.fromJson(Map<String, dynamic> json) => _$UploadResultFromJson(json);

  Map<String, dynamic> toJson() => _$UploadResultToJson(this);

  @override
  List<Object?> get props => [
    this.url
  ];
}