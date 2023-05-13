import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../../app/app.locator.dart';
import '../../../../../domain/reactive_services/business_type_service.dart';
import '../../../../../domain/repos/auth_repos.dart';
import '../../../../../domain/repos/business_repos.dart';
import '../../../../../others/constants.dart';
import '../../../../widgets/image_picker_util.dart';

class PickBusinessImageViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final authRepo = locator<Auth>();
  final businessRepo = locator<BusinessRepo>();
  final businessTypeService = locator<BusinessTypeService>();
  XFile? _imageFile;

  XFile? get imageFile => _imageFile;

  List<String> imageList = [];
  bool isListEmpty = true;
  bool fourImagesAdded = false;

  void updateImageList(List<String> list) {
    imageList = list;
    updateEmptyItemList();
    print("updateImageList ${list.length}");
    notifyListeners();
  }

  Future pickImage(BuildContext context) async {
    XFile pickImage = await _showImagePicker(context);
    final imageFile = await cropImage(PickedFile(pickImage.path));
    if (imageFile != null) {
      _imageFile = XFile(imageFile.path);
      await uploadMediaForBusiness(imageFile.path);
      setBusy(false);
      notifyListeners();
    }
  }

  Future<XFile> _showImagePicker(context) async {
    return await ImagePickerUtil.showCameraOrGalleryChooser(context);
  }

  Future<CroppedFile?> cropImage(PickedFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: mainWhiteColor,
        ),
      ],
      aspectRatio: const CropAspectRatio(
        ratioX: 1.0,
        ratioY: 1.0,
      ),
      sourcePath: imageFile.path,
      maxWidth: 512,
      maxHeight: 512,
    );
    return croppedFile;
  }

  Future<void> uploadMediaForBusiness(String image) async {
    setBusy(true);
    final response = await authRepo.uploadImages(image);

    response.fold((failure) {
      setBusy(false);
    }, (response) {
      imageList.add(response.imageList.first);
      print("imageList ---${imageList.length}");
      updateEmptyItemList();
      notifyListeners();
    });
  }

  Future<void> deleteImageApi(String image) async {
    setBusy(true);
    final response = await authRepo.deleteImage(image);

    response.fold((failure) {
      imageList.removeAt(imageList.indexOf(image));
      updateEmptyItemList();

      setBusy(false);
    }, (response) {
      imageList.removeAt(imageList.indexOf(image));
      updateEmptyItemList();
      setBusy(false);
      notifyListeners();
    });
  }

  void updateEmptyItem(val) {
    isListEmpty = val;
    notifyListeners();
  }

  void updateEmptyItemList() {
    if (imageList.isEmpty) {
      updateEmptyItem(true);
    } else if (imageList.isNotEmpty && imageList.length < 3) {
      updateEmptyItem(false);
      fourImagesAdded = false;
    } else {
      updateEmptyItem(false);
      fourImagesAdded = true;
    }
    notifyListeners();
  }
}
