import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

part 'get_notification_response.freezed.dart';

part 'get_notification_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class GetNotificationResponse with _$GetNotificationResponse {
  @JsonSerializable()
  const factory GetNotificationResponse.success(
    @JsonKey(name: "data") GetNotificationResponseData responseData,
    @JsonKey(name: "message") String message,
  ) = _GetNotificationResponse;

  @JsonSerializable()
  const factory GetNotificationResponse.error(String message) =
      _GetNotificationResponseError;

  factory GetNotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$GetNotificationResponseFromJson(json);
}

@freezed
@JsonToType()
class GetNotificationResponseData with _$GetNotificationResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory GetNotificationResponseData(
    @JsonKey(name: "current_page") int currentPage,
    @JsonKey(name: "data") List<NotificationList> notificationList,
    @JsonKey(name: "from", defaultValue: 0) int from,
    @JsonKey(name: "last_page", defaultValue: 0) int lastPage,
    @JsonKey(name: "to", defaultValue: 0) int to,
    @JsonKey(name: "total", defaultValue: 0) int total,
  ) = _GetNotificationResponseData;

  factory GetNotificationResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetNotificationResponseDataFromJson(json);
}

@freezed
@JsonToType()
class NotificationList with _$NotificationList {
  @JsonSerializable(explicitToJson: true)
  const factory NotificationList(
    @JsonKey(name: "id") int id,
    @JsonKey(name: "user_id", defaultValue: 0) int userId,
    @JsonKey(name: "gigs_id", defaultValue: 0) int gigsId,
    @JsonKey(name: "role", defaultValue: "") String role,
    @JsonKey(name: "type", defaultValue: "") String type,
    @JsonKey(name: "title", defaultValue: "") String title,
    @JsonKey(name: "message", defaultValue: "") String message,
    @JsonKey(name: "image", defaultValue: "") String image,
    @JsonKey(name: "created_at", defaultValue: "") String createdAt,
    @JsonKey(name: "updated_at", defaultValue: "") String updatedAt,
  ) = _NotificationList;

  factory NotificationList.fromJson(Map<String, dynamic> json) =>
      _$NotificationListFromJson(json);
}
