import 'package:flutter/material.dart';
import 'package:olympe/screens/profile/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile", style: TextStyle(fontFamily: "Oswald")),
        backgroundColor: Colors.transparent,
      ),
      body: ProfileBody(),
      backgroundColor: Colors.transparent,
    );
  }
}
