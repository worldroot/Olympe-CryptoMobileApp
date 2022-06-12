import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:olympe/Controllers/auth_controller.dart';
import 'package:olympe/components/background.dart';
import 'package:olympe/components/snackbar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authController = AuthController();

  TextEditingController namecontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();

  handleSignup() {
    if (namecontroller.text.isEmpty) {
      ShowSnackBar().showSnackBar(
        context,
        "Please provide your name",
        duration: const Duration(seconds: 2),
        noAction: false,
      );
      return;
    }

    if (mobilecontroller.text.isEmpty) {
      ShowSnackBar().showSnackBar(
        context,
        "Please provide your phone",
        duration: const Duration(seconds: 2),
        noAction: false,
      );
      return;
    }

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
        .register(usernamecontroller.text, passwordcontroller.text,
            namecontroller.text, mobilecontroller.text)
        .then((connectedUser) {
      //check for error
      if (connectedUser.error == false) {
        Navigator.pop(context);
        ShowSnackBar().showSnackBar(
          context,
          "User added successfully",
          duration: const Duration(seconds: 2),
          noAction: false,
        );
        //redirection
      } else {
        ShowSnackBar().showSnackBar(
          context,
          "fama erreur",
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Text(
                  "REGISTER",
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
                  controller: namecontroller,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: mobilecontroller,
                  decoration: const InputDecoration(labelText: "Mobile Number"),
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
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.centerRight,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: RaisedButton(
                  onPressed: handleSignup,
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
                      "SIGN UP",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: GestureDetector(
                  onTap: () => {Navigator.pop(context)},
                  child: const Text(
                    "Already Have an Account? Sign in",
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
      ),
    );
  }
}
