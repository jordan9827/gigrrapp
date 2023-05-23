import 'package:dartz/dartz.dart';
import 'package:square_demo_architecture/data/network/api_services/business_service.dart';
import 'package:square_demo_architecture/data/network/dtos/business_profile_response.dart';
import 'package:square_demo_architecture/data/network/dtos/my_gigs_response.dart';
import 'package:square_demo_architecture/util/extensions/object_extension.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../domain/reactive_services/business_type_service.dart';
import '../../domain/repos/business_repos.dart';
import '../../util/exceptions/failures/failure.dart';
import '../network/app_chopper_client.dart';
import '../network/dtos/base_response.dart';
import '../network/dtos/business_type_category.dart';
import '../network/dtos/get_businesses_response.dart';
import '../network/dtos/gigrr_type_response.dart';
import '../network/dtos/web_view_response.dart';

class BusinessImpl extends BusinessRepo {
  final businessService =
      locator<AppChopperClient>().getService<BusinessService>();
  final log = getLogger("BusinessImpl");

  @override
  Future<Either<Failure, BusinessProfileResponse>> addBusinessProfile(
      Map<String, dynamic> data) async {
    try {
      final response = await businessService.addBusinessProfileApi(data);

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("Login Response ${response.body}");
      return response.body!.map(success: (user) async {
        return Right(user);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, BusinessProfileResponse>> updateBusinessProfile(
      Map<String, dynamic> data) async {
    try {
      final response = await businessService.updateBusinessProfileApi(data);

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("Business Profile Response ${response.body}");
      return response.body!.map(success: (user) async {
        return Right(user);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  static Future<BusinessImpl> getBusinessRepoImpl() {
    final businessRepo = BusinessImpl();
    return Future.value(businessRepo);
  }

  @override
  Future<Either<Failure, List<BusinessTypeCategoryList>>>
      businessTypeCategory() async {
    try {
      final response = await businessService.businessTypeCategory();

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("Login Response ${response.body}");
      return response.body!.map(success: (res) async {
        locator<BusinessTypeService>().updateBusinessType(res.businessTypeList);
        return Right(res.businessTypeList);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  static Future<BusinessImpl> getGigrrRepoImpl() {
    final businessRepo = BusinessImpl();
    return Future.value(businessRepo);
  }

  @override
  Future<Either<Failure, List<GigrrTypeCategoryList>>>
      gigrrTypeCategory() async {
    try {
      final response = await businessService.gigrrTypeCategory();

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("gigrrTypeCategory Response ${response.body}");
      return response.body!.map(success: (res) async {
        locator<BusinessTypeService>().updateGigrrName(res.gigrrTypeList);
        return Right(res.gigrrTypeList);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> addGigs(
      Map<String, dynamic> data) async {
    try {
      final response = await businessService.addGigsApi(data);

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("addGigrr Response ${response.body}");
      return response.body!.map(success: (res) async {
        return Right(res);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> ratingReview(
      Map<String, dynamic> data) async {
    try {
      final response = await businessService.ratingReviewApi(data);

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("addGigrr Response ${response.body}");
      return response.body!.map(success: (res) async {
        return Right(res);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, MyGigsResponseData>> fetchMyGigs() async {
    try {
      final response = await businessService.fetchGigsApi();

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("addGigrr Response ${response.body}");
      return response.body!.map(success: (res) async {
        return Right(res.responseData);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, GetBusinessesResponseData>>
      fetchAllBusinessesApi() async {
    try {
      final response = await businessService.fetchAllBusinesses();

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("addGigrr Response ${response.body}");
      return response.body!.map(success: (res) async {
        return Right(res.responseData);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }
}