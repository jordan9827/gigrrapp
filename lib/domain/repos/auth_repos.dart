import 'package:dartz/dartz.dart';
import 'package:square_demo_architecture/data/network/dtos/user_auth_response_data.dart';

import '../../data/network/dtos/base_response.dart';
import '../../data/network/dtos/upload_image_response.dart';
import '../../util/exceptions/failures/failure.dart';

abstract class Auth {
  Future<Either<Failure, UserAuthResponseData>> socialLogin(
      Map<String, dynamic> data);

  Future<Either<Failure, UserLoginResponse>> editProfile(
      Map<String, dynamic> data);

  Future<Either<Failure, UserAuthResponseData>> verifyOTP(
      Map<String, dynamic> data);

  Future<Either<Failure, UserAuthResponseData>> employerCompleteProfile(
      Map<String, dynamic> data);

  Future<Either<Failure, bool>> notificationSwitch(String data);

  Future<Either<Failure, bool>> logout();

  Future<Either<Failure, UploadImageResponseData>> uploadImages(
      String imagePath);

  Future<Either<Failure, bool>> deleteImage(String imagePath);
}
