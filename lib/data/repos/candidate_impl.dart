import 'package:dartz/dartz.dart';
import 'package:square_demo_architecture/data/network/dtos/business_profile_response.dart';
import 'package:square_demo_architecture/util/extensions/object_extension.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../domain/repos/candidate_repos.dart';
import '../../util/exceptions/failures/failure.dart';
import '../network/api_services/candidate_service.dart';
import '../network/app_chopper_client.dart';

class CandidateImpl extends CandidateRepo {
  final candidateService =
      locator<AppChopperClient>().getService<CandidateService>();
  final log = getLogger("CandidateImpl");

  // @override
  // Future<Either<Failure, BusinessProfileResponse>> addBusinessProfile(
  //     Map<String, dynamic> data) async {
  //   try {
  //     final response = await businessService.addBusinessProfileApi(data);
  //
  //     if (response.body == null) {
  //       throw Exception(response.error);
  //     }
  //     log.i("Login Response ${response.body}");
  //     return response.body!.map(success: (user) async {
  //       return Right(user);
  //     }, error: (error) {
  //       return Left(Failure(200, error.message));
  //     });
  //   } catch (e) {
  //     log.e(e);
  //     return Left(e.handleException());
  //   }
  // }
}
