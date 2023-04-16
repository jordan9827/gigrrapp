import 'package:chopper/chopper.dart';
import '../../others/constants.dart';
import '../../util/converter/json_to_type_converter.dart';
import 'package:http/http.dart' as http;
import 'api_services/auth_service.dart';
import 'interceptors/user_token_interceptor.dart';

class AppChopperClient extends ChopperClient {
  AppChopperClient({http.Client? httpClient})
      : super(
          baseUrl: Uri.parse(devBaseURL),
          interceptors: [
            UserTokenInterceptor(),
          ],
          converter: JsonToTypeConverter(),
          services: [
            AuthService.create(),
          ],
        );
}
