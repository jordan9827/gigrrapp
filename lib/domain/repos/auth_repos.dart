import 'package:dartz/dartz.dart';
import 'package:square_demo_architecture/data/network/dtos/user_auth_response_data.dart';

import '../../util/exceptions/failures/failure.dart';

abstract class Auth {
  Future<Either<Failure, UserAuthResponseData>> socialLogin(
      Map<String, dynamic> data);
}
