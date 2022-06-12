// import 'dart:convert';

import 'dart:convert';

import 'package:olympe/Controllers/request_controller.dart';
import 'package:olympe/models/user_model.dart';

class AuthController {
  final RequestController _requestController = RequestController();

  Future<User> login(String username, String password) async {
    final response = await _requestController.post(
        apiRoute: "api/users/login",
        body: <String,String>{'username': username, 'password': password},
        headers: {});
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      User user = User.fromJson(body);
      return user;
    } else {
      print("something went wrong");
      return User.withError();
    }
  }

  Future<User> register(
      String username, String password, String name, String phone) async {
    final response = await _requestController
        .post(apiRoute: "api/users/register", body: <String, String>{
      'name': name,
      'username': username,
      'password': password,
      'phone': phone,
    }, headers: {});

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      User user = User.fromJson(body);
      return user;
    } else {
      return User.withError();
    }
  }
}
