import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

part 'chat_response.freezed.dart';

part 'chat_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class ChatResponse with _$ChatResponse {
  @JsonSerializable()
  const factory ChatResponse.success(
    @JsonKey(name: "data") ChatResponseData data,
    @JsonKey(name: "message") String message,
  ) = _ChatResponse;

  @JsonSerializable()
  const factory ChatResponse.error(
    @JsonKey(name: "status", defaultValue: 200) int status,
    @JsonKey(name: "message") String message,
  ) = _ChatResponseError;

  factory ChatResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseFromJson(json);
}

@freezed
@JsonToType()
class ChatResponseData with _$ChatResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory ChatResponseData(
    @JsonKey(name: "id", defaultValue: 0) int currentPage,
    @JsonKey(name: "from_user_id", defaultValue: 0) int fromUserId,
    @JsonKey(name: "to_user_id", defaultValue: 0) int toUserId,
    @JsonKey(name: "gigs_id", defaultValue: "") String gigsId,
    @JsonKey(name: "message", defaultValue: "") String message,
    @JsonKey(name: "updated_at", defaultValue: "") String updatedAt,
    @JsonKey(name: "created_at", defaultValue: "") String createdAt,
  ) = _ChatResponseData;

  factory ChatResponseData.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseDataFromJson(json);
}
