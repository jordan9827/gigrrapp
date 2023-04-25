import 'package:chopper/chopper.dart';
import '../dtos/user_auth_response_data.dart';

part 'auth_service.chopper.dart';

@ChopperApi(baseUrl: "/api/")
abstract class AuthService extends ChopperService {
  static AuthService create() => _$AuthService();

  @Post(path: "login")
  Future<Response<Map<String, dynamic>>> login(
    @Body() Map<String, dynamic> credentials,
  );

  @Post(path: "register")
  Future<Response<Map<String, dynamic>>> register(
    @Body() Map<String, dynamic> credentials,
  );

  @Post(path: "login")
  Future<Response<UserLoginResponse>> socialLogin(
    @Body() Map<String, dynamic> body,
  );
}
