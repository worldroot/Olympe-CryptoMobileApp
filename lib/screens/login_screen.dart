import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:olympe/Controllers/auth_controller.dart';
import 'package:olympe/components/background.dart';
import 'package:olympe/components/snackbar.dart';
import 'package:olympe/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final AuthController _authController = AuthController();

  handleLogin() {
    if (usernamecontroller.text.isEmpty) {
      ShowSnackBar().showSnackBar(
        context,
        "Please provide your username",
        duration: const Duration(seconds: 2),
        noAction: false,
      );
      return;
    }

    if (passwordcontroller.text.isEmpty) {
      ShowSnackBar().showSnackBar(
        context,
        "Please provide your password",
        duration: const Duration(seconds: 2),
        noAction: false,
      );
      return;
    }

    _authController
        .login(usernamecontroller.text, passwordcontroller.text)
        .then((connectedUser) {
      if (connectedUser.error == false) {
        var box = Hive.box('user_data');
        box.put('id', connectedUser.id!);
        box.put('name', connectedUser.name!);
        box.put('username', connectedUser.username!);
        box.put('phone', connectedUser.phone!);
        box.put('password', connectedUser.password!);
        box.put('avatar', connectedUser.avatar!);
        box.put('token', connectedUser.token!);


        Navigator.popAndPushNamed(context, "/home");
      } else {
        ShowSnackBar().showSnackBar(
          context,
          "check your credentials",
          duration: const Duration(seconds: 2),
          noAction: false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                "LOGIN",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(66, 135, 245, 1),
                    fontSize: 36),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: usernamecontroller,
                decoration: const InputDecoration(labelText: "Username"),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: passwordcontroller,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: const Text(
                "Forgot your password?",
                style: const TextStyle(fontSize: 12, color: Color(0XFF2661FA)),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RaisedButton(
                onPressed: handleLogin,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: const Text(
                    "LOGIN",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: const Text(
                  "Don't Have an Account? Sign up",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
