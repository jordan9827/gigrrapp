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
import '../network/dtos/base_response.dart';
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
        var data = await setUserResponse(user.data);
        return Right(data);
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
        await setUserResponse(user.data);
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
        var data = await setUserResponse(user.data);
        return Right(data);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, UserAuthResponseData>> candidatesCompleteProfile(
      Map<String, dynamic> data) async {
    try {
      final response = await authService.candidatesProfileApi(data);

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("Candidates Response 22 ${response.body}");
      return response.body!.map(success: (user) async {
        var data = await setUserResponse(user.data);
        return Right(data);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, UserAuthResponseData>> candidatesKYC(
      Map<String, dynamic> data) async {
    try {
      final response = await authService.candidatesKYCApi(data);

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("Login Response ${response.body}");
      return response.body!.map(success: (user) async {
        var data = await setUserResponse(user.data);
        return Right(data);
      }, error: (error) {
        return Left(Failure(200, error.message));
      });
    } catch (e) {
      log.e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, UserAuthResponseData>> sendOTP(
      Map<String, dynamic> data) async {
    try {
      final response = await authService.sendOTPApi(data);

      if (response.body == null) {
        throw Exception(response.error);
      }
      log.i("Login Response ${response.body}");
      return response.body!.map(success: (user) async {
        UserAuthResponseData data =
            user.data.copyWith(accessToken: user.data.token);
        await setUserResponse(data);
        return Right(data);
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
        var data = await setUserResponse(user.data);
        return Right(data);
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
      final response = await authService.logout();

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

  Future<UserAuthResponseData> setUserResponse(
      UserAuthResponseData user) async {
    var employer = setUserStatus(user.roleId);
    UserAuthResponseData data = user.copyWith(isEmployer: employer);
    locator.unregister<UserAuthResponseData>();
    locator.registerSingleton<UserAuthResponseData>(data);
    await sharedPreferences.setString(
        PreferenceKeys.USER_DATA.text, json.encode(data));
    return data;
  }

  bool setUserStatus(String id) {
    return id == "3" ? true : false;
  }
}
