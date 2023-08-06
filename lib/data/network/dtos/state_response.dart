import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

part 'state_response.freezed.dart';

part 'state_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class StateResponse with _$StateResponse {
  @JsonSerializable()
  const factory StateResponse.success(
    @JsonKey(name: "data", defaultValue: []) List<StateResponseData> list,
    @JsonKey(name: "message", defaultValue: "") String message,
  ) = _StateResponse;

  @JsonSerializable()
  const factory StateResponse.error(String message) = _StateResponseError;

  factory StateResponse.fromJson(Map<String, dynamic> json) =>
      _$StateResponseFromJson(json);
}

@freezed
@JsonToType()
class StateResponseData with _$StateResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory StateResponseData(
    @JsonKey(name: "id", defaultValue: 0) int id,
    @JsonKey(name: "name", defaultValue: "") String name,
    @JsonKey(name: "country_id", defaultValue: 0) int countryId,
  ) = _StateResponseData;

  factory StateResponseData.fromJson(Map<String, dynamic> json) =>
      _$StateResponseDataFromJson(json);
}
