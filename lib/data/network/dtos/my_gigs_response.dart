import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

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
  const factory MyGigsResponse.error(String message) = _MyGigsResponseError;

  factory MyGigsResponse.fromJson(Map<String, dynamic> json) =>
      _$MyGigsResponseFromJson(json);
}

@freezed
@JsonToType()
class MyGigsResponseData with _$MyGigsResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory MyGigsResponseData(
    @JsonKey(name: "current_page") int currentPage,
    @JsonKey(name: "data") List<MyGigsResponseList> gigsResponseList,
    @JsonKey(name: "first_page_url", defaultValue: "") String firstPageUrl,
    @JsonKey(name: "from", defaultValue: 0) int from,
    @JsonKey(name: "last_page", defaultValue: 0) int lastPage,
    @JsonKey(name: "last_page_url", defaultValue: "") String lastPageUrl,
    @JsonKey(name: "next_page_url", defaultValue: "") String nextPageUrl,
    @JsonKey(name: "path", defaultValue: "") String path,
    @JsonKey(name: "per_page", defaultValue: 0) int perPage,
    @JsonKey(name: "to", defaultValue: 0) int to,
    @JsonKey(name: "total", defaultValue: 0) int total,
  ) = _MyGigsResponseData;

  factory MyGigsResponseData.fromJson(Map<String, dynamic> json) =>
      _$MyGigsResponseDataFromJson(json);
}

@freezed
@JsonToType()
class MyGigsResponseList with _$MyGigsResponseList {
  @JsonSerializable(explicitToJson: true)
  const factory MyGigsResponseList(
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
    @JsonKey(name: "status", defaultValue: "") String createdAt,
    @JsonKey(name: "created_at", defaultValue: "") String status,
    @JsonKey(name: "gigs_starttime", defaultValue: "") String gigsStartTime,
    @JsonKey(name: "gigs_endtime", defaultValue: "") String gigsEndTime,
    @JsonKey(name: "price_criteria", defaultValue: "") String priceCriteria,
    @JsonKey(name: "gigs_request_count", defaultValue: 0) int gigsRequestCount,
    @JsonKey(name: "skills") List<GigrrTypeCategoryList> businessTypeList,
    @JsonKey(name: "duration", defaultValue: 0) int duration,
    @JsonKey(name: "gender", defaultValue: "") String gender,
    @JsonKey(name: "state_id", defaultValue: 0) int stateId,
    @JsonKey(name: "roster_count", defaultValue: 0) int rosterCount,
    @JsonKey(name: "city_id") int cityId,
  ) = _MyGigsResponseList;
  factory MyGigsResponseList.fromJson(Map<String, dynamic> json) =>
      _$MyGigsResponseListFromJson(json);
}
