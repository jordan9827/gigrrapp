import 'package:dartz/dartz.dart';

import '../../util/exceptions/failures/failure.dart';

abstract class Auth {
  Future<Either<Failure, bool>> registerUser(Map<String, dynamic> data);
}
