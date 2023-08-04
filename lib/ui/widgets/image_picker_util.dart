import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

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
