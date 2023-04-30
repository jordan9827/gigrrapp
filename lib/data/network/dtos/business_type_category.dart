import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

part 'business_type_category.freezed.dart';

part 'business_type_category.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class BusinessTypeCategoryResponse with _$BusinessTypeCategoryResponse {
  @JsonSerializable()
  const factory BusinessTypeCategoryResponse.success(
    @JsonKey(name: "data") List<BusinessTypeCategoryList> businessTypeList,
    @JsonKey(name: "message") String message,
  ) = _BusinessTypeCategoryResponse;

  @JsonSerializable()
  const factory BusinessTypeCategoryResponse.error(String message) =
      _BusinessTypeCategoryResponseError;

  factory BusinessTypeCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$BusinessTypeCategoryResponseFromJson(json);
}

@freezed
@JsonToType()
class BusinessTypeCategoryList with _$BusinessTypeCategoryList {
  @JsonSerializable(explicitToJson: true)
  const factory BusinessTypeCategoryList(
    @JsonKey(name: "id") int id,
    @JsonKey(name: "status", defaultValue: "") String status,
    @JsonKey(name: "name", defaultValue: "") String name,
    @JsonKey(name: "image", defaultValue: "") String imageUrl,
    @JsonKey(name: "updated_at", defaultValue: "") String updatedAt,
    @JsonKey(name: "created_at", defaultValue: "") String createdAt,
  ) = _BusinessTypeCategoryList;

  factory BusinessTypeCategoryList.fromJson(Map<String, dynamic> json) =>
      _$BusinessTypeCategoryListFromJson(json);
}
