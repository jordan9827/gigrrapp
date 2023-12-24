import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:square_demo_architecture/data/network/dtos/base_response.dart';
import 'package:square_demo_architecture/util/extensions/object_extension.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../domain/repos/notification_repos.dart';
import '../../util/exceptions/failures/failure.dart';
import '../network/api_services/notification_service.dart';
import '../network/app_chopper_client.dart';
import '../network/dtos/get_notification_response.dart';

class NotificationImpl extends NotificationRepo {
  final sharedPreferences = locator<SharedPreferences>();

  final notificationService =
      locator<AppChopperClient>().getService<NotificationService>();
  final log = getLogger("NotificationImpl");

  @override
  Future<Either<Failure, bool>> notificationSwitch(String data) async {
    try {
      final response = await notificationService.notificationSwitch(data);

      if (response.body == null) {
        return Left(Failure(-1, response.error!.handleFailureMessage()));
      }

      return response.body!.map(success: (user) async {
        return Right(true);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, GetNotificationResponseData>>
      fetchNotifications() async {
    try {
      final response = await notificationService.fetchNotifications();

      if (response.body == null) {
        return Left(Failure(-1, response.error!.handleFailureMessage()));
      }
      log.i("Notifications Response ${response.body}");
      return response.body!.map(success: (user) async {
        return Right(user.responseData);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> deleteNotifications() async {
    try {
      final response = await notificationService.deleteNotification();

      if (response.body == null) {
        return Left(Failure(-1, response.error!.handleFailureMessage()));
      }
      log.i("Delete Notifications Response ${response.body}");
      return response.body!.map(success: (user) async {
        return Right(user);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }
}
