import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

part 'get_address_response.freezed.dart';

part 'get_address_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class GetAddressResponse with _$GetAddressResponse {
  @JsonSerializable()
  const factory GetAddressResponse.success(
    @JsonKey(name: "data", defaultValue: [])
        List<GetAddressResponseData> addressList,
    @JsonKey(name: "message", defaultValue: "") String message,
  ) = _GetAddressResponse;

  @JsonSerializable()
  const factory GetAddressResponse.error(
    @JsonKey(name: "status", defaultValue: 200) int status,
    @JsonKey(name: "message") String message,
  ) = _GetAddressResponseError;

  factory GetAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAddressResponseFromJson(json);
}

@freezed
@JsonToType()
class GetAddressResponseData with _$GetAddressResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory GetAddressResponseData(
    @JsonKey(name: "id", defaultValue: 0) int id,
    @JsonKey(name: "user_id", defaultValue: 0) int userId,
    @JsonKey(name: "address_type", defaultValue: "") String addressType,
    @JsonKey(name: "address", defaultValue: "") String address,
    @JsonKey(name: "pincode", defaultValue: "") String pincode,
    @JsonKey(name: "state", defaultValue: "") String state,
    @JsonKey(name: "faq_status", defaultValue: "") String city,
  ) = _GetAddressResponseData;

  factory GetAddressResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetAddressResponseDataFromJson(json);
}
