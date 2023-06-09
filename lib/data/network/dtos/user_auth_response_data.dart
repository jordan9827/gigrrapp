import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/app.locator.dart';
import '../../local/preference_keys.dart';

part 'user_auth_response_data.freezed.dart';

part 'user_auth_response_data.g.dart';

@JsonToType()
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
class UserLoginResponse with _$UserLoginResponse {
  @JsonSerializable()
  const factory UserLoginResponse.success(
    UserAuthResponseData data,
    String message,
  ) = _UserLoginResponse;

  @JsonSerializable()
  const factory UserLoginResponse.error(
    @JsonKey(name: "status", defaultValue: 200) int status,
    @JsonKey(name: "message") String message,
  ) = _UserLoginResponseError;

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseFromJson(json);
}

@freezed
@JsonToType()
class UserAuthResponseData with _$UserAuthResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory UserAuthResponseData(
    @JsonKey(name: "full_name", defaultValue: "") String fullName,
    @JsonKey(name: "id", defaultValue: 0) int id,
    @JsonKey(name: "otp", defaultValue: 0) int otp,
    @JsonKey(name: "role_id", defaultValue: "") String roleId,
    @JsonKey(name: "mobile", defaultValue: "") String mobile,
    @JsonKey(name: "address", defaultValue: "") String address,
    @JsonKey(name: "phone_number", defaultValue: "") String phoneNumber,
    @JsonKey(name: "country_code", defaultValue: "") String countryCode,
    @JsonKey(name: "status", defaultValue: "") String status,
    @JsonKey(name: "profile_status", defaultValue: "") String profileStatus,
    @JsonKey(name: "email", defaultValue: "") String email,
    @JsonKey(name: "access_token", defaultValue: "") String accessToken,
    @JsonKey(name: "token", defaultValue: "") String token,
    @JsonKey(name: "is_notification", defaultValue: "") String notificationType,
    @JsonKey(name: "serve_job", defaultValue: "") String serveJob,
    @JsonKey(name: "image_url", defaultValue: "") String imageUrl,
    @JsonKey(name: "rating", defaultValue: 0.0) double rating,
    @JsonKey(name: "bank_account_status", defaultValue: 0) int bankStatus,
    @JsonKey(name: "latitude", defaultValue: "") String latitude,
    @JsonKey(name: "longitude", defaultValue: "") String longitude,
    @JsonKey(name: "gender", defaultValue: "") String gender,
    @JsonKey(name: "dob", defaultValue: "") String dob,
    @JsonKey(name: "aadhaar_verify_status", defaultValue: "")
        String aadhaarVerifyStatus,
    @JsonKey(name: "rajorpay_customer_id", defaultValue: "")
        String razorpayCustomerId,
    @JsonKey(name: "aadhar_image", defaultValue: "") String aadhaarImage,
    @JsonKey(name: "aadhar_number", defaultValue: "") String aadhaarNumber,
    // @JsonKey(name: "age", defaultValue: "") String age,
    @JsonKey(name: "employer", defaultValue: false) bool isEmployer,
  ) = _UserAuthResponseData;

  factory UserAuthResponseData.fromJson(Map<String, dynamic> json) =>
      _$UserAuthResponseDataFromJson(json);

  static Future<UserAuthResponseData> getUserData() async {
    var data =
        locator<SharedPreferences>().getString(PreferenceKeys.USER_DATA.text);
    if (data != null) {
      return UserAuthResponseData.fromJson(jsonDecode(data));
    }
    return getEmptyUser();
  }

  static Future<UserAuthResponseData> getEmptyUser() async {
    return const UserAuthResponseData("", 0, 0, "", "", "", "", "", "", "", "",
        "", "", "", "", "", 0, 0, "", "", "", "", "", "", "", "", false);
  }
}
