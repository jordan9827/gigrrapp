import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

part 'calender_wise_response.freezed.dart';

part 'calender_wise_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class CalenderWiseResponse with _$CalenderWiseResponse {
  @JsonSerializable()
  const factory CalenderWiseResponse.success(
    @JsonKey(name: "message", defaultValue: "") String message,
    @JsonKey(name: "data", defaultValue: {}) Map<String, dynamic> data,
  ) = _CalenderWiseResponse;

  @JsonSerializable()
  const factory CalenderWiseResponse.error(
    @JsonKey(name: "status", defaultValue: 200) int status,
    @JsonKey(name: "message", defaultValue: "") String message,
  ) = _CalenderWiseResponseError;

  factory CalenderWiseResponse.fromJson(Map<String, dynamic> json) =>
      _$CalenderWiseResponseFromJson(json);
}
