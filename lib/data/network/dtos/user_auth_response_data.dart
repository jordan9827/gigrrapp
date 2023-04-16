import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';

part 'user_auth_response_data.freezed.dart';

part 'user_auth_response_data.g.dart';

@freezed
@JsonToType()
class UserAuthResponseData with _$UserAuthResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory UserAuthResponseData(
    @JsonKey(name: "name") String name,
    @JsonKey(name: "id") int id,
    @JsonKey(name: "phone_number") phoneNumber,
    @JsonKey(name: "country_code") countryCode,
    @JsonKey(name: "status") status,
    @JsonKey(name: "email") String email,
  ) = _UserAuthResponseData;

  factory UserAuthResponseData.fromJson(Map<String, dynamic> json) =>
      _$UserAuthResponseDataFromJson(json);
}
