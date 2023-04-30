import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

part 'upload_image_response.freezed.dart';

part 'upload_image_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class UploadImageResponse with _$UploadImageResponse {
  @JsonSerializable()
  const factory UploadImageResponse.success(
    UploadImageResponseData data,
    @JsonKey(name: "message") String message,
  ) = _UploadImageResponse;

  @JsonSerializable()
  const factory UploadImageResponse.error(String message) =
      _UploadImageResponseError;

  factory UploadImageResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadImageResponseFromJson(json);
}

@freezed
@JsonToType()
class UploadImageResponseData with _$UploadImageResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory UploadImageResponseData(
    @JsonKey(name: "image", defaultValue: []) List<String> imageList,
  ) = _UploadImageResponseData;

  factory UploadImageResponseData.fromJson(Map<String, dynamic> json) =>
      _$UploadImageResponseDataFromJson(json);
}
