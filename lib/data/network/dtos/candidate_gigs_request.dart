import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';
import 'get_businesses_response.dart';
import 'gigrr_type_response.dart';
import 'my_gigs_response.dart';

part 'candidate_gigs_request.freezed.dart';

part 'candidate_gigs_request.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class CandidateGigsRequestResponse with _$CandidateGigsRequestResponse {
  @JsonSerializable()
  const factory CandidateGigsRequestResponse.success(
    @JsonKey(name: "data") CandidateGigsRequestResponseData data,
    @JsonKey(name: "message") String message,
  ) = _CandidateGigsRequestResponse;

  @JsonSerializable()
  const factory CandidateGigsRequestResponse.error(
    @JsonKey(name: "status", defaultValue: 200) int status,
    @JsonKey(name: "message") String message,
  ) = _CandidateGigsRequestResponseError;

  factory CandidateGigsRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$CandidateGigsRequestResponseFromJson(json);
}

@freezed
@JsonToType()
class CandidateGigsRequestResponseData with _$CandidateGigsRequestResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory CandidateGigsRequestResponseData(
    @JsonKey(name: "current_page") int currentPage,
    @JsonKey(name: "data") List<CandidateGigsRequestData> gigsRequestData,
    @JsonKey(name: "from", defaultValue: 0) int from,
    @JsonKey(name: "last_page", defaultValue: 0) int lastPage,
    @JsonKey(name: "per_page", defaultValue: 0) int perPage,
    @JsonKey(name: "to", defaultValue: 0) int to,
    @JsonKey(name: "total", defaultValue: 0) int total,
  ) = _CandidateGigsRequestResponseData;

  factory CandidateGigsRequestResponseData.fromJson(
          Map<String, dynamic> json) =>
      _$CandidateGigsRequestResponseDataFromJson(json);
}

@freezed
@JsonToType()
class CandidateGigsRequestData with _$CandidateGigsRequestData {
  @JsonSerializable(explicitToJson: true)
  const factory CandidateGigsRequestData(
    @JsonKey(name: "id") int id,
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
    @JsonKey(name: "skills", defaultValue: [])
        List<GigrrTypeCategoryData> skillsCategoryList,
    @JsonKey(name: "gigrr_business", defaultValue: GetBusinessesData.getEmptyBusinesses)
        GetBusinessesData business,
    @JsonKey(name: "gigs_request", defaultValue: [])
        List<GigsRequestData> gigsRequestData,
    @JsonKey(name: "duration", defaultValue: 0) int duration,
    @JsonKey(name: "gender", defaultValue: "") String gender,
    @JsonKey(name: "state_id", defaultValue: 0) int stateId,
    @JsonKey(name: "roster_count", defaultValue: 0) int rosterCount,
    @JsonKey(name: "city_id") int cityId,
    @JsonKey(name: "updated_at", defaultValue: "") String updatedAt,
    @JsonKey(name: "created_at", defaultValue: "") String createdAt,
  ) = _CandidateGigsRequestData;

  factory CandidateGigsRequestData.fromJson(Map<String, dynamic> json) =>
      _$CandidateGigsRequestDataFromJson(json);
}
