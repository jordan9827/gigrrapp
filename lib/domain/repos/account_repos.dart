import 'package:dartz/dartz.dart';
import 'package:square_demo_architecture/data/network/dtos/chat_response.dart';
import 'package:square_demo_architecture/data/network/dtos/get_address_response.dart';

import '../../data/network/dtos/base_response.dart';
import '../../data/network/dtos/faq_response.dart';
import '../../data/network/dtos/fetch_bank_detail_response.dart';
import '../../data/network/dtos/get_chat_response.dart';
import '../../data/network/dtos/payment_history_response.dart';
import '../../data/network/dtos/web_view_response.dart';
import '../../util/exceptions/failures/failure.dart';

abstract class AccountRepo {
  Future<Either<Failure, WebViewResponseData>> privacyPolicy();

  Future<Either<Failure, WebViewResponseData>> termsAndCondition();

  Future<Either<Failure, WebViewResponseData>> aboutUs();

  Future<Either<Failure, List<FAQResponseData>>> faq();

  Future<Either<Failure, BaseResponse>> removeUserAccount();

  Future<Either<Failure, GetBankDetailResponseData>> fetchCandidateBankDetail();

  Future<Either<Failure, List<GetAddressResponseData>>> fetchAddress();

  Future<Either<Failure, ChatResponseData>> saveChat(Map<String, dynamic> data);

  Future<Either<Failure, BaseResponse>> contactSupport(
    Map<String, dynamic> data,
  );

  Future<Either<Failure, PaymentHistoryResponseData>> candidatePaymentHistory({
    required Map<String, dynamic> data,
    required int page,
  });

  Future<Either<Failure, PaymentHistoryResponseData>> employerPaymentHistory({
    required Map<String, dynamic> data,
    required int page,
  });

  Future<Either<Failure, GetChatResponseData>> getChat();

  Future<Either<Failure, BaseResponse>> addBankAccount(
    Map<String, dynamic> data,
  );

  Future<Either<Failure, BaseResponse>> gigsCandidatePayment(
    Map<String, dynamic> data,
  );

  Future<Either<Failure, BaseResponse>> saveAddress(
    Map<String, dynamic> data,
  );
}
