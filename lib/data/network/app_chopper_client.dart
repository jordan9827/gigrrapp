import 'package:chopper/chopper.dart';
import 'package:square_demo_architecture/data/network/api_services/account_service.dart';
import '../../others/constants.dart';
import '../../util/converter/json_to_type_converter.dart';
import 'package:http/http.dart' as http;
import 'api_services/auth_service.dart';
import 'api_services/business_service.dart';
import 'api_services/candidate_service.dart';
import 'api_services/notification_service.dart';
import 'interceptors/user_token_interceptor.dart';

class AppChopperClient extends ChopperClient {
  AppChopperClient({http.Client? httpClient})
      : super(
          baseUrl: Uri.parse(stagingBaseURL),
          interceptors: [
            UserTokenInterceptor(),
          ],
          converter: JsonToTypeConverter(),
          services: [
            AuthService.create(),
            AccountService.create(),
            BusinessService.create(),
            CandidateService.create(),
            NotificationService.create(),
          ],
        );
}
