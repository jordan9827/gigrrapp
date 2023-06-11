import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

part 'business_profile_response.freezed.dart';

part 'business_profile_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class BusinessProfileResponse with _$BusinessProfileResponse {
  @JsonSerializable()
  const factory BusinessProfileResponse.success(
    @JsonKey(name: "data") BusinessProfileData businessProfileData,
    @JsonKey(name: "message") String message,
  ) = _BusinessProfileResponse;

  @JsonSerializable()
  const factory BusinessProfileResponse.error(
    @JsonKey(name: "status", defaultValue: 200) int status,
    @JsonKey(name: "message") String message,
  ) = _BusinessProfileResponseError;

  factory BusinessProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$BusinessProfileResponseFromJson(json);
}

@freezed
@JsonToType()
class BusinessProfileData with _$BusinessProfileData {
  @JsonSerializable(explicitToJson: true)
  const factory BusinessProfileData(
    @JsonKey(name: "id") int id,
    @JsonKey(name: "user_id") int userId,
    @JsonKey(name: "status", defaultValue: "") String status,
    @JsonKey(name: "category_id", defaultValue: 0) int categoryId,
    @JsonKey(name: "business_name", defaultValue: "") String businessName,
    @JsonKey(name: "business_address", defaultValue: "") String businessAddress,
    @JsonKey(name: "latitude", defaultValue: "") String latitude,
    @JsonKey(name: "longitude", defaultValue: "") String longitude,
    @JsonKey(name: "category") Category category,
    @JsonKey(name: "business_images", defaultValue: [])
        List<BusinessImageList> businessImages,
    @JsonKey(name: "updated_at", defaultValue: "") String updatedAt,
    @JsonKey(name: "created_at", defaultValue: "") String createdAt,
  ) = _BusinessProfileData;

  factory BusinessProfileData.fromJson(Map<String, dynamic> json) =>
      _$BusinessProfileDataFromJson(json);
}

@freezed
@JsonToType()
class BusinessImageList with _$BusinessImageList {
  @JsonSerializable(explicitToJson: true)
  const factory BusinessImageList(
    @JsonKey(name: "id") int id,
    @JsonKey(name: "user_id") int userId,
    @JsonKey(name: "business_id", defaultValue: 0) int businessId,
    @JsonKey(name: "image", defaultValue: "") String imageUrl,
    @JsonKey(name: "business_image", defaultValue: "") String businessImage,
  ) = _BusinessImageList;

  factory BusinessImageList.fromJson(Map<String, dynamic> json) =>
      _$BusinessImageListFromJson(json);
}

@freezed
@JsonToType()
class Category with _$Category {
  @JsonSerializable(explicitToJson: true)
  const factory Category(
    @JsonKey(name: "id") int id,
    @JsonKey(name: "name", defaultValue: "") String name,
  ) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
