// import 'dart:convert';

import 'dart:convert';

import 'package:olympe/Controllers/request_controller.dart';
import 'package:olympe/models/user_model.dart';

class AuthController {
  final RequestController _requestController = RequestController();

  Future<User> login(String username, String password) async {
    final response = await _requestController.post(
        apiRoute: "api/users/login",
        body: {username: username, password: password},
        headers: {});
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      User user = User.fromJson(body);
      return user;
    } else {
      print("something went wrong");
      return User.withError("something went wrong");
    }
  }

  Future<User> register(String username, String password,String name, String phone) async {
    final response = await _requestController.post(
        apiRoute: "api/users/register",
        body: {
          name: name,
          username: username,
          password: password,
          phone: password,
        },
        headers: {});
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      User user = User.fromJson(body);
      return user;
    } else {
      print("something went wrong");
      return User.withError("something went wrong");
    }
  }
}
