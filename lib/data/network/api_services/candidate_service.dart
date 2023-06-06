import 'package:chopper/chopper.dart';
import '../dtos/business_type_category.dart';
import '../dtos/candidate_roster_gigs_response.dart';
import '../dtos/gigs_accepted_response.dart';
import '../dtos/my_gigs_response.dart';

part 'candidate_service.chopper.dart';

@ChopperApi(baseUrl: "/api/")
abstract class CandidateService extends ChopperService {
  static CandidateService create() => _$CandidateService();

  @Get(path: "gigrr_types")
  Future<Response<BusinessTypeCategoryResponse>> businessTypeCategory();

  @Get(path: "candidates/my-roster-gigs")
  Future<Response<CandidateRosterResponse>> candidateRosterGigs(
    @Query('gigs_id') String id,
  );

  @Get(path: "gigs-accepted")
  Future<Response<GigsAcceptedResponse>> acceptedGigs(
    @Query('gigs_id') String id,
  );
}
