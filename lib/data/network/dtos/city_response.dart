import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

part 'city_response.freezed.dart';

part 'city_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class CityResponse with _$CityResponse {
  @JsonSerializable()
  const factory CityResponse.success(
    @JsonKey(name: "data", defaultValue: []) List<CityResponseData> list,
    @JsonKey(name: "message", defaultValue: "") String message,
  ) = _CityResponse;

  @JsonSerializable()
  const factory CityResponse.error(String message) = _CityResponseError;

  factory CityResponse.fromJson(Map<String, dynamic> json) =>
      _$CityResponseFromJson(json);
}

@freezed
@JsonToType()
class CityResponseData with _$CityResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory CityResponseData(
    @JsonKey(name: "id", defaultValue: 0) int id,
    @JsonKey(name: "name", defaultValue: "") String name,
    @JsonKey(name: "state_id", defaultValue: 0) int stateId,
  ) = _CityResponseData;

  factory CityResponseData.fromJson(Map<String, dynamic> json) =>
      _$CityResponseDataFromJson(json);
}
