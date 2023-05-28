import 'package:dartz/dartz.dart';
import 'package:square_demo_architecture/data/network/dtos/my_gigs_response.dart';
import '../../util/exceptions/failures/failure.dart';

abstract class CandidateRepo {
  Future<Either<Failure, MyGigsResponseData>> candidateRosterGigs(int id);

  Future<Either<Failure, MyGigsResponseData>> acceptedGigs(int id);
}
