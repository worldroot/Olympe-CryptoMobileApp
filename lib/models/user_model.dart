class User {
  String? id;
  String? name;
  String? username;
  String? password;
  String? phone;
  String? avatar;
  String? token;
  bool? error;
  User(
      {required this.id,
      required this.name,
      required this.username,
      required this.password,
      required this.phone,
      required this.avatar,
      required this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String;
    name = json['name'] as String;
    username = json['username'] as String;
    password = json['password'] as String;
    phone = json['phone'] as String;
    avatar = json['avatar'] as String;
    token = json['token'] as String;
    error = false;
  }

  User.withError() {
    id = "";
    name = "";
    username = "";
    password = "";
    phone = "";
    avatar = "";
    token = "";
    error = true;
  }
}
