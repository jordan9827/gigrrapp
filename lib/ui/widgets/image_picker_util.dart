import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:square_demo_architecture/util/extensions/string_extension.dart';

import '../../others/constants.dart';

class ImagePickerUtil {
  static Future<XFile?> imageFromCamera() async {
    var imagePickerResponse =
        await ImagePicker().pickImage(source: ImageSource.camera);
    return imagePickerResponse;
  }

  static Future<String> getExternalStoragePath() async {
    final directory = await getExternalStorageDirectory();
    final myImagePath = '${directory!.path}/MyImages_Flutter';
    final myImgDir = Directory(myImagePath);
    var dirExist = await myImgDir.exists();
    if (!dirExist) {
      await myImgDir.create();
    }
    return myImagePath;
  }

  static Future<XFile?> imageFromGallery() async {
    var imagePickerResponse =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return imagePickerResponse;
  }

  static Future<CroppedFile?> cropImage(PickedFile imageFile) async {
    if (imageFile.path.getFileType() == PickedFileType.Image) {
      CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: CropAspectRatio(ratioX: 4, ratioY: 3),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          // CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.original,
          // CropAspectRatioPreset.ratio4x3,
          // CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "Cropper",
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: "Cropper",
          ),
        ],
      );
      return croppedImage;
    }
    return null;
  }

  static Future<dynamic> showCameraOrGalleryChooser(
      BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  title: Text('pick_from_camera'.tr()),
                  onTap: () async {
                    var image = await imageFromCamera();
                    Navigator.pop(context, image);
                  }),
              ListTile(
                  title: Text('pick_from_gallery'.tr()),
                  onTap: () async {
                    var image = await imageFromGallery();
                    Navigator.pop(context, image);
                  }),
            ],
          ),
        );
      },
    );
  }
}
