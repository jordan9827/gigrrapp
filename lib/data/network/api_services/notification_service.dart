import 'package:chopper/chopper.dart';

import '../dtos/base_response.dart';

part 'notification_service.chopper.dart';

@ChopperApi(baseUrl: "/api/")
abstract class NotificationService extends ChopperService {
  static NotificationService create() => _$NotificationService();

  @Get(path: "notification-switch")
  Future<Response<BaseResponse>> notificationSwitch(
    @Query('status') String data,
  );

  @Post(path: "logout")
  Future<Response<BaseResponse>> logout();
}
