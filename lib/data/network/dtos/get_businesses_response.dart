import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

part 'get_businesses_response.freezed.dart';

part 'get_businesses_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class GetBusinessesResponse with _$GetBusinessesResponse {
  @JsonSerializable()
  const factory GetBusinessesResponse.success(
    @JsonKey(name: "data") GetBusinessesResponseData responseData,
    @JsonKey(name: "message") String message,
  ) = _GetBusinessesResponse;

  @JsonSerializable()
  const factory GetBusinessesResponse.error(String message) =
      _GetBusinessesResponseError;

  factory GetBusinessesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBusinessesResponseFromJson(json);
}

@freezed
@JsonToType()
class GetBusinessesResponseData with _$GetBusinessesResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory GetBusinessesResponseData(
    @JsonKey(name: "current_page") int currentPage,
    @JsonKey(name: "data") List<GetBusinessesList> businessesList,
    @JsonKey(name: "from", defaultValue: 0) int from,
    @JsonKey(name: "last_page", defaultValue: 0) int lastPage,
    @JsonKey(name: "per_page", defaultValue: "") String perPage,
    @JsonKey(name: "to", defaultValue: 0) int to,
    @JsonKey(name: "total", defaultValue: 0) int total,
  ) = _GetBusinessesResponseData;

  factory GetBusinessesResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetBusinessesResponseDataFromJson(json);
}

@freezed
@JsonToType()
class GetBusinessesList with _$GetBusinessesList {
  @JsonSerializable(explicitToJson: true)
  const factory GetBusinessesList(
    @JsonKey(name: "id") int id,
    @JsonKey(name: "user_id", defaultValue: 0) int userId,
    @JsonKey(name: "category_id", defaultValue: 0) int categoryId,
    @JsonKey(name: "business_name", defaultValue: "") String businessName,
    @JsonKey(name: "business_address", defaultValue: "") String businessAddress,
    @JsonKey(name: "latitude", defaultValue: "") String latitude,
    @JsonKey(name: "longitude", defaultValue: "") String longitude,
    @JsonKey(name: "status", defaultValue: "") String status,
    @JsonKey(name: "category") CategoryResp categoryResp,
    @JsonKey(name: "business_images") List<BusinessesImageList> businessesImage,
  ) = _GetBusinessesList;

  factory GetBusinessesList.fromJson(Map<String, dynamic> json) =>
      _$GetBusinessesListFromJson(json);
}

@freezed
@JsonToType()
class BusinessesImageList with _$BusinessesImageList {
  @JsonSerializable(explicitToJson: true)
  const factory BusinessesImageList(
    @JsonKey(name: "id") int id,
    @JsonKey(name: "user_id", defaultValue: 0) int userId,
    @JsonKey(name: "business_id", defaultValue: 0) int categoryId,
    @JsonKey(name: "status", defaultValue: "") String status,
    @JsonKey(name: "business_image") String imageUrl,
  ) = _BusinessesImageList;

  factory BusinessesImageList.fromJson(Map<String, dynamic> json) =>
      _$BusinessesImageListFromJson(json);
}

@freezed
@JsonToType()
class CategoryResp with _$CategoryResp {
  @JsonSerializable(explicitToJson: true)
  const factory CategoryResp(
    @JsonKey(name: "id") int id,
    @JsonKey(name: "name", defaultValue: "") String name,
  ) = _CategoryResp;

  factory CategoryResp.fromJson(Map<String, dynamic> json) =>
      _$CategoryRespFromJson(json);
}