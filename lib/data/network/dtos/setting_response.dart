import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

part 'setting_response.freezed.dart';

part 'setting_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class SettingResponse with _$SettingResponse {
  @JsonSerializable()
  const factory SettingResponse.success(
    @JsonKey(name: "data", defaultValue: []) List<SettingResponseData> list,
    @JsonKey(name: "message", defaultValue: "") String message,
  ) = _SettingResponse;

  @JsonSerializable()
  const factory SettingResponse.error(String message) = _SettingResponseError;

  factory SettingResponse.fromJson(Map<String, dynamic> json) =>
      _$SettingResponseFromJson(json);
}

@freezed
@JsonToType()
class SettingResponseData with _$SettingResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory SettingResponseData(
    @JsonKey(name: "id", defaultValue: 0) int id,
    @JsonKey(name: "name", defaultValue: "") String name,
    @JsonKey(name: "value", defaultValue: "") String value,
    @JsonKey(name: "description", defaultValue: "") String description,
    @JsonKey(name: "status", defaultValue: "") String status,
  ) = _SettingResponseData;

  factory SettingResponseData.fromJson(Map<String, dynamic> json) =>
      _$SettingResponseDataFromJson(json);
}
