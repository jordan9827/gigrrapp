import 'package:dartz/dartz.dart';
import 'package:square_demo_architecture/data/network/dtos/business_profile_response.dart';
import 'package:square_demo_architecture/data/network/dtos/my_gigs_response.dart';
import '../../data/network/dtos/base_response.dart';
import '../../data/network/dtos/business_type_category.dart';
import '../../data/network/dtos/get_businesses_response.dart';
import '../../data/network/dtos/gigrr_type_response.dart';
import '../../util/exceptions/failures/failure.dart';

abstract class BusinessRepo {
  Future<Either<Failure, BusinessProfileData>> addBusinessProfile(
      Map<String, dynamic> data);

  Future<Either<Failure, List<BusinessTypeCategoryList>>>
      businessTypeCategory();

  Future<Either<Failure, List<GigrrTypeCategoryList>>> gigrrTypeCategory();

  Future<Either<Failure, BaseResponse>> addGigs(Map<String, dynamic> data);

  Future<Either<Failure, MyGigsResponseData>> fetchMyGigs();

  Future<Either<Failure, GetBusinessesResponseData>> fetchAllBusinessesApi();
}
