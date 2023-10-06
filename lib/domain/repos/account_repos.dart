import 'package:dartz/dartz.dart';
import '../../data/network/dtos/base_response.dart';
import '../../data/network/dtos/fetch_bank_detail_response.dart';
import '../../data/network/dtos/fetch_upi_detail_response.dart';
import '../../data/network/dtos/payment_history_response.dart';
import '../../util/exceptions/failures/failure.dart';

abstract class AccountRepo {
  Future<Either<Failure, BaseResponse>> removeUserAccount();

  Future<Either<Failure, GetBankDetailResponseData>> fetchCandidateBankDetail();

  Future<Either<Failure, GetUpiDetailResponseData>> fetchCandidateUpiDetail();

  Future<Either<Failure, PaymentHistoryResponseData>> candidatePaymentHistory({
    required Map<String, dynamic> data,
    required int page,
  });

  Future<Either<Failure, PaymentHistoryResponseData>> employerPaymentHistory({
    required Map<String, dynamic> data,
    required int page,
  });

  Future<Either<Failure, GetBankDetailResponseData>> addBankAccount(
    Map<String, dynamic> data,
  );

  Future<Either<Failure, BaseResponse>> addUpiId(
    Map<String, dynamic> data,
  );

  Future<Either<Failure, BaseResponse>> gigsCandidatePayment(
    Map<String, dynamic> data,
  );
}
