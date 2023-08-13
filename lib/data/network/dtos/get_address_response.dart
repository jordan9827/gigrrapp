import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';
import 'package:square_demo_architecture/data/network/dtos/user_auth_response_data.dart';

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
    @JsonKey(name: "pincode", defaultValue: "") String postCode,
    @JsonKey(name: "default_address", defaultValue: 0) int defaultAddress,
    @JsonKey(name: "state_id", defaultValue: 0) int stateId,
    @JsonKey(name: "city_id", defaultValue: 0) int cityId,
    @JsonKey(name: "state", defaultValue: UserStateResponse.emptyData)
        UserStateResponse state,
    @JsonKey(name: "city", defaultValue: UserCityResponse.emptyData)
        UserCityResponse city,
  ) = _GetAddressResponseData;

  factory GetAddressResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetAddressResponseDataFromJson(json);

  static GetAddressResponseData emptyData() =>
      GetAddressResponseData.fromJson({});
}
