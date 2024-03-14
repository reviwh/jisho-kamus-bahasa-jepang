import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  int? value;
  String? username;

  Future<void> saveSession(int value, String username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("value", value);
    pref.setString("username", username);
  }

  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    value = pref.getInt("value");
    username = pref.getString("username");
  }

  Future<void> deleteSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}

SessionManager sessionManager = SessionManager();
