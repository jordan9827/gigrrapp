import 'package:chopper/chopper.dart';
import 'package:square_demo_architecture/data/network/dtos/base_response.dart';
import '../dtos/fetch_bank_detail_response.dart';
import '../dtos/fetch_upi_detail_response.dart';
import '../dtos/payment_history_response.dart';

part 'account_service.chopper.dart';

@ChopperApi(baseUrl: "/api/")
abstract class AccountService extends ChopperService {
  static AccountService create() => _$AccountService();

  @Post(path: "candidates/save-bank-account")
  Future<Response<BaseResponse>> addBankAccountApi(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: "candidates/payment_history")
  Future<Response<PaymentHistoryResponse>> candidatePaymentHistory(
    @Body() Map<String, dynamic> body,
    @Query('page') int page,
  );

  @Get(path: "candidates/bank-info")
  Future<Response<GetBankDetailResponse>> fetchCandidateBankDetailApi();

  @Post(path: "gigs-payment-history")
  Future<Response<PaymentHistoryResponse>> employerPaymentHistory(
    @Body() Map<String, dynamic> body,
    @Query('page') int page,
  );

  @Post(path: "gigs-candidate-payment")
  Future<Response<BaseResponse>> gigsCandidatePaymentApi(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: "candiate/save_upi_id")
  Future<Response<BaseResponse>> addUPIApi(
    @Body() Map<String, dynamic> body,
  );

  @Get(path: "candiate/upi_id")
  Future<Response<GetUpiDetailResponse>> fetchUpiApi();

  @Delete(path: "account/delete")
  Future<Response<BaseResponse>> removeUserAccountApi();
}
