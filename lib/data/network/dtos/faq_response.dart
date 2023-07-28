import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

part 'faq_response.freezed.dart';

part 'faq_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class FAQResponse with _$FAQResponse {
  @JsonSerializable()
  const factory FAQResponse.success(
    @JsonKey(name: "data", defaultValue: []) List<FAQResponseData> faqData,
    @JsonKey(name: "message", defaultValue: "") String message,
  ) = _FAQResponse;

  @JsonSerializable()
  const factory FAQResponse.error(
    @JsonKey(name: "status", defaultValue: 200) int status,
    @JsonKey(name: "message") String message,
  ) = _FAQResponseError;

  factory FAQResponse.fromJson(Map<String, dynamic> json) =>
      _$FAQResponseFromJson(json);
}

@freezed
@JsonToType()
class FAQResponseData with _$FAQResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory FAQResponseData(
    @JsonKey(name: "id", defaultValue: 0) int id,
    @JsonKey(name: "role_type", defaultValue: "") String roleType,
    @JsonKey(name: "question", defaultValue: "") String question,
    @JsonKey(name: "per_page", defaultValue: "") String perPage,
    @JsonKey(name: "answer", defaultValue: "") String answer,
    @JsonKey(name: "faq_status", defaultValue: "") String faqStatus,
  ) = _FAQResponseData;

  factory FAQResponseData.fromJson(Map<String, dynamic> json) =>
      _$FAQResponseDataFromJson(json);
}
