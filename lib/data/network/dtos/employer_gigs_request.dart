import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

import 'gigrr_type_response.dart';

part 'employer_gigs_request.freezed.dart';

part 'employer_gigs_request.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class EmployerGigsRequestResponse with _$EmployerGigsRequestResponse {
  @JsonSerializable()
  const factory EmployerGigsRequestResponse.success(
    @JsonKey(name: "data") EmployerGigsRequestResponseData data,
    @JsonKey(name: "message") String message,
  ) = _EmployerGigsRequestResponse;

  @JsonSerializable()
  const factory EmployerGigsRequestResponse.error(
    @JsonKey(name: "status", defaultValue: 200) int status,
    @JsonKey(name: "message") String message,
  ) = _EmployerGigsRequestResponseError;

  factory EmployerGigsRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$EmployerGigsRequestResponseFromJson(json);
}

@freezed
@JsonToType()
class EmployerGigsRequestResponseData with _$EmployerGigsRequestResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory EmployerGigsRequestResponseData(
    @JsonKey(name: "current_page") int currentPage,
    @JsonKey(name: "data") List<EmployerGigsRequestData> gigsRequestData,
    @JsonKey(name: "from", defaultValue: 0) int from,
    @JsonKey(name: "last_page", defaultValue: 0) int lastPage,
    @JsonKey(name: "per_page", defaultValue: 0) int perPage,
    @JsonKey(name: "to", defaultValue: 0) int to,
    @JsonKey(name: "total", defaultValue: 0) int total,
  ) = _EmployerGigsRequestResponseData;

  factory EmployerGigsRequestResponseData.fromJson(Map<String, dynamic> json) =>
      _$EmployerGigsRequestResponseDataFromJson(json);
}

@freezed
@JsonToType()
class EmployerGigsRequestData with _$EmployerGigsRequestData {
  @JsonSerializable(explicitToJson: true)
  const factory EmployerGigsRequestData(
    @JsonKey(name: "id") int id,
    @JsonKey(name: "first_name", defaultValue: "") String firstName,
    @JsonKey(name: "last_name", defaultValue: "") String lastName,
    @JsonKey(name: "role_id", defaultValue: "") String roleId,
    @JsonKey(name: "email", defaultValue: "") String email,
    @JsonKey(name: "mobile", defaultValue: 0) int mobile,
    @JsonKey(name: "gender", defaultValue: "") String gender,
    @JsonKey(name: "profile_image", defaultValue: "") String profileImage,
    @JsonKey(name: "distance", defaultValue: 0) double distance,
    @JsonKey(name: "dob", defaultValue: "") String dob,
    @JsonKey(name: "address", defaultValue: "") String address,
    @JsonKey(name: "longitude", defaultValue: "") String longitude,
    @JsonKey(name: "latitude", defaultValue: "") String latitude,
    @JsonKey(name: "bank_account_status", defaultValue: "")
        String bankAccountStatus,
    @JsonKey(name: "age", defaultValue: 0) int age,
    @JsonKey(name: "gigs_request_count", defaultValue: 0) int gigsRequestCount,
    @JsonKey(name: "employee_images", defaultValue: [])
        List<EmployerImageList> employerImageList,
    @JsonKey(name: "employee_skills", defaultValue: [])
        List<EmployerSkills> employeeSkills,
    @JsonKey(name: "employee_profile", defaultValue: EmployerProfile.employerProfileEmpty)
        EmployerProfile employerProfile,
  ) = _EmployerGigsRequestData;

  factory EmployerGigsRequestData.fromJson(Map<String, dynamic> json) =>
      _$EmployerGigsRequestDataFromJson(json);
}

@freezed
@JsonToType()
class EmployerImageList with _$EmployerImageList {
  @JsonSerializable(explicitToJson: true)
  const factory EmployerImageList(
    @JsonKey(name: "id", defaultValue: 0) int id,
    @JsonKey(name: "user_id", defaultValue: 0) int userId,
    @JsonKey(name: "image_url") String imageUrl,
  ) = _EmployerImageList;

  factory EmployerImageList.fromJson(Map<String, dynamic> json) =>
      _$EmployerImageListFromJson(json);
}

@freezed
@JsonToType()
class EmployerSkills with _$EmployerSkills {
  @JsonSerializable(explicitToJson: true)
  const factory EmployerSkills(
    @JsonKey(name: "id", defaultValue: 0) int id,
    @JsonKey(name: "user_id", defaultValue: 0) int userId,
    @JsonKey(name: "skill_id", defaultValue: 0) int skillId,
    @JsonKey(name: "name") String name,
    @JsonKey(name: "types", defaultValue: [])
        List<GigrrTypeCategoryData> skills,
  ) = _EmployerSkills;

  factory EmployerSkills.fromJson(Map<String, dynamic> json) =>
      _$EmployerSkillsFromJson(json);
}

@freezed
@JsonToType()
class EmployerProfile with _$EmployerProfile {
  @JsonSerializable(explicitToJson: true)
  const factory EmployerProfile(
    @JsonKey(name: "id", defaultValue: 0) int id,
    @JsonKey(name: "user_id", defaultValue: 0) int userId,
    @JsonKey(name: "aadhar_number", defaultValue: "") String aadhaarNumber,
    @JsonKey(name: "aadhar_front_image", defaultValue: "")
        String aadhaarFrontImage,
    @JsonKey(name: "aadhar_back_image", defaultValue: "")
        String aadhaarBackImage,
    @JsonKey(name: "experience_year", defaultValue: "") String experienceYear,
    @JsonKey(name: "experience_month", defaultValue: "") String experienceMonth,
    @JsonKey(name: "price_from", defaultValue: 0) int priceFrom,
    @JsonKey(name: "price_to", defaultValue: 0) int priceTo,
    @JsonKey(name: "price_criteria", defaultValue: "") String priceCriteria,
    @JsonKey(name: "availibility", defaultValue: "") String availibility,
    @JsonKey(name: "shift", defaultValue: "") String shift,
    @JsonKey(name: "aadhar_back_image_url", defaultValue: "")
        String aadhaarBackImageUrl,
    @JsonKey(name: "aadhar_front_image_url", defaultValue: "")
        String aadhaarFrontImageUrl,
    @JsonKey(name: "experience", defaultValue: "") String experience,
  ) = _EmployerProfile;

  factory EmployerProfile.fromJson(Map<String, dynamic> json) =>
      _$EmployerProfileFromJson(json);

  static employerProfileEmpty() {
    return EmployerProfile.fromJson({});
  }
}
