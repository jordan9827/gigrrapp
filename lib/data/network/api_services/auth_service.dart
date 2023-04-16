import 'dart:io';

import 'package:chopper/chopper.dart';

import '../dtos/user_login_response.dart';

part 'auth_service.chopper.dart';

@ChopperApi(baseUrl: "/api/")
abstract class AuthService extends ChopperService {
  static AuthService create() => _$AuthService();
  // static const Map<String, String> header = {
  //   HttpHeaders.contentTypeHeader: 'application/json',
  //   'device-type': "android_customer",
  //   'device-version': "1.0.0"
  // };
  @Post(path: "login")
  Future<Response<UserLoginResponse>> login(
    @Body() Map<String, dynamic> credentials,
  );

  @Post(path: "register")
  Future<Response<UserLoginResponse>> register(
    @Body() Map<String, dynamic> credentials,
  );
}
