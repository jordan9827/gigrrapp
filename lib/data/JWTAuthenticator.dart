import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:fcm_service/fcm_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import '../app/app.logger.dart';
import '../app/app.router.dart';
import 'local/preference_keys.dart';

class JWTAuthenticator extends Authenticator {
  final log = getLogger('JWTAuthenticator');

  @override
  FutureOr<Request?> authenticate(Request request, Response response,
      [Request? originalRequest]) async {
    String responseDetails = "";
    try {
      final responseMap = json.decode(response.body) as Map<String, dynamic>;
      if (responseMap.containsKey('detail') &&
          responseMap['detail'] is String) {
        responseDetails = responseMap['detail'];
      }
    } catch (e) {
      return null;
    }
    log.i("StatusCode ----> ${response.statusCode}");
    if (response.statusCode == 401) {
      locator<SnackbarService>().showSnackbar(message: "Session Expire");
      await logOut();
      final requestBodyMap = _bodyMap(request.body);

      /*
      Create new map to serve as body for the new request. Coping body from the request
      provided is of type 'String' and passing that as body for new request causes issue
      to not being handled properly.
       */
      Map<String, dynamic> newBody = {};
      if (requestBodyMap != null) newBody.addAll(requestBodyMap);

      return request.copyWith(body: newBody);
    }
    return null;
  }

  Map<String, dynamic>? _bodyMap(dynamic body) {
    if (body != null) return json.decode(body) as Map<String, dynamic>;
    return null;
  }

  Future<void> logOut() async {
    final sharedPreferences = locator<SharedPreferences>();
    var lang =
        sharedPreferences.getString(PreferenceKeys.APP_LANGUAGE.text) ?? "hi";
    await sharedPreferences.clear();
    await locator.reset();
    await setupLocator();
    locator<FCMService>().deleteToken();
    await sharedPreferences.setBool(PreferenceKeys.FIRST_TIME.text, false);
    await sharedPreferences.setString(PreferenceKeys.APP_LANGUAGE.text, lang);
    locator<NavigationService>().clearStackAndShow(Routes.loginView);
  }
}
