class User {
  String? id;
  String? name;
  String? username;
  String? password;
  String? mobile;
  String? avatar;
  String? token;

  User(
      {required this.id,
      required this.name,
      required this.username,
      required this.password,
      required this.mobile,
      required this.avatar,
      required this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String;
    name = json['name'] as String;
    username = json['username'] as String;
    password = json['password'] as String;
    mobile = json['mobile'] as String;
    avatar = json['avatar'] as String;
    token = json['token'] as String;
  }

  User.withError(String error) {
    id = error;
    name = "";
    username = "";
    password = "";
    mobile = "";
    avatar = "";
    token = "";
  }
}
