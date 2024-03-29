import 'package:chopper/chopper.dart';
import 'package:square_demo_architecture/data/network/dtos/base_response.dart';
import '../dtos/chat_response.dart';
import '../dtos/faq_response.dart';
import '../dtos/fetch_bank_detail_response.dart';
import '../dtos/get_address_response.dart';
import '../dtos/get_chat_response.dart';
import '../dtos/payment_history_response.dart';
import '../dtos/web_view_response.dart';

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

  @Get(path: "privacy-policy")
  Future<Response<WebViewResponse>> privacyPolicyApi();

  @Get(path: "terms-condition")
  Future<Response<WebViewResponse>> termsAndConditionApi();

  @Get(path: "about-us")
  Future<Response<WebViewResponse>> aboutUsApi();

  @Get(path: "faq")
  Future<Response<FAQResponse>> faqApi();

  @Get(path: "address")
  Future<Response<GetAddressResponse>> fetchAddressApi();

  @Post(path: "send-contactus")
  Future<Response<BaseResponse>> contactSupportApi(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: "save-chat")
  Future<Response<ChatResponse>> saveChatApi(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: "save-address")
  Future<Response<BaseResponse>> saveAddressApi(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: "gigs-candidate-payment")
  Future<Response<BaseResponse>> gigsCandidatePaymentApi(
    @Body() Map<String, dynamic> body,
  );

  @Get(path: "get-chat")
  Future<Response<GetChatResponse>> getChatApi();

  @Delete(path: "account/delete")
  Future<Response<BaseResponse>> removeUserAccountApi();
}
