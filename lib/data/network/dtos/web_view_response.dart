import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

part 'web_view_response.freezed.dart';

part 'web_view_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class WebViewResponse with _$WebViewResponse {
  @JsonSerializable()
  const factory WebViewResponse.success(
    WebViewResponseData data,
    @JsonKey(name: "message") String message,
  ) = _WebViewResponse;

  @JsonSerializable()
  const factory WebViewResponse.error(
    @JsonKey(name: "status", defaultValue: 200) int status,
    @JsonKey(name: "message") String message,
  ) = _WebViewResponseError;

  factory WebViewResponse.fromJson(Map<String, dynamic> json) =>
      _$WebViewResponseFromJson(json);
}

@freezed
@JsonToType()
class WebViewResponseData with _$WebViewResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory WebViewResponseData(
    @JsonKey(name: "id", defaultValue: 0) int id,
    @JsonKey(name: "slug", defaultValue: "") String slug,
    @JsonKey(name: "content", defaultValue: "") String content,
    @JsonKey(name: "title", defaultValue: "") String title,
  ) = _WebViewResponseData;

  factory WebViewResponseData.fromJson(Map<String, dynamic> json) =>
      _$WebViewResponseDataFromJson(json);
}
