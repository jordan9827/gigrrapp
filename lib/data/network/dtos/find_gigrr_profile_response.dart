import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

import 'employer_gigs_request.dart';
import 'get_businesses_response.dart';

part 'find_gigrr_profile_response.freezed.dart';

part 'find_gigrr_profile_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class FindGigrrsProfileResponse with _$FindGigrrsProfileResponse {
  @JsonSerializable()
  const factory FindGigrrsProfileResponse.success(
    @JsonKey(name: "data", defaultValue: []) List<FindGigrrsProfileData> data,
    @JsonKey(name: "message") String message,
  ) = _FindGigrrsProfileResponse;

  @JsonSerializable()
  const factory FindGigrrsProfileResponse.error(
    @JsonKey(name: "status", defaultValue: 200) int status,
    @JsonKey(name: "message") String message,
  ) = _FindGigrrsProfileResponseError;

  factory FindGigrrsProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$FindGigrrsProfileResponseFromJson(json);
}

@freezed
@JsonToType()
class FindGigrrsProfileData with _$FindGigrrsProfileData {
  @JsonSerializable(explicitToJson: true)
  const factory FindGigrrsProfileData(
    @JsonKey(name: "id", defaultValue: 0) int id,
    @JsonKey(name: "first_name", defaultValue: "") String firstName,
    @JsonKey(name: "last_name", defaultValue: "") String lastName,
    @JsonKey(name: "role_id", defaultValue: "") String roleId,
    @JsonKey(name: "email", defaultValue: "") String email,
    @JsonKey(name: "mobile", defaultValue: "") String mobile,
    @JsonKey(name: "gender", defaultValue: "") String gender,
    @JsonKey(name: "profile_image", defaultValue: "") String profileImage,
    @JsonKey(name: "image_url", defaultValue: "") String imageUrl,
    @JsonKey(name: "distance", defaultValue: 0) double distance,
    @JsonKey(name: "dob", defaultValue: "") String dob,
    @JsonKey(name: "address", defaultValue: "") String address,
    @JsonKey(name: "longitude", defaultValue: "") String longitude,
    @JsonKey(name: "latitude", defaultValue: "") String latitude,
    @JsonKey(name: "age", defaultValue: 0) int age,
    // @JsonKey(name: "gigrr_business", defaultValue: GetBusinessesData.getEmptyBusinesses)
    //     GetBusinessesData business,
    @JsonKey(name: "employee_images", defaultValue: [])
        List<EmployerImageList> employerImageList,
    @JsonKey(name: "employee_skills", defaultValue: [])
        List<EmployerSkills> employeeSkills,
    @JsonKey(name: "employee_profile", defaultValue: EmployerProfile.employerProfileEmpty)
        EmployerProfile employerProfile,
  ) = _FindGigrrsProfileData;

  factory FindGigrrsProfileData.fromJson(Map<String, dynamic> json) =>
      _$FindGigrrsProfileDataFromJson(json);
}
