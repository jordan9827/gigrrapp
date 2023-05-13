import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

import 'chat_response.dart';

part 'get_chat_response.freezed.dart';

part 'get_chat_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class GetChatResponse with _$GetChatResponse {
  @JsonSerializable()
  const factory GetChatResponse.success(
    @JsonKey(name: "data") GetChatResponseData data,
    @JsonKey(name: "message") String message,
  ) = _GetChatResponse;

  @JsonSerializable()
  const factory GetChatResponse.error(String message) = _GetChatResponseError;

  factory GetChatResponse.fromJson(Map<String, dynamic> json) =>
      _$GetChatResponseFromJson(json);
}

@freezed
@JsonToType()
class GetChatResponseData with _$GetChatResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory GetChatResponseData(
    @JsonKey(name: "current_page", defaultValue: 0) int currentPage,
    @JsonKey(name: "data") List<ChatResponseData> chatList,
  ) = _GetChatResponseData;

  factory GetChatResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetChatResponseDataFromJson(json);
}
