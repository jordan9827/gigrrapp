import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

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

  static Future<dynamic> showCameraOrGalleryChooser(
      BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    title: Text('Pick from camera'),
                    onTap: () async {
                      var image = await imageFromCamera();
                      Navigator.pop(context, image);
                    }),
                ListTile(
                    title: Text('Pick from gallery'),
                    onTap: () async {
                      var image = await imageFromGallery();
                      Navigator.pop(context, image);
                    }),
              ],
            ),
          );
        });
  }
}
