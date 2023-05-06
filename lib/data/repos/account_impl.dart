import 'package:dartz/dartz.dart';
import 'package:square_demo_architecture/util/extensions/object_extension.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../domain/repos/account_repos.dart';
import '../../util/exceptions/failures/failure.dart';
import '../network/api_services/account_service.dart';
import '../network/app_chopper_client.dart';
import '../network/dtos/web_view_response.dart';

class AccountImpl extends AccountRepo {
  final accountService = locator<AppChopperClient>().getService<AccountService>();
  final log = getLogger("AccountImpl");

  @override
  Future<Either<Failure, WebViewResponseData>> privacyPolicy() async {
    try {
      final response = await accountService.privacyPolicyApi();

      if (response.body == null) {
        throw Exception(response.error);
      }
      // log.i("privacyPolicy Response ${response.body}");
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
      final response = await accountService.termsAndConditionApi();

      if (response.body == null) {
        throw Exception(response.error);
      }
      // log.i("termsAndCondition Response ${response.body}");
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
