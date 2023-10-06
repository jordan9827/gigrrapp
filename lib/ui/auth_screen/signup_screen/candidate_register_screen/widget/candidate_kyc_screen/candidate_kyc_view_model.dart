import 'dart:convert';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../../../app/app.locator.dart';
import '../../../../../../app/app.router.dart';
import '../../../../../../data/local/preference_keys.dart';
import '../../../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../../../domain/repos/auth_repos.dart';
import '../../../../../../others/constants.dart';
import '../../../../../widgets/image_picker_util.dart';

class CandidateKYCViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final authRepo = locator<Auth>();
  final sharedPreferences = locator<SharedPreferences>();
  final TextEditingController aadhaarController = TextEditingController();
  String frontAadhaarImage = "";
  String backAadhaarImage = "";
  XFile? _imageFile;
  String socialType = "";
  String socialId = "";
  bool isSocialLogin = false;
  final user = locator<UserAuthResponseData>();

  XFile? get imageFile => _imageFile;

  CandidateKYCViewModel({
    String socialType = "",
    String socialId = "",
    bool social = false,
  }) {
    this.socialType = socialType;
    this.socialId = socialId;
    isSocialLogin = social;
  }

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  void navigationToHomeScreen() {
    navigationService.clearStackAndShow(Routes.homeView);
  }

  bool validationCompleteProfile() {
    if (aadhaarController.text.isEmpty) {
      snackBarService.showSnackbar(
        message: "aadhaar_no_msg".tr(),
      );
      return false;
    } else if (frontAadhaarImage.isEmpty) {
      snackBarService.showSnackbar(
        message: "aadhaar_font_msg".tr(),
      );
      return false;
    } else if (backAadhaarImage.isEmpty) {
      snackBarService.showSnackbar(
        message: "aadhaar_back_msg".tr(),
      );
      return false;
    }
    return true;
  }

  void candidateKYCApi() async {
    if (validationCompleteProfile()) {
      setBusy(true);
      final response = await authRepo.candidatesKYC(
        await _getRequestForCandidateKYC(),
      );
      response.fold(
        (fail) {
          snackBarService.showSnackbar(message: fail.errorMsg);
          setBusy(false);
        },
        (res) async {
          if (isSocialLogin) {
            await verifyOTPForSocialLogin(res);
          } else {
            navigationToHomeScreen();
            if (user.profileStatus == "profile-completed") {
              updateBankStatusToLocal();
            }
          }
          setBusy(false);
        },
      );
      notifyListeners();
    }
  }

  Future<void> loadSkipKYC(UserAuthResponseData res) async {
    if (isSocialLogin) {
      await verifyOTPForSocialLogin(res);
    } else {
      navigationToHomeScreen();
    }
  }

  Future<void> verifyOTPForSocialLogin(UserAuthResponseData res) async {
    var result = await navigationService.navigateTo(
      Routes.oTPVerifyScreen,
      arguments: OTPVerifyScreenArguments(
        mobile: res.mobile,
        roleId: res.roleId,
        socialType: socialType,
        socialId: socialId,
        loginType: "social",
      ),
    );
    if (result["isCheck"] ?? false) {
      navigationToHomeScreen();
    }
  }

  Future<void> updateBankStatusToLocal() async {
    UserAuthResponseData data = user.copyWith(profileStatus: "completed");
    locator.unregister<UserAuthResponseData>();
    locator.registerSingleton<UserAuthResponseData>(data);
    await sharedPreferences.setString(
      PreferenceKeys.USER_DATA.text,
      json.encode(data),
    );
  }

  Future pickImage(BuildContext context, {bool isFontImage = true}) async {
    XFile pickImage = await _showImagePicker(context);
    final imageFile = await ImagePickerUtil.cropImage(
      PickedFile(pickImage.path),
    );
    if (imageFile != null) {
      _imageFile = XFile(imageFile.path);
      await uploadMediaForBusiness(
        imagePath: imageFile.path,
        pickImage: isFontImage,
      );
      setBusy(false);
      notifyListeners();
    }
  }

  Future<XFile> _showImagePicker(context) async {
    return await ImagePickerUtil.showCameraOrGalleryChooser(context);
  }

  Future<void> uploadMediaForBusiness(
      {required String imagePath, required bool pickImage}) async {
    setBusy(true);
    final response = await authRepo.uploadImages(imagePath);
    response.fold((failure) {
      setBusy(false);
      snackBarService.showSnackbar(message: failure.errorMsg);
    }, (response) {
      if (pickImage) {
        frontAadhaarImage = response.imageList.first;
      } else {
        backAadhaarImage = response.imageList.first;
      }
      notifyListeners();
    });
  }

  Future<void> deleteImageApi(
      {required String imagePath, required bool pickImage}) async {
    setBusy(true);
    final response = await authRepo.deleteImage(imagePath);

    response.fold((failure) {
      setBusy(false);
      snackBarService.showSnackbar(message: failure.errorMsg);
    }, (response) {
      if (pickImage) {
        frontAadhaarImage = "";
      } else {
        backAadhaarImage = "";
      }
      setBusy(false);
      notifyListeners();
    });
  }

  Future<Map<String, String>> _getRequestForCandidateKYC() async {
    Map<String, String> request = {};
    request['aadhar_no'] = aadhaarController.text;
    request['aadhar_front_image'] = frontAadhaarImage;
    request['aadhar_back_image'] = backAadhaarImage;
    request['vaccine_certificate'] = backAadhaarImage;
    log("Body CandidateKYC >>> $request");
    return request;
  }
}
