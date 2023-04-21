import 'package:dartz/dartz.dart';
import 'package:square_demo_architecture/data/network/dtos/user_login_response.dart';
import 'package:square_demo_architecture/util/extensions/object_extension.dart';

import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../domain/repos/auth_repos.dart';
import '../../util/exceptions/failures/failure.dart';
import '../../util/extensions/map_extension.dart';
import '../network/api_services/auth_service.dart';
import '../network/app_chopper_client.dart';

class AuthImpl extends Auth {
  final authService = locator<AppChopperClient>().getService<AuthService>();
  final log = getLogger("AuthImpl");

  @override
  Future<Either<Failure, bool>> registerUser(Map<String, dynamic> data) async {
    try {
      final response = await authService.register(
        data,
      );

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("Login Response ${response.body}");
      final userLoginResponse =
          UserLoginResponse.fromJson(response.body!.validateApiResponse());
      return userLoginResponse.map(success: (user) async {
        print("$user");
        return const Right(true);
      }, error: (error) {
        return Left(Failure(int.parse(error.status), error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }
}
