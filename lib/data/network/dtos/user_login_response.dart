import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';
import 'package:square_demo_architecture/data/network/dtos/user_auth_response_data.dart';

part 'user_login_response.freezed.dart';

part 'user_login_response.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class UserLoginResponse with _$UserLoginResponse {
  @JsonSerializable()
  const factory UserLoginResponse.success(
    UserAuthResponseData data,
  ) = _UserLoginResponse;

  @JsonSerializable()
  const factory UserLoginResponse.error(String status, String message) =
      _UserLoginResponseError;

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseFromJson(json);
}
