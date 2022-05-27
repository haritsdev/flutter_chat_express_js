import 'package:chat_udemy/src/models/user.dart';
import 'package:chat_udemy/src/pages/home/home_page.dart';
import 'package:chat_udemy/src/pages/login/login_page.dart';
import 'package:chat_udemy/src/pages/register/register_page.dart';
import 'package:chat_udemy/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

User myUser = User.fromJson(GetStorage().read('user') ?? {});

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chat Flutter',
      debugShowCheckedModeBanner: false,
      initialRoute: myUser.id != null ? '/home' : '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
      ],
      theme: ThemeData(primaryColor: MyColors.primaryColor),
      navigatorKey: Get.key,
    );
  }
}
