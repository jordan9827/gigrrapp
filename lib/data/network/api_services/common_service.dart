import 'package:chopper/chopper.dart';
import 'package:square_demo_architecture/data/network/dtos/base_response.dart';
import '../dtos/chat_response.dart';
import '../dtos/faq_response.dart';
import '../dtos/get_address_response.dart';
import '../dtos/get_chat_response.dart';
import '../dtos/get_contact_subject.dart';
import '../dtos/web_view_response.dart';

part 'common_service.chopper.dart';

@ChopperApi(baseUrl: "/api/")
abstract class CommonService extends ChopperService {
  static CommonService create() => _$CommonService();

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

  @Get(path: "get-chat")
  Future<Response<GetChatResponse>> getChatApi();

  @Get(path: "contact-subject")
  Future<Response<GetContactSubjectResponse>> fetchContactSubjectApi();
}
