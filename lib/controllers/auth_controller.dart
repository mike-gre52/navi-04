import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/views/screens/auth/sign_in.dart';
import 'package:whats_for_dinner/views/screens/auth/sign_up.dart';
import 'package:whats_for_dinner/views/screens/navigation.dart';
import '../data/local_data.dart';
import '../models/user.dart' as model;

import '../utils/constants.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  late Rx<File?> _pickedImage;

  File? get profileImage => _pickedImage.value;
  User get user => _user.value!;

  @override
  void onReady() async {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  Future<void> getUserData() async {
    final docRef =
        firestore.collection('users').doc(firebaseAuth.currentUser!.uid);
    await docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        globalGroupId = data['groupId'];
        globalUsername = data['name'];
        globalColor = data['color'];
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  _setInitialScreen(User? user) async {
    print('1----------');

    if (user == null) {
      print('2----------');
      Get.offAll(() => SignIn(), transition: Transition.cupertino);
    } else {
      print('3----------');
      await getData();
      Get.offAll(() => const Navigation(), transition: Transition.cupertino);
    }
  }

  setlocalUsername(String username) {
    Database().setUsername(username);
  }

  setlocalColor(String color) {
    Database().setColor(color);
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar(
          'Profile Picture', 'You have successfully selected [] image');
    }
    pickedImageSignUp = Rx<File?>(File(pickedImage!.path));
    print(' test: ${profileImage} ');
  }

  // upload to firebase storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // registering the user
  Future<void> registerUser(
    String username,
    String email,
    String password,
    //File? image,
  ) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty //&&
          //image != null
          ) {
        //save username to local storage
        setlocalUsername(username);
        //save local color
        setlocalColor('0xffccaa40');

        // save out user to our ath and firebase firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        //String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
            name: username,
            email: email,
            uid: cred.user!.uid,
            profileImage: '',
            groupId: cred.user!.uid,
            inGroup: false,
            color: '4278933797');
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        //get data
        await getData();
      } else {
        Get.snackbar(
          'Error Creating Account',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Creating Account',
        e.toString(),
      );
      print(e);
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);

        await getData();
        //NEED TO SAVE DATA TO LOCAL STORAGEm----------------------------------------
      } else {
        Get.snackbar(
          'Error Logging in',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Logging in',
        e.toString(),
      );
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }
}
