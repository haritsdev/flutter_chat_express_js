import 'package:chat_udemy/src/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfileController con = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              con.signOut();
            },
            child: const Icon(Icons.power_settings_new),
            backgroundColor: Colors.red,
          ),
          body: Column(
            children: [
              circleImageUser(),
              userInfo('Nama Lengkap',
                  '${con.user.name!} ${con.user.lastname!}', Icons.person),
              userInfo('Email', con.user.email!, Icons.email),
              userInfo('No telepon', con.user.phone!, Icons.phone),
            ],
          )),
    );
  }

  Widget userInfo(String title, String subtitle, IconData iconData) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          leading: Icon(iconData)),
    );
  }

  Widget circleImageUser() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        width: 200,
        child: AspectRatio(
          aspectRatio: 1,
          child: ClipOval(
              child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  placeholder: 'assets/img/user_profile_2.png',
                  image:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSc3kjlStY8R3eum4D5g_bt4AuchFYlhLtDuA&usqp=CAU')),
        ),
      ),
    );
  }
}
