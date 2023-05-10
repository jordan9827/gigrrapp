import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:square_demo_architecture/data/network/dtos/upload_image_response.dart';
import 'package:square_demo_architecture/util/extensions/object_extension.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../domain/repos/auth_repos.dart';
import '../../util/exceptions/failures/failure.dart';
import '../local/preference_keys.dart';
import '../network/api_services/auth_service.dart';
import '../network/api_services/notification_service.dart';
import '../network/app_chopper_client.dart';
import '../network/dtos/business_type_category.dart';
import '../network/dtos/user_auth_response_data.dart';

class AuthImpl extends Auth {
  final authService = locator<AppChopperClient>().getService<AuthService>();
  final sharedPreferences = locator<SharedPreferences>();

  final notificationService =
      locator<AppChopperClient>().getService<NotificationService>();
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
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, UserLoginResponse>> editProfile(
      Map<String, dynamic> data) async {
    try {
      final response = await authService.editProfile(data);

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("Edit Profile Response ${response.body}");
      return response.body!.map(success: (user) async {
        locator.unregister<UserAuthResponseData>();
        locator.registerSingleton<UserAuthResponseData>(user.data);
        return Right(user);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, UserAuthResponseData>> employerCompleteProfile(
      Map<String, dynamic> data) async {
    try {
      final response = await authService.completeProfileApi(data);

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("Login Response ${response.body}");
      return response.body!.map(success: (user) async {
        locator.unregister<UserAuthResponseData>();
        locator.registerSingleton<UserAuthResponseData>(user.data);
        await sharedPreferences.setString(
            PreferenceKeys.USER_DATA.text, json.encode(user.data));
        return Right(user.data);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, UserAuthResponseData>> verifyOTP(
      Map<String, dynamic> data) async {
    try {
      final response = await authService.verifyOTPApi(data);

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("Login Response ${response.body}");
      return response.body!.map(success: (user) async {
        // locator.unregister<UserAuthResponseData>();
        // locator.registerSingleton<UserAuthResponseData>(user.data);
        // await sharedPreferences.setString(
        //     PreferenceKeys.USER_DATA.text, json.encode(user.data));
        return Right(user.data);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, bool>> notificationSwitch(String data) async {
    try {
      final response = await notificationService.notificationSwitch(data);

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("Login Response ${response.body}");
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
  Future<Either<Failure, bool>> deleteImage(String data) async {
    try {
      final response = await authService.deleteImage({"image": data});

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("Login Response ${response.body}");
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
  Future<Either<Failure, UploadImageResponseData>> uploadImages(
      String imagePath) async {
    try {
      final response = await authService.uploadImages(imagePath);

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("Login Response ${response.body}");
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
  Future<Either<Failure, bool>> logout() async {
    try {
      final response = await notificationService.logout();

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("logout Response ${response.body}");
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
}
