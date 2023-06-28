import 'package:dartz/dartz.dart';
import 'package:square_demo_architecture/data/network/dtos/base_response.dart';
import 'package:square_demo_architecture/data/network/dtos/my_gigs_response.dart';
import '../../data/network/dtos/candidate_gigs_request.dart';
import '../../data/network/dtos/candidate_roster_gigs_response.dart';
import '../../data/network/dtos/gigs_accepted_response.dart';
import '../../util/exceptions/failures/failure.dart';

abstract class CandidateRepo {
  Future<Either<Failure, CandidateRosterResponseData>> candidateRosterGigs(
      int id);

  Future<Either<Failure, GigsAcceptedResponseData>> acceptedGigs(int id);

  Future<Either<Failure, CandidateGigsRequestResponseData>> getGigsRequest(
    Map<String, dynamic> body,
  );

  Future<Either<Failure, BaseResponse>> acceptedGigsRequest(int id);

  Future<Either<Failure, BaseResponse>> acceptedGigsOffer(
    Map<String, dynamic> body,
  );

  Future<Either<Failure, BaseResponse>> updateJobStatus(
    Map<String, dynamic> body,
  );
  Future<Either<Failure, BaseResponse>> gigsVerifyOTP(
    Map<String, dynamic> body,
  );
}
