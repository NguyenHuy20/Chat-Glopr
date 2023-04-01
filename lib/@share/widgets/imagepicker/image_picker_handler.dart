import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHandler {
  AnimationController? controller;
  ImagePickerListener? listener;

  ImagePickerHandler(this.listener, this.controller);

  openCamera() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    if (image == null) return;
    cropImage(image);
  }

  openGallery() async {
    try {
      var image =
          await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      cropImage(image);
    } catch (ex) {
      print(ex);
    }
  }

  cropImage(PickedFile image) async {
    var croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        maxHeight: 2016,
        maxWidth: 2016,
        compressQuality: 10);
    if (croppedFile == null) return;
    File file = File(croppedFile.path);
    listener!.userImage(file);
  }
}

abstract class ImagePickerListener {
  userImage(File image);
}
