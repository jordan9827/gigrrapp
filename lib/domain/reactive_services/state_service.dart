import 'package:square_demo_architecture/data/network/dtos/state_response.dart';
import 'package:stacked/stacked.dart';
import '../../app/app.locator.dart';
import '../../data/network/dtos/city_response.dart';
import '../repos/auth_repos.dart';

class StateCityService with ListenableServiceMixin {
  final _stateList = <StateResponseData>[];
  final _cityList = <CityResponseData>[];
  final authRepo = locator<Auth>();

  List<StateResponseData> get stateList => _stateList;

  List<CityResponseData> get cityList => _cityList;

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
}
