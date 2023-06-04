import 'package:chopper/chopper.dart';
import 'package:square_demo_architecture/data/network/dtos/upload_image_response.dart';
import '../dtos/base_response.dart';
import '../dtos/user_auth_response_data.dart';

part 'auth_service.chopper.dart';

@ChopperApi(baseUrl: "/api/")
abstract class AuthService extends ChopperService {
  static AuthService create() => _$AuthService();

  @Post(path: "login")
  Future<Response<Map<String, dynamic>>> login(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: "v2/send-otp")
  Future<Response<UserLoginResponse>> sendOTPApi(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: "v2/verify-otp")
  Future<Response<UserLoginResponse>> verifyOTPApi(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: "register")
  Future<Response<Map<String, dynamic>>> register(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: "update_profile")
  Future<Response<UserLoginResponse>> editProfile(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: "login")
  Future<Response<UserLoginResponse>> socialLogin(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: "complete_profile")
  Future<Response<UserLoginResponse>> completeProfileApi(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: "candidate_profile")
  Future<Response<UserLoginResponse>> candidatesProfileApi(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: "candidate_kyc")
  Future<Response<UserLoginResponse>> candidatesKYCApi(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: "delete-image")
  Future<Response<BaseResponse>> deleteImage(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: "upload-image")
  @multipart
  Future<Response<UploadImageResponse>> uploadImages(
    @PartFile("image[]") String path,
  );

  @Post(path: "logout")
  Future<Response<BaseResponse>> logout();
}
