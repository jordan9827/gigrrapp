import 'package:dartz/dartz.dart';

import '../../data/network/dtos/web_view_response.dart';
import '../../util/exceptions/failures/failure.dart';

abstract class AccountRepo {
  Future<Either<Failure, WebViewResponseData>> privacyPolicy();

  Future<Either<Failure, WebViewResponseData>> termsAndCondition();
}
