import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:jisho/models/login_response.dart';
import 'package:jisho/screens/home_screen.dart';
import 'package:jisho/screens/register_screen.dart';
import 'package:jisho/utils/constants.dart';
import 'package:jisho/utils/session.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  bool isLoading = false;
  Future<LoginResponse?> login() async {
    try {
      setState(() {
        isLoading = true;
      });

      http.Response res = await http.post((Uri.parse('$url/login.php')), body: {
        'username': txtUsername.text,
        'password': txtPassword.text,
      });

      LoginResponse data = loginResponseFromJson(res.body);

      if (data.value == 1) {
        setState(() {
          sessionManager.saveSession(data.value, data.username);
          isLoading = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(data.message)));
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: keyForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "ログイン",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.shipporiAntique().fontFamily,
                    color: Colors.red.shade600,
                  ),
                ),
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: txtUsername,
                  validator: (val) {
                    return val!.isEmpty ? "Can't be empty" : null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Username',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: txtPassword,
                  obscureText: true,
                  validator: (val) {
                    return val!.isEmpty ? "Can't be empty" : null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 24,
                ),
                MaterialButton(
                  onPressed: () {
                    if (keyForm.currentState?.validate() == true) {
                      login();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Silahkan pilih dan isi data terlebih dahulu')));
                    }
                  },
                  color: Colors.red.shade800,
                  height: 45,
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        child: MaterialButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const RegisterScreen()));
          },
          child: const Text("Doesn't have an account? Register now"),
        ),
      ),
    );
  }
}
