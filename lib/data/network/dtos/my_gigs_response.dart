import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

import 'get_businesses_response.dart';
import 'gigrr_type_response.dart';

part 'my_gigs_response.freezed.dart';

part 'my_gigs_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class MyGigsResponse with _$MyGigsResponse {
  @JsonSerializable()
  const factory MyGigsResponse.success(
    @JsonKey(name: "data") MyGigsResponseData responseData,
    @JsonKey(name: "message") String message,
  ) = _MyGigsResponse;

  @JsonSerializable()
  const factory MyGigsResponse.error(
    @JsonKey(name: "status", defaultValue: 200) int status,
    @JsonKey(name: "message") String message,
  ) = _MyGigsResponseError;

  factory MyGigsResponse.fromJson(Map<String, dynamic> json) =>
      _$MyGigsResponseFromJson(json);
}

@freezed
@JsonToType()
class MyGigsResponseData with _$MyGigsResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory MyGigsResponseData(
    @JsonKey(name: "current_page") int currentPage,
    @JsonKey(name: "data") List<MyGigsData> myGigsData,
    @JsonKey(name: "from", defaultValue: 0) int from,
    @JsonKey(name: "last_page", defaultValue: 0) int lastPage,
    @JsonKey(name: "per_page", defaultValue: 0) int perPage,
    @JsonKey(name: "to", defaultValue: 0) int to,
    @JsonKey(name: "total", defaultValue: 0) int total,
  ) = _MyGigsResponseData;

  factory MyGigsResponseData.fromJson(Map<String, dynamic> json) =>
      _$MyGigsResponseDataFromJson(json);
}

@freezed
@JsonToType()
class MyGigsData with _$MyGigsData {
  @JsonSerializable(explicitToJson: true)
  const factory MyGigsData(
    @JsonKey(name: "id", defaultValue: 0) int id,
    @JsonKey(name: "business_id", defaultValue: 0) int businessId,
    @JsonKey(name: "gigs_id", defaultValue: "") String gigsId,
    @JsonKey(name: "gig_name", defaultValue: "") String gigName,
    @JsonKey(name: "employer_id", defaultValue: 0) int employerId,
    @JsonKey(name: "gig_address", defaultValue: "") String gigAddress,
    @JsonKey(name: "gigs_latitude", defaultValue: "") String gigsLatitude,
    @JsonKey(name: "gigs_longitude", defaultValue: "") String gigsLongitude,
    @JsonKey(name: "gigrr_type", defaultValue: "") String gigrrType,
    @JsonKey(name: "estimate_amount", defaultValue: "") String estimateAmount,
    @JsonKey(name: "from_amount", defaultValue: "") String fromAmount,
    @JsonKey(name: "to_amount", defaultValue: "") String toAmount,
    @JsonKey(name: "gigs_start_date", defaultValue: "") String gigsStartDate,
    @JsonKey(name: "gigs_end_date", defaultValue: "") String gigsEndDate,
    @JsonKey(name: "status", defaultValue: "") String status,
    @JsonKey(name: "gigs_starttime", defaultValue: "") String gigsStartTime,
    @JsonKey(name: "gigs_endtime", defaultValue: "") String gigsEndTime,
    @JsonKey(name: "price_criteria", defaultValue: "") String priceCriteria,
    @JsonKey(name: "gigs_request_count", defaultValue: 0) int gigsRequestCount,
    @JsonKey(name: "skills") List<GigrrTypeCategoryData> skillsTypeCategoryList,
    @JsonKey(name: "gigrr_business", defaultValue: GetBusinessesData.getEmptyBusinesses)
        GetBusinessesData businessList,
    @JsonKey(name: "gigs_request", defaultValue: [])
        List<GigsRequestData> gigsRequestData,
    @JsonKey(name: "duration", defaultValue: 0) int duration,
    @JsonKey(name: "gender", defaultValue: "") String gender,
    @JsonKey(name: "state_id", defaultValue: 0) int stateId,
    @JsonKey(name: "roster_count", defaultValue: 0) int rosterCount,
    @JsonKey(name: "city_id") int cityId,
    @JsonKey(name: "updated_at", defaultValue: "") String updatedAt,
    @JsonKey(name: "created_at", defaultValue: "") String createdAt,
  ) = _MyGigsData;

  factory MyGigsData.fromJson(Map<String, dynamic> json) =>
      _$MyGigsDataFromJson(json);
}

@freezed
@JsonToType()
class GigsRequestData with _$GigsRequestData {
  @JsonSerializable(explicitToJson: true)
  const factory GigsRequestData(
    @JsonKey(name: "id", defaultValue: 0) int id,
    @JsonKey(name: "gigs_id", defaultValue: 0) int gigsId,
    @JsonKey(name: "user_id", defaultValue: 0) int userId,
    @JsonKey(name: "employe_id", defaultValue: 0) int employeId,
    @JsonKey(name: "employee_name", defaultValue: "") String employeeName,
    @JsonKey(name: "offer_amount", defaultValue: "") String offerAmount,
    @JsonKey(name: "agreed_amount", defaultValue: "") String agreedAmount,
    @JsonKey(name: "start_otp", defaultValue: "") String startOTP,
    @JsonKey(name: "end_otp", defaultValue: "") String endOTP,
    @JsonKey(name: "status", defaultValue: "") String status,
    @JsonKey(name: "distance", defaultValue: 0) int distance,
    @JsonKey(name: "candidate_rating", defaultValue: 0.0)
        double candidateRating,
    @JsonKey(name: "payment_status", defaultValue: "") String paymentStatus,
    @JsonKey(name: "rating_from_employer", defaultValue: "")
        String ratingFromEmployer,
    @JsonKey(name: "candidate_images", defaultValue: [])
        List<CandidateImage> candidateImageList,
    @JsonKey(name: "candidate", defaultValue: Candidate.getEmptyCandidate)
        final Candidate candidate,
    @JsonKey(name: "rating_to_employer", defaultValue: "")
        String ratingToEmployer,
  ) = _GigsRequestData;

  factory GigsRequestData.fromJson(Map<String, dynamic> json) =>
      _$GigsRequestDataFromJson(json);
}

@freezed
@JsonToType()
class CandidateImage with _$CandidateImage {
  @JsonSerializable(explicitToJson: true)
  const factory CandidateImage(
    @JsonKey(name: "id", defaultValue: 0) int id,
    @JsonKey(name: "user_id", defaultValue: 0) int userId,
    @JsonKey(name: "image_url", defaultValue: "") String imageURL,
  ) = _CandidateImage;

  factory CandidateImage.fromJson(Map<String, dynamic> json) =>
      _$CandidateImageFromJson(json);
}

@freezed
@JsonToType()
class Candidate with _$Candidate {
  @JsonSerializable(explicitToJson: true)
  const factory Candidate(
    @JsonKey(name: "id", defaultValue: 0) int id,
    @JsonKey(name: "role_id", defaultValue: "") String roleId,
    @JsonKey(name: "email", defaultValue: "") String email,
    @JsonKey(name: "mobile", defaultValue: "") String mobile,
    @JsonKey(name: "full_name", defaultValue: "") String fullName,
    @JsonKey(name: "image_url", defaultValue: "") String imageURL,
  ) = _Candidate;

  factory Candidate.fromJson(Map<String, dynamic> json) =>
      _$CandidateFromJson(json);

  static getEmptyCandidate() {
    return Candidate.fromJson({});
  }
}
