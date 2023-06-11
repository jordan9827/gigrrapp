import 'package:dartz/dartz.dart';
import 'package:square_demo_architecture/data/network/dtos/business_profile_response.dart';
import 'package:square_demo_architecture/data/network/dtos/my_gigs_response.dart';
import 'package:square_demo_architecture/util/extensions/object_extension.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../domain/repos/candidate_repos.dart';
import '../../util/exceptions/failures/failure.dart';
import '../network/api_services/candidate_service.dart';
import '../network/app_chopper_client.dart';
import '../network/dtos/candidate_gigs_request.dart';
import '../network/dtos/candidate_roster_gigs_response.dart';
import '../network/dtos/gigs_accepted_response.dart';

class CandidateImpl extends CandidateRepo {
  final candidateService =
      locator<AppChopperClient>().getService<CandidateService>();
  final log = getLogger("CandidateImpl");

  @override
  Future<Either<Failure, CandidateRosterResponseData>> candidateRosterGigs(
      int id) async {
    try {
      final response =
          await candidateService.candidateRosterGigs(id.toString());

      if (response.body == null) {
        throw Exception(response.error);
      }
      // log.i("Candidate Roster Gigs ${response.body}");
      return response.body!.map(success: (data) async {
        return Right(data.data);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, GigsAcceptedResponseData>> acceptedGigs(int id) async {
    try {
      final response = await candidateService.acceptedGigs(id.toString());

      if (response.body == null) {
        throw Exception(response.error);
      }
      // log.i("Accepted Roster Gigs ${response.body}");
      return response.body!.map(success: (data) async {
        return Right(data.responseData);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, CandidateGigsRequestResponseData>> getGigsRequest(
      Map<String, dynamic> body) async {
    try {
      final response = await candidateService.candidateGigsRequest(body);

      if (response.body == null) {
        throw Exception(response.error);
      }
      // log.i("Accepted Roster Gigs ${response.body}");
      return response.body!.map(success: (data) async {
        return Right(data.data);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }
}
