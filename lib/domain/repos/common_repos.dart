import 'package:dartz/dartz.dart';
import 'package:square_demo_architecture/data/network/dtos/chat_response.dart';
import 'package:square_demo_architecture/data/network/dtos/get_address_response.dart';

import '../../data/network/dtos/base_response.dart';
import '../../data/network/dtos/faq_response.dart';
import '../../data/network/dtos/get_chat_response.dart';
import '../../data/network/dtos/get_contact_subject.dart';
import '../../data/network/dtos/web_view_response.dart';
import '../../util/exceptions/failures/failure.dart';

abstract class CommonRepo {
  Future<Either<Failure, WebViewResponseData>> privacyPolicy();

  Future<Either<Failure, WebViewResponseData>> termsAndCondition();

  Future<Either<Failure, WebViewResponseData>> aboutUs();

  Future<Either<Failure, List<FAQResponseData>>> faq();

  Future<Either<Failure, List<GetAddressResponseData>>> fetchAddress();

  Future<Either<Failure, ChatResponseData>> saveChat(Map<String, dynamic> data);

  Future<Either<Failure, BaseResponse>> contactSupport(
    Map<String, dynamic> data,
  );

  Future<Either<Failure, GetChatResponseData>> getChat();

  Future<Either<Failure, List<GetContactSubjectData>>> fetchContactSubject();

  Future<Either<Failure, BaseResponse>> saveAddress(
    Map<String, dynamic> data,
  );
}
