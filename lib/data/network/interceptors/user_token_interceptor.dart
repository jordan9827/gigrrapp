import 'dart:async';
import 'package:chopper/chopper.dart';
import '../../../app/app.logger.dart';
import '../../../others/constants.dart';

class UserTokenInterceptor extends RequestInterceptor {
  final log = getLogger("UserTokenInterceptor");
  Map<String, String> headerUpdate() {
    Map<String, String> headers = {};
    headers["Content-Type"] = "application/json";
    headers["device-type"] = androidDeviceType;
    headers["device-version"] = "1.0.0";
    return headers;
  }

  @override
  FutureOr<Request> onRequest(Request request) async {
    Map<String, String> headers = Map.from(request.headers);
    headers.addAll(headerUpdate());

    log.i(
        "<------------------------------------------------------------\nAPI ${request.url}\nRequest body ${request.body}\nHeaders ${request.headers}\nQuery params ${request.parameters}\n---------------------------------------------------------------->");

    return request.copyWith(headers: headers);
  }
}
