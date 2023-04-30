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
    final user = locator<UserAuthResponseData>();
    String token = user.accessToken;
    Map<String, String> headers = Map.from(request.headers);
    if (user.accessToken.isNotEmpty) {
      headers.update(
        'Authorization',
        (value) => 'Bearer $token',
        ifAbsent: () => 'Bearer $token',
      );
    }

    log.i(
        "<------------------------------------------------------------\nAPI ${request.url}\nRequest body ${request.body}\nHeaders ${request.headers}\nQuery params ${request.parameters}\nMultipart ${request.multipart}\nToken $token\n---------------------------------------------------------------->");

    return request.copyWith(
      headers: headers,
    );
  }
}
