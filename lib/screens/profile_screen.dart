import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
              onPressed: () {
                var box = Hive.box('user_data');
                box.clear();
                Navigator.popAndPushNamed(context, "/login");
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
