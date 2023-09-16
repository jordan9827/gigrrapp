import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_to_type/json_to_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/app.locator.dart';
import '../../local/preference_keys.dart';

part 'employer_request_preferences_model.freezed.dart';

part 'employer_request_preferences_model.g.dart';

@freezed
@JsonToType()
class EmployerRequestPreferencesResp with _$EmployerRequestPreferencesResp {
  @JsonSerializable(explicitToJson: true)
  const factory EmployerRequestPreferencesResp(
    @JsonKey(name: "business_id", defaultValue: "") String businessId,
    @JsonKey(name: "gender", defaultValue: "") String gender,
    @JsonKey(name: "skills", defaultValue: "") String skills,
    @JsonKey(name: "gig_name", defaultValue: "") String gigName,
    @JsonKey(name: "address", defaultValue: "") String address,
    @JsonKey(name: "form_amount", defaultValue: "") String fromAmount,
    @JsonKey(name: "to_amount", defaultValue: "") String toAmount,
    @JsonKey(name: "radius", defaultValue: "") String radius,
    @JsonKey(name: "latitude", defaultValue: "") String latitude,
    @JsonKey(name: "longitude", defaultValue: "") String longitude,
    @JsonKey(name: "start_date", defaultValue: "") String startDate,
    @JsonKey(name: "end_date", defaultValue: "") String endDate,
  ) = _EmployerRequestPreferencesResp;

  factory EmployerRequestPreferencesResp.fromJson(Map<String, dynamic> json) =>
      _$EmployerRequestPreferencesRespFromJson(json);

  static Future<EmployerRequestPreferencesResp> getUserData() async {
    var data = locator<SharedPreferences>()
        .getString(PreferenceKeys.GIGRR_PREFERENCES.text);
    if (data != null) {
      return EmployerRequestPreferencesResp.fromJson(jsonDecode(data));
    }
    return EmployerRequestPreferencesResp.fromJson({});
  }
}
