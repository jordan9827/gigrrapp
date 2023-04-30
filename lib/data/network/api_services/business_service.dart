import 'package:chopper/chopper.dart';
import 'package:square_demo_architecture/data/network/dtos/business_profile_response.dart';

part 'business_service.chopper.dart';

@ChopperApi(baseUrl: "/api/")
abstract class BusinessService extends ChopperService {
  static BusinessService create() => _$BusinessService();

  @Post(path: "business-profile")
  Future<Response<BusinessProfileResponse>> addBusinessProfileApi(
    @Body() Map<String, dynamic> businessBody,
  );
}
