import 'dart:io';

import 'package:chopper/chopper.dart';

import '../dtos/user_login_response.dart';

part 'auth_service.chopper.dart';

@ChopperApi(baseUrl: "/api/")
abstract class AuthService extends ChopperService {
  static AuthService create() => _$AuthService();

  @Post(path: "login")
  Future<Response<UserLoginResponse>> login(
    @Body() Map<String, dynamic> credentials,
  );

  @Post(path: "register")
  Future<Response<UserLoginResponse>> register(
    @Body() Map<String, dynamic> credentials,
  );
}
