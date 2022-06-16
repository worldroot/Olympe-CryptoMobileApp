import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:olympe/screens/profile/profileMenu.dart';
import 'package:olympe/screens/profile/profile_pic.dart';

class ProfileBody extends StatelessWidget {
  String username = Hive.box('user_data').get('username');
  String phone = Hive.box('user_data').get('phone');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ProfilePic(),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "Usename: $username , Phone: $phone",
            custom_icon: Icons.account_circle,
            press: () => {},
          ),
          ProfileMenu(
            text: "Notifications",
            custom_icon: Icons.notifications,
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            custom_icon: Icons.settings,
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            custom_icon: Icons.question_mark,
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            custom_icon: Icons.logout,
            press: () {
              Hive.box("user_data").clear();
              Navigator.popAndPushNamed(context, "/login");
            },
          ),
        ],
      ),
    );
  }
}
