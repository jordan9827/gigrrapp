import 'package:dartz/dartz.dart';
import 'package:square_demo_architecture/util/extensions/object_extension.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../domain/repos/auth_repos.dart';
import '../../util/exceptions/failures/failure.dart';
import '../../util/extensions/map_extension.dart';
import '../network/api_services/auth_service.dart';
import '../network/app_chopper_client.dart';
import '../network/dtos/user_auth_response_data.dart';

class AuthImpl extends Auth {
  final authService = locator<AppChopperClient>().getService<AuthService>();
  final log = getLogger("AuthImpl");

  @override
  Future<Either<Failure, UserAuthResponseData>> socialLogin(
      Map<String, dynamic> data) async {
    try {
      final response = await authService.socialLogin(data);

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("Login Response ${response.body}");
      return response.body!.map(success: (user) async {
        locator.unregister<UserAuthResponseData>();
        locator.registerSingleton<UserAuthResponseData>(user.data);
        return Right(user.data);
      }, error: (error) {
        return Left(Failure(int.parse(error.status), error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }
}
