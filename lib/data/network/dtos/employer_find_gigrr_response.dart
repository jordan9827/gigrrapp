import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

import 'gigrr_type_response.dart';

part 'employer_find_gigrr_response.freezed.dart';

part 'employer_find_gigrr_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class EmployerFindGigrrsResponse with _$EmployerFindGigrrsResponse {
  @JsonSerializable()
  const factory EmployerFindGigrrsResponse.success(
    @JsonKey(name: "data") EmployerFindGigrrsResponseData data,
    @JsonKey(name: "message") String message,
  ) = _EmployerFindGigrrsResponse;

  @JsonSerializable()
  const factory EmployerFindGigrrsResponse.error(
    @JsonKey(name: "status", defaultValue: 200) int status,
    @JsonKey(name: "message") String message,
  ) = _EmployerFindGigrrsResponseError;

  factory EmployerFindGigrrsResponse.fromJson(Map<String, dynamic> json) =>
      _$EmployerFindGigrrsResponseFromJson(json);
}

@freezed
@JsonToType()
class EmployerFindGigrrsResponseData with _$EmployerFindGigrrsResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory EmployerFindGigrrsResponseData(
    @JsonKey(name: "id", defaultValue: 0) int id,
    @JsonKey(name: "employer_id", defaultValue: 0) int employerId,
    @JsonKey(name: "gigs_id", defaultValue: "") String gigsId,
    @JsonKey(name: "gigs_latitude", defaultValue: "") String gigsLatitude,
    @JsonKey(name: "gigs_longitude", defaultValue: "") String gigsLongitude,
    @JsonKey(name: "gig_address", defaultValue: "") String gigAddress,
    @JsonKey(name: "gigrr_type", defaultValue: "") String gigrrType,
    @JsonKey(name: "gender", defaultValue: "") String gender,
    @JsonKey(name: "gig_name", defaultValue: "") String gigName,
    @JsonKey(name: "gigs_start_date", defaultValue: "") String gigsStartDate,
    @JsonKey(name: "gigs_end_date", defaultValue: "") String gigsEndDate,
  ) = _EmployerFindGigrrsResponseData;

  factory EmployerFindGigrrsResponseData.fromJson(Map<String, dynamic> json) =>
      _$EmployerFindGigrrsResponseDataFromJson(json);
}
