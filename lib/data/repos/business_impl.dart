import 'package:dartz/dartz.dart';
import 'package:square_demo_architecture/data/network/api_services/business_service.dart';
import 'package:square_demo_architecture/data/network/dtos/business_profile_response.dart';
import 'package:square_demo_architecture/util/extensions/object_extension.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../domain/repos/business_repos.dart';
import '../../util/exceptions/failures/failure.dart';
import '../network/app_chopper_client.dart';

class BusinessImpl extends Business {
  final businessService =
      locator<AppChopperClient>().getService<BusinessService>();
  final log = getLogger("BusinessImpl");

  @override
  Future<Either<Failure, BusinessProfileData>> addBusinessProfile(
      Map<String, dynamic> data) async {
    try {
      final response = await businessService.addBusinessProfileApi(data);

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("Login Response ${response.body}");
      return response.body!.map(success: (user) async {
        return Right(user.businessProfileData);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }
}
