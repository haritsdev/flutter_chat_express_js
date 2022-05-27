import 'package:chat_udemy/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  User user = User.fromJson(GetStorage().read('user') ?? {});

  var number = 1.obs; // INT -GETX
  var tabIndex = 0.obs;

  HomeController() {
    print('user session ${user.toJson()}');
  }

  void add() {
    number.value++;
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
