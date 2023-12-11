import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:square_demo_architecture/data/network/dtos/state_response.dart';
import 'package:square_demo_architecture/data/network/dtos/user_auth_response_data.dart';
import 'package:stacked/stacked.dart';
import '../../app/app.locator.dart';
import '../../data/local/preference_keys.dart';
import '../../data/network/dtos/city_response.dart';
import '../../data/network/dtos/get_address_response.dart';
import '../repos/auth_repos.dart';

class StateCityService with ListenableServiceMixin {
  final _stateList = <StateResponseData>[];
  final _cityList = <CityResponseData>[];
  final _addressList = <GetAddressResponseData>[];
  final sharedPreferences = locator<SharedPreferences>();
  final authRepo = locator<Auth>();

  List<StateResponseData> get stateList => _stateList;

  List<GetAddressResponseData> get addressList => _addressList;

  List<CityResponseData> get cityList => _cityList;

  String containState(String state) {
    String tempState = "";
    for (var i in stateList) {
      if (i.name.toUpperCase() == state.toUpperCase()) {
        tempState = state.toUpperCase();
      }
    }
    return tempState;
  }

  String containCity(String city) {
    String tempCity = "";
    for (var i in cityList) {
      if (i.name.toUpperCase() == city.toUpperCase()) {
        tempCity = city.toUpperCase();
      }
    }
    return tempCity;
  }

  void updateState(List<StateResponseData> stateList) {
    _stateList.clear();
    _stateList.addAll(stateList);
    notifyListeners();
  }

  void updateCity(List<CityResponseData> cityList) {
    _cityList.clear();
    _cityList.addAll(cityList);
    notifyListeners();
  }

  Future<void> fetchAddressList(
    List<GetAddressResponseData> addressList,
  ) async {
    _addressList.clear();
    _addressList.addAll(addressList);
    if (addressList.isNotEmpty) {
      GetAddressResponseData data = addressList.firstWhere(
        (element) => element.defaultAddress == 1,
      );
      locator.unregister<GetAddressResponseData>();
      locator.registerSingleton<GetAddressResponseData>(data);
      await sharedPreferences.setString(
        PreferenceKeys.USER_ADDRESS_DATA.text,
        json.encode(data),
      );
    }
    if (addressList.isEmpty) await updateAddressDataToCandidate();
    notifyListeners();
  }

  Future<void> updateAddressDataToCandidate() async {
    var user = locator<UserAuthResponseData>();
    var addressUser = locator<GetAddressResponseData>();
    GetAddressResponseData data = addressUser.copyWith(
      address: user.address,
      addressType: "home",
      state: user.state,
      city: user.cityList.isNotEmpty
          ? user.cityList.first
          : UserCityResponse.emptyData(),
      latitude: user.latitude,
      longitude: user.longitude,
    );
    locator.unregister<GetAddressResponseData>();
    locator.registerSingleton<GetAddressResponseData>(data);
    await sharedPreferences.setString(
      PreferenceKeys.USER_ADDRESS_DATA.text,
      json.encode(data),
    );
  }
}
