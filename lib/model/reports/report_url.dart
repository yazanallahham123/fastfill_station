import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_url.g.dart';

@JsonSerializable()
class ReportURL extends Equatable {
  final String url;

  const ReportURL({
    required this.url
  });

  factory ReportURL.fromJson(Map<String, dynamic> json) =>
      _$ReportURLFromJson(json);

  Map<String, dynamic> toJson() => _$ReportURLToJson(this);

  @override
  List<Object?> get props =>
      [  this.url];
}
