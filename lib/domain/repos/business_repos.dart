import 'package:dartz/dartz.dart';
import 'package:square_demo_architecture/data/network/dtos/business_profile_response.dart';
import 'package:square_demo_architecture/data/network/dtos/my_gigs_response.dart';
import '../../data/network/dtos/base_response.dart';
import '../../data/network/dtos/business_type_category.dart';
import '../../data/network/dtos/calender_wise_response.dart';
import '../../data/network/dtos/employer_gigs_request.dart';
import '../../data/network/dtos/get_businesses_response.dart';
import '../../data/network/dtos/gigrr_type_response.dart';
import '../../data/network/dtos/my_gigrrs_roster_response.dart';
import '../../util/exceptions/failures/failure.dart';

abstract class BusinessRepo {
  Future<Either<Failure, BusinessProfileResponse>> addBusinessProfile(
      Map<String, dynamic> data);

  Future<Either<Failure, BusinessProfileResponse>> updateBusinessProfile(
      Map<String, dynamic> data);

  Future<Either<Failure, List<BusinessTypeCategoryList>>>
      businessTypeCategory();

  Future<Either<Failure, List<GigrrTypeCategoryData>>> gigrrTypeCategory();

  Future<Either<Failure, BaseResponse>> addGigs(Map<String, dynamic> data);

  Future<Either<Failure, BaseResponse>> ratingReview(Map<String, dynamic> data);

  Future<Either<Failure, MyGigsResponseData>> fetchMyGigs();

  Future<Either<Failure, Map<String, dynamic>>> getCandidate();

  Future<Either<Failure, GetBusinessesResponseData>> fetchAllBusinessesApi();

  Future<Either<Failure, EmployerGigsRequestResponseData>> employerGigsRequest(
    Map<String, dynamic> body,
  );

  Future<Either<Failure, BaseResponse>> shortListedCandidate(
    Map<String, dynamic> body,
  );

  Future<Either<Failure, MyGigrrsRosterData>> myGigrrsRoster(
    String id,
  );

  Future<Either<Failure, BaseResponse>> gigsCandidateOffer(
    Map<String, dynamic> body,
  );
}
