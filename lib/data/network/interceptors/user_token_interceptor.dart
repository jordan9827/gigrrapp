import 'dart:async';
import 'package:chopper/chopper.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../others/constants.dart';
import '../dtos/user_auth_response_data.dart';

class UserTokenInterceptor extends RequestInterceptor {
  final log = getLogger("UserTokenInterceptor");

  @override
  FutureOr<Request> onRequest(Request request) async {
    UserAuthResponseData user = locator<UserAuthResponseData>();
    Map<String, String> headers = Map.from(request.headers);
    // if (user.accessToken.isNotEmpty) {
      headers.update(
        'Authorization',
        (value) => 'Bearer ${user.accessToken}',
        ifAbsent: () => 'Bearer ${user.accessToken}',
      );
      headers.update(
        'language',
        (value) => languageCode,
        ifAbsent: () => languageCode,
      );
    //}

    log.i(
        "<------------------------------------------------------------\nAPI ${request.url}\nRequest body ${request.body}\nHeaders ${request.headers}\nQuery params ${request.parameters}\nMultipart ${request.multipart}\nLanguage ${headers["language"]}\nToken ${headers["Authorization"]}\n---------------------------------------------------------------->");

    return request.copyWith(
      headers: headers,
    );
  }
}
