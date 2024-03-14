import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  int value;
  String message;
  String username;
  String fullname;

  LoginResponse({
    required this.value,
    required this.message,
    required this.username,
    required this.fullname,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        value: json["value"],
        message: json["message"],
        username: json["username"],
        fullname: json["fullname"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "message": message,
        "username": username,
        "fullname": fullname,
      };
}
