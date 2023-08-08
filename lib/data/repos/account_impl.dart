import 'package:dartz/dartz.dart';
import 'package:square_demo_architecture/data/network/dtos/base_response.dart';
import 'package:square_demo_architecture/util/extensions/object_extension.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../domain/repos/account_repos.dart';
import '../../util/exceptions/failures/failure.dart';
import '../network/api_services/account_service.dart';
import '../network/app_chopper_client.dart';
import '../network/dtos/fetch_bank_detail_response.dart';
import '../network/dtos/payment_history_response.dart';

class AccountImpl extends AccountRepo {
  final accountService =
      locator<AppChopperClient>().getService<AccountService>();
  final log = getLogger("AccountImpl");

  @override
  Future<Either<Failure, PaymentHistoryResponseData>> candidatePaymentHistory({
    required Map<String, dynamic> data,
    required int page,
  }) async {
    try {
      final response = await accountService.candidatePaymentHistory(data, page);

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("PaymentHistory Response ${response.body}");
      return response.body!.map(success: (res) async {
        return Right(res.data);
      }, error: (error) {
        return Left(Failure(error.status, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, PaymentHistoryResponseData>> employerPaymentHistory({
    required Map<String, dynamic> data,
    required int page,
  }) async {
    try {
      final response = await accountService.employerPaymentHistory(data, page);

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("PaymentHistory Response ${response.body}");
      return response.body!.map(success: (res) async {
        return Right(res.data);
      }, error: (error) {
        return Left(Failure(error.status, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, GetBankDetailResponseData>>
      fetchCandidateBankDetail() async {
    try {
      final response = await accountService.fetchCandidateBankDetailApi();

      if (response.body == null) {
        throw Exception(response.error);
      }
      return response.body!.map(success: (res) async {
        return Right(res.data);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> addBankAccount(
      Map<String, dynamic> data) async {
    try {
      final response = await accountService.addBankAccountApi(data);

      if (response.body == null) {
        throw Exception(response.error);
      }
      return response.body!.map(success: (res) async {
        return Right(res);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> gigsCandidatePayment(
      Map<String, dynamic> data) async {
    try {
      final response = await accountService.gigsCandidatePaymentApi(data);

      if (response.body == null) {
        throw Exception(response.error);
      }
      return response.body!.map(success: (res) async {
        return Right(res);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> removeUserAccount() async {
    try {
      final response = await accountService.removeUserAccountApi();

      if (response.body == null) {
        throw Exception(response.error);
      }
      return response.body!.map(success: (res) async {
        return Right(res);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }
}
