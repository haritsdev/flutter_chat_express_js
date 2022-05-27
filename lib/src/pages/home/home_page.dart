import 'package:chat_udemy/src/pages/chats/chats_page.dart';
import 'package:chat_udemy/src/pages/home/home_controller.dart';
import 'package:chat_udemy/src/pages/profile/profile_page.dart';
import 'package:chat_udemy/src/pages/users/users_page.dart';
import 'package:chat_udemy/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomeController con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: bottomNavigationBar(context),
        body: Obx(() => IndexedStack(
              index: con.tabIndex.value,
              children: [ChatsPage(), UsersPage(), ProfilePage()],
            )));
  }

  Widget bottomNavigationBar(BuildContext context) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Container(
          height: 54,
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: con.changeTabIndex,
            currentIndex: con.tabIndex.value,
            backgroundColor: MyColors.primaryColor,
            unselectedItemColor: Colors.white.withOpacity(0.5),
            selectedItemColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.chat,
                    size: 20,
                  ),
                  label: 'Chats',
                  backgroundColor: MyColors.primaryColor),
              BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.person,
                    size: 20,
                  ),
                  label: 'Users',
                  backgroundColor: MyColors.primaryColor),
              BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.person_pin_circle,
                    size: 20,
                  ),
                  label: 'Profile',
                  backgroundColor: MyColors.primaryColor)
            ],
          ),
        )));
  }
}
