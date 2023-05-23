import 'package:chopper/chopper.dart';
import 'package:square_demo_architecture/data/network/dtos/business_profile_response.dart';
import '../dtos/base_response.dart';
import '../dtos/business_type_category.dart';
import '../dtos/get_businesses_response.dart';
import '../dtos/gigrr_type_response.dart';
import '../dtos/my_gigs_response.dart';
import '../dtos/web_view_response.dart';

part 'candidate_service.chopper.dart';

@ChopperApi(baseUrl: "/api/")
abstract class CandidateService extends ChopperService {
  static CandidateService create() => _$CandidateService();

  @Get(path: "gigrr_types")
  Future<Response<BusinessTypeCategoryResponse>> businessTypeCategory();
}
