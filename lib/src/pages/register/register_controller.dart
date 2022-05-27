import 'dart:io';

import 'package:chat_udemy/src/models/response_api.dart';
import 'package:chat_udemy/src/providers/users_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/user.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  var number = 0.obs;

  void register() async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (isValidForm(email, name, lastname, phone, password, confirmPassword)) {
      User user = User(
        email: email,
        name: name,
        lastname: lastname,
        phone: phone,
        password: password,
      );

      ResponseApi responseApi =
          await usersProvider.registerUsersWithImage(user, imageFile!);

      if (responseApi.success == true) {
        clearForm();
        goToHomePage();
      } else {
        Get.snackbar('User gagal dibuat', responseApi.message!);
      }
    }
  }

  void goToHomePage() {
    Get.offNamedUntil('/home', (route) => false);
  }

  Future selectImage(ImageSource imageSource) async {
    // Pick an image

    final XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery);
        },
        child: Text('Gallery'));
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera);
        },
        child: Text('Camera'));

    AlertDialog alertDialog = AlertDialog(
      title: Text('Pilih gambar'),
      actions: [galleryButton, cameraButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void clearForm() {
    emailController.text = '';
    nameController.text = '';
    lastnameController.text = '';
    phoneController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
  }

  bool isValidForm(String email, String name, String lastname, String phone,
      String password, String confirmPassword) {
    if (email.isEmpty) {
      Get.snackbar('User is not valid', 'Email anda harus diisi');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('User is not valid', 'Format email tidak valid');
      return false;
    }
    if (name.isEmpty) {
      Get.snackbar('User is not valid', 'Nama depan anda harus diisi');
      return false;
    }

    if (lastname.isEmpty) {
      Get.snackbar('User is not valid', 'Nama belakang anda harus diisi');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('User is not valid', 'Password anda harus diisi');
      return false;
    }

    if (confirmPassword.isEmpty) {
      Get.snackbar('User is not valid', 'Password confirmasi anda harus diisi');
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar('User is not valid', 'Password confirmasi tidak sama');
      return false;
    }

    if (imageFile == null) {
      Get.snackbar('Terjadi Kesalahan', 'Photo profile harus di upload');
      return false;
    }

    return true;
  }
}
