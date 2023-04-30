import 'package:chopper/chopper.dart';
import 'package:square_demo_architecture/data/network/dtos/business_type_category.dart';
import 'package:square_demo_architecture/data/network/dtos/upload_image_response.dart';
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
  @Post(path: "complete_profile")
  Future<Response<UserLoginResponse>> completeProfileApi(
    @Body() Map<String, dynamic> body,
  );

  @Get(path: "category")
  Future<Response<BusinessTypeCategoryResponse>> businessTypeCategory();

  @Post(path: "upload-image")
  @multipart
  Future<Response<UploadImageResponse>> uploadImages(
    @PartFile("image[]") String path,
  );
}
