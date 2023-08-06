import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

part 'fetch_bank_detail_response.freezed.dart';

part 'fetch_bank_detail_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class GetBankDetailResponse with _$GetBankDetailResponse {
  @JsonSerializable()
  const factory GetBankDetailResponse.success(
    @JsonKey(name: "data") GetBankDetailResponseData data,
    @JsonKey(name: "message", defaultValue: "") String message,
  ) = _GetBankDetailResponse;

  @JsonSerializable()
  const factory GetBankDetailResponse.error(String message) =
      _GetBankDetailResponseError;

  factory GetBankDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBankDetailResponseFromJson(json);
}

@freezed
@JsonToType()
class GetBankDetailResponseData with _$GetBankDetailResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory GetBankDetailResponseData(
    @JsonKey(name: "id", defaultValue: 0) int id,
    @JsonKey(name: "user_id", defaultValue: 0) int userId,
    @JsonKey(name: "account_holder_name", defaultValue: "") String holderName,
    @JsonKey(name: "role", defaultValue: "") String role,
    @JsonKey(name: "bank_name", defaultValue: "") String bankName,
    @JsonKey(name: "ifsc_code", defaultValue: "") String ifscCode,
    @JsonKey(name: "account_number", defaultValue: "") String accountNumber,
    @JsonKey(name: "account_type", defaultValue: "") String accountType,
    @JsonKey(name: "fund_account_id", defaultValue: "") String fundAccountId,
  ) = _GetBankDetailResponseData;

  factory GetBankDetailResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetBankDetailResponseDataFromJson(json);

  static GetBankDetailResponseData init() =>
      GetBankDetailResponseData(0, 0, "", "", "", "", "", "", "");
}
