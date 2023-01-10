import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class ImageController {
  late Rx<File?> _pickedImage;
  bool isImageSelected = false;

  File? get profileImage => _pickedImage.value;

  void pickImage(bool takePhoto, Function setImageStatus) async {
    XFile? pickedImage;
    if (takePhoto) {
      pickedImage = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 1);
    } else {
      pickedImage = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 1);
    }
    print(pickedImage);
    if (pickedImage != null) {
      Get.snackbar(
          'Recipe Picture', 'You have successfully selected a recipe picture!');
    } else {
      print('no image selected');
    }
    Rx<File?> image = Rx<File?>(File(pickedImage!.path));
    _pickedImage = image;
    isImageSelected = true;
    setImageStatus();
    //Future<String> url = uploadToStorage(profileImage!);
  }

  // upload to firebase storage
  Future<String> uploadToStorage(File image) async {
    Reference ref = firebaseStorage.ref().child('profilePics').child('test1');
    //.child(firebaseAuth.currentUser!.uid);
    print('uploaded');
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }
}
