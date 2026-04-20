import 'package:json_annotation/json_annotation.dart';

part 'counter_response.g.dart';

@JsonSerializable()
class CounterResponse {
  final int count;

  CounterResponse({required this.count});

  factory CounterResponse.fromJson(Map<String, dynamic> json) => _$CounterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CounterResponseToJson(this);
}
