import 'package:dartz/dartz.dart';
import 'package:square_demo_architecture/data/network/dtos/chat_response.dart';

import '../../data/network/dtos/web_view_response.dart';
import '../../util/exceptions/failures/failure.dart';

abstract class AccountRepo {
  Future<Either<Failure, WebViewResponseData>> privacyPolicy();

  Future<Either<Failure, WebViewResponseData>> termsAndCondition();

  Future<Either<Failure, WebViewResponseData>> aboutUs();

  Future<Either<Failure, ChatResponseData>> saveChat(Map<String, dynamic> data);

  Future<Either<Failure, ChatResponseData>> getChat(int id);
}
