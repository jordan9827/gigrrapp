import 'package:dartz/dartz.dart';
import '../../data/network/dtos/base_response.dart';
import '../../data/network/dtos/get_notification_response.dart';
import '../../util/exceptions/failures/failure.dart';

abstract class NotificationRepo {
  Future<Either<Failure, bool>> notificationSwitch(String data);

  Future<Either<Failure, GetNotificationResponseData>> fetchNotifications();

  Future<Either<Failure, BaseResponse>> deleteNotifications();
}
