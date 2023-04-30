import 'package:dartz/dartz.dart';
import 'package:square_demo_architecture/data/network/dtos/business_profile_response.dart';

import '../../util/exceptions/failures/failure.dart';

abstract class Business {
  Future<Either<Failure, BusinessProfileData>> addBusinessProfile(
      Map<String, dynamic> data);
}
