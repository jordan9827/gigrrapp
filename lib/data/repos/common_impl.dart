import 'package:dartz/dartz.dart';
import 'package:square_demo_architecture/data/network/dtos/base_response.dart';
import 'package:square_demo_architecture/data/network/dtos/faq_response.dart';
import 'package:square_demo_architecture/data/network/dtos/get_address_response.dart';
import 'package:square_demo_architecture/util/extensions/object_extension.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../domain/reactive_services/state_service.dart';
import '../../domain/repos/common_repos.dart';
import '../../util/exceptions/failures/failure.dart';
import '../network/api_services/common_service.dart';
import '../network/app_chopper_client.dart';
import '../network/dtos/chat_response.dart';
import '../network/dtos/get_chat_response.dart';
import '../network/dtos/get_contact_subject.dart';
import '../network/dtos/web_view_response.dart';

class CommonImpl extends CommonRepo {
  final commonService = locator<AppChopperClient>().getService<CommonService>();
  final log = getLogger("CommonImpl");

  @override
  Future<Either<Failure, ChatResponseData>> saveChat(
      Map<String, dynamic> data) async {
    try {
      final response = await commonService.saveChatApi(data);

      if (response.body == null) {
        throw Exception(response.error);
      }
      // log.i("saveChat Response ${response.body}");
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
  Future<Either<Failure, GetChatResponseData>> getChat() async {
    try {
      final response = await commonService.getChatApi();

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("getChat Response ${response.body}");
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
  Future<Either<Failure, WebViewResponseData>> privacyPolicy() async {
    try {
      final response = await commonService.privacyPolicyApi();

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
  Future<Either<Failure, WebViewResponseData>> termsAndCondition() async {
    try {
      final response = await commonService.termsAndConditionApi();

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
  Future<Either<Failure, List<FAQResponseData>>> faq() async {
    try {
      final response = await commonService.faqApi();

      if (response.body == null) {
        throw Exception(response.error);
      }
      return response.body!.map(success: (res) async {
        return Right(res.faqData);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, WebViewResponseData>> aboutUs() async {
    try {
      final response = await commonService.aboutUsApi();

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
  Future<Either<Failure, BaseResponse>> saveAddress(
      Map<String, dynamic> data) async {
    try {
      final response = await commonService.saveAddressApi(data);

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
  Future<Either<Failure, List<GetAddressResponseData>>> fetchAddress() async {
    try {
      final response = await commonService.fetchAddressApi();

      if (response.body == null) {
        throw Exception(response.error);
      }
      return response.body!.map(success: (res) async {
        locator<StateCityService>().fetchAddressList(res.addressList);
        return Right(res.addressList);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> contactSupport(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await commonService.contactSupportApi(data);

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
  Future<Either<Failure, List<GetContactSubjectData>>>
      fetchContactSubject() async {
    try {
      final response = await commonService.fetchContactSubjectApi();

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
}
