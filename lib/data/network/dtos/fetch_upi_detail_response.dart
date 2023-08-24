import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

part 'fetch_upi_detail_response.freezed.dart';

part 'fetch_upi_detail_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class GetUpiDetailResponse with _$GetUpiDetailResponse {
  @JsonSerializable()
  const factory GetUpiDetailResponse.success(
    @JsonKey(name: "data", defaultValue: GetUpiDetailResponseData.init)
        GetUpiDetailResponseData data,
    @JsonKey(name: "message", defaultValue: "") String message,
  ) = _GetUpiDetailResponse;

  @JsonSerializable()
  const factory GetUpiDetailResponse.error(String message) =
      _GetUpiDetailResponseError;

  factory GetUpiDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUpiDetailResponseFromJson(json);
}

@freezed
@JsonToType()
class GetUpiDetailResponseData with _$GetUpiDetailResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory GetUpiDetailResponseData(
    @JsonKey(name: "id", defaultValue: 0) int id,
    @JsonKey(name: "user_id", defaultValue: 0) int userId,
    @JsonKey(name: "upi_id", defaultValue: "") String upiId,
    @JsonKey(name: "status", defaultValue: "") String status,
    @JsonKey(name: "name", defaultValue: "") String name,
  ) = _GetUpiDetailResponseData;

  factory GetUpiDetailResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetUpiDetailResponseDataFromJson(json);

  static GetUpiDetailResponseData init() =>
      GetUpiDetailResponseData(0, 0, "", "", "");
}
