import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

part 'base_response.freezed.dart';

part 'base_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class BaseResponse with _$BaseResponse {
  @JsonSerializable()
  const factory BaseResponse.success(
    @JsonKey(name: "message") String message,
  ) = _BaseResponse;

  @JsonSerializable()
  const factory BaseResponse.error(
    @JsonKey(name: "status", defaultValue: 200) int status,
    @JsonKey(name: "message") String message,
  ) = _BaseResponseError;

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);
}
