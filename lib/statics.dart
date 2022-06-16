import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Environment {
  production,
  development,
}

Environment env = Environment.production;

String baseURL = (env == Environment.development)
    ? "https://olympe-backend.herokuapp.com/" // or 10.0.2.2:3000 or 169.254.157.218 or 127.0.0.1:5050 si le backend est en local
    : "olympe-backend.herokuapp.com";

String baseUploadsURL = (env == Environment.development)
    ? "http://10.0.2.2:5000/uploads/"
    : "https://olympe-backend.herokuapp.com/";

DateFormat datetimeFormat = DateFormat("dd/MM/yyyy HH:mm");
DateFormat dateFormat = DateFormat("dd/MM/yyyy");

String capitalize(String msg) {
  return '${msg[0].toUpperCase()}${msg.substring(1)}';
}

ThemeData themeDarkData(BuildContext context) {
  return ThemeData(
    backgroundColor: const Color(0xff1a1c28),
    textSelectionColor: Colors.black,
    textSelectionHandleColor: Colors.grey,
    shadowColor: Colors.grey[700],
    primaryColor: const Color(0xff6b61e9),
    accentColor: const Color(0xff6b61e9),
    primaryColorDark: const Color(0xff6b61e9),
    primaryColorLight: const Color(0xfff7f9fb),
  );
}

class Palette {
  static const Color iconColor = Color(0xffaabbcc);
  static const Color primaryColor = Color(0xff6b61e9);
  static const Color secondaryColor = Color(0xff679de5);
  static const Color thirdColor = Color(0xff679de5);
  static const Color fourthColor = Color(0xff8fb9f1);

  static const Color textColor = Color(0xffffffff);
  static const Color textColor1 = Color(0XFFA7BCC7);
  static const Color textColor2 = Color(0XFF9BB3C0);
  static const Color buttonColor = Color(0xff2f3346);
  static const Color googleColor = Color(0xFFDE4B39);
  static const Color backgroundColor = Color(0xff1a1c28);

  static const Color cardColor = Color(0xff34394b);
}

const coinIconUrl =
    "https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/icon/";
