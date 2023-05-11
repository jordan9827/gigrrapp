import 'package:chopper/chopper.dart';

import '../dtos/chat_response.dart';
import '../dtos/web_view_response.dart';
part 'account_service.chopper.dart';

@ChopperApi(baseUrl: "/api/")
abstract class AccountService extends ChopperService {
  static AccountService create() => _$AccountService();

  @Get(path: "privacy-policy")
  Future<Response<WebViewResponse>> privacyPolicyApi();

  @Get(path: "terms-condition")
  Future<Response<WebViewResponse>> termsAndConditionApi();

  @Get(path: "about-us")
  Future<Response<WebViewResponse>> aboutUsApi();

  @Post(path: "save-chat")
  Future<Response<ChatResponse>> saveChatApi(
    @Body() Map<String, dynamic> credentials,
  );

  @Get(path: "get-chat")
  Future<Response<ChatResponse>> getChatApi(
    @Query('page') String id,
  );
}
