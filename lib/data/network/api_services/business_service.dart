import 'package:chopper/chopper.dart';
import 'package:square_demo_architecture/data/network/dtos/business_profile_response.dart';
import '../dtos/base_response.dart';
import '../dtos/business_type_category.dart';
import '../dtos/calender_wise_response.dart';
import '../dtos/employer_gigs_request.dart';
import '../dtos/get_businesses_response.dart';
import '../dtos/gigrr_type_response.dart';
import '../dtos/my_gigrrs_roster_response.dart';
import '../dtos/my_gigs_response.dart';
part 'business_service.chopper.dart';

@ChopperApi(baseUrl: "/api/")
abstract class BusinessService extends ChopperService {
  static BusinessService create() => _$BusinessService();

  @Post(path: "business-profile")
  Future<Response<BusinessProfileResponse>> addBusinessProfileApi(
    @Body() Map<String, dynamic> businessBody,
  );

  @Post(path: "update_business_profile")
  Future<Response<BusinessProfileResponse>> updateBusinessProfileApi(
    @Body() Map<String, dynamic> businessBody,
  );

  @Post(path: "gigs-booking")
  Future<Response<BaseResponse>> addGigsApi(
    @Body() Map<String, dynamic> body,
  );

  @Get(path: "my-gigs")
  Future<Response<MyGigsResponse>> fetchGigsApi();

  @Get(path: "category")
  Future<Response<BusinessTypeCategoryResponse>> businessTypeCategory();

  @Get(path: "gigrr_types")
  Future<Response<GigrrTypeCategoryResponse>> gigrrTypeCategory();

  @Get(path: "get_all_business_profile")
  Future<Response<GetBusinessesResponse>> fetchAllBusinesses();

  @Post(path: "rating-review")
  Future<Response<BaseResponse>> ratingReviewApi(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: "search-candidate-via-gigs")
  Future<Response<EmployerGigsRequestResponse>> employerGigsRequest(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: "add-candidate-roster")
  Future<Response<BaseResponse>> shortListedCandidateApi(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: "gigs-candidate-offer")
  Future<Response<BaseResponse>> gigsCandidateOfferApi(
    @Body() Map<String, dynamic> body,
  );

  @Get(path: "gigs-calender-wise")
  Future<Response<CalenderWiseResponse>> getCandidateApi();

  @Get(path: "my-roster-via-gigs")
  Future<Response<MyGigrrsRosterResponse>> myGigrrsRosterApi(
    @Query('gigs_id') String id,
  );
}
