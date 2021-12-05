import 'package:json_annotation/json_annotation.dart';

part 'parameters.g.dart';

@JsonSerializable()
class Parameters {
  String p;
  String m;
  String l;
  String e;

  Parameters({
    required this.p,
    required this.m,
    required this.l,
    required this.e,
  });

  factory Parameters.fromJson(Map<String, dynamic> json) => _$ParametersFromJson(json);
  Map<String, dynamic> toJson() => _$ParametersToJson(this);
}