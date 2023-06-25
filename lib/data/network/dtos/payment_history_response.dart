import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

import 'get_businesses_response.dart';
import 'gigrr_type_response.dart';

part 'payment_history_response.freezed.dart';

part 'payment_history_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class PaymentHistoryResponse with _$PaymentHistoryResponse {
  @JsonSerializable()
  const factory PaymentHistoryResponse.success(
    @JsonKey(name: "data") PaymentHistoryResponseData data,
    @JsonKey(name: "message") String message,
  ) = _PaymentHistoryResponse;

  @JsonSerializable()
  const factory PaymentHistoryResponse.error(
    @JsonKey(name: "status", defaultValue: 200) int status,
    @JsonKey(name: "message") String message,
  ) = _PaymentHistoryResponseError;

  factory PaymentHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentHistoryResponseFromJson(json);
}

@freezed
@JsonToType()
class PaymentHistoryResponseData with _$PaymentHistoryResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory PaymentHistoryResponseData(
    @JsonKey(name: "current_page") int currentPage,
    @JsonKey(name: "data") List<PaymentHistoryData> paymentHistoryData,
    @JsonKey(name: "from", defaultValue: 0) int from,
    @JsonKey(name: "last_page", defaultValue: 0) int lastPage,
    @JsonKey(name: "per_page", defaultValue: 0) int perPage,
    @JsonKey(name: "to", defaultValue: 0) int to,
    @JsonKey(name: "total", defaultValue: 0) int total,
  ) = _PaymentHistoryResponseData;

  factory PaymentHistoryResponseData.fromJson(Map<String, dynamic> json) =>
      _$PaymentHistoryResponseDataFromJson(json);
}

@freezed
@JsonToType()
class PaymentHistoryData with _$PaymentHistoryData {
  @JsonSerializable(explicitToJson: true)
  const factory PaymentHistoryData(
    @JsonKey(name: "id") int id,
    @JsonKey(name: "employer_id", defaultValue: 0) int employerId,
    @JsonKey(name: "candidate_id", defaultValue: 0) int candidateId,
    @JsonKey(name: "gigs_id", defaultValue: 0) int gigsId,
    @JsonKey(name: "candidate_transfer_amount", defaultValue: 0)
        int candidateTransferAmount,
    @JsonKey(name: "payment_mode", defaultValue: "") String paymentMode,
    @JsonKey(name: "discount", defaultValue: "") String discount,
    @JsonKey(name: "amount", defaultValue: "") String amount,
    @JsonKey(name: "candidate_income", defaultValue: "") String candidateIncome,
    @JsonKey(name: "admin_commission", defaultValue: "") String adminCommission,
    @JsonKey(name: "admin_income", defaultValue: "") String adminIncome,
    @JsonKey(name: "status", defaultValue: "") String status,
    @JsonKey(name: "currency", defaultValue: "") String currency,
    @JsonKey(name: "transaction_id", defaultValue: "") String transactionId,
    @JsonKey(name: "skills", defaultValue: [])
        List<GigrrTypeCategoryData> skillsTypeCategoryList,
    @JsonKey(name: "updated_at", defaultValue: "") String updatedAt,
    @JsonKey(name: "employer", defaultValue: UserResponse.getEmptyUserResponse)
        UserResponse employer,
    @JsonKey(name: "candidate", defaultValue: UserResponse.getEmptyUserResponse)
        UserResponse candidate,
    @JsonKey(name: "created_at", defaultValue: "") String createdAt,
  ) = _PaymentHistoryData;

  factory PaymentHistoryData.fromJson(Map<String, dynamic> json) =>
      _$PaymentHistoryDataFromJson(json);
}

@freezed
@JsonToType()
class UserResponse with _$UserResponse {
  @JsonSerializable(explicitToJson: true)
  const factory UserResponse(
    @JsonKey(name: "id", defaultValue: 0) int id,
    @JsonKey(name: "role_id", defaultValue: "") String roleId,
    @JsonKey(name: "first_name", defaultValue: "") String firstName,
    @JsonKey(name: "last_name", defaultValue: "") String lastName,
    @JsonKey(name: "country_code", defaultValue: "") String countryCode,
    @JsonKey(name: "email", defaultValue: "") String email,
    @JsonKey(name: "mobile", defaultValue: "") String mobile,
    @JsonKey(name: "rating", defaultValue: 0.0) double rating,
    @JsonKey(name: "age", defaultValue: "") String age,
    @JsonKey(name: "dob", defaultValue: "") String dob,
    @JsonKey(name: "longitude", defaultValue: "") String longitude,
    @JsonKey(name: "latitude", defaultValue: "") String latitude,
    @JsonKey(name: "address", defaultValue: "") String address,
    @JsonKey(name: "profile_image", defaultValue: "") String profileImage,
    @JsonKey(name: "gender", defaultValue: "") String gender,
  ) = _UserResponse;

  static getEmptyUserResponse() {
    return UserResponse.fromJson({});
  }

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
