import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:olympe/screens/profile/profileMenu.dart';
import 'package:olympe/screens/profile/profile_pic.dart';

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
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
            press: () {},
          ),
        ],
      ),
    );
  }
}
