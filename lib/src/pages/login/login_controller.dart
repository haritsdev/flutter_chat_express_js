import 'package:chat_udemy/src/models/response_api.dart';
import 'package:chat_udemy/src/models/user.dart';
import 'package:chat_udemy/src/providers/users_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  GetStorage storage = GetStorage();

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      ResponseApi responseApi = await usersProvider.login(email, password);
      print('Response API : ${responseApi.toJson()}');
      if (responseApi.success == true) {
        User user = User.fromJson(responseApi.data);
        storage.write('user', user.toJson());
        goToHomePage();
      } else {
        Get.snackbar('Error', 'User name atau password salah');
      }
    } else {
      Get.snackbar('Error UnCompleted', 'Semua data harus di isi ');
    }
  }

  void goToHomePage() {
    Get.toNamed('/home');
  }
}
