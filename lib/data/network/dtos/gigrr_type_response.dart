import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

part 'gigrr_type_response.freezed.dart';

part 'gigrr_type_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class GigrrTypeCategoryResponse with _$GigrrTypeCategoryResponse {
  @JsonSerializable()
  const factory GigrrTypeCategoryResponse.success(
    @JsonKey(name: "data") List<GigrrTypeCategoryList> gigrrTypeList,
    @JsonKey(name: "message") String message,
  ) = _GigrrTypeCategoryResponse;

  @JsonSerializable()
  const factory GigrrTypeCategoryResponse.error(String message) =
      _GigrrTypeCategoryResponseError;

  factory GigrrTypeCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$GigrrTypeCategoryResponseFromJson(json);
}

@freezed
@JsonToType()
class GigrrTypeCategoryList with _$GigrrTypeCategoryList {
  @JsonSerializable(explicitToJson: true)
  const factory GigrrTypeCategoryList(
    @JsonKey(name: "id") int id,
    @JsonKey(name: "status", defaultValue: "") String status,
    @JsonKey(name: "name", defaultValue: "") String name,
    @JsonKey(name: "updated_at", defaultValue: "") String updatedAt,
    @JsonKey(name: "created_at", defaultValue: "") String createdAt,
  ) = _GigrrTypeCategoryList;

  factory GigrrTypeCategoryList.fromJson(Map<String, dynamic> json) =>
      _$GigrrTypeCategoryListFromJson(json);
}
