import '../../app/app.locator.dart';
import '../../domain/reactive_services/state_service.dart';

class StateCityHelper {
  static final stateCityService = locator<StateCityService>();

  static String findId({
    bool isState = true,
    String value = "",
  }) {
    int id = 0;
    if (isState) {
      for (var i in stateCityService.stateList) {
        if (i.name.toUpperCase() == value.toUpperCase()) {
          id = i.id;
        }
      }
    } else if (!isState) {
      for (var i in stateCityService.cityList) {
        if (i.name.toUpperCase() == value.toUpperCase()) {
          id = i.id;
        }
      }
    }
    return "$id";
  }
}
