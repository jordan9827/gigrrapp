import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

part 'get_contact_subject.freezed.dart';

part 'get_contact_subject.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class GetContactSubjectResponse with _$GetContactSubjectResponse {
  @JsonSerializable()
  const factory GetContactSubjectResponse.success(
    @JsonKey(name: "data", defaultValue: []) List<GetContactSubjectData> data,
    @JsonKey(name: "message") String message,
  ) = _GetContactSubjectResponse;

  @JsonSerializable()
  const factory GetContactSubjectResponse.error(
    @JsonKey(name: "status", defaultValue: 200) int status,
    @JsonKey(name: "message") String message,
  ) = _GetContactSubjectResponseError;

  factory GetContactSubjectResponse.fromJson(Map<String, dynamic> json) =>
      _$GetContactSubjectResponseFromJson(json);
}

@freezed
@JsonToType()
class GetContactSubjectData with _$GetContactSubjectData {
  @JsonSerializable(explicitToJson: true)
  const factory GetContactSubjectData(
    @JsonKey(name: "id", defaultValue: 0) int id,
    @JsonKey(name: "name", defaultValue: "") String name,
    @JsonKey(name: "role", defaultValue: "") String role,
  ) = _GetContactSubjectData;

  factory GetContactSubjectData.fromJson(Map<String, dynamic> json) =>
      _$GetContactSubjectDataFromJson(json);
}
