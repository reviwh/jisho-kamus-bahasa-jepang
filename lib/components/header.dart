import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jisho/screens/home_screen.dart';
import 'package:jisho/screens/login_screen.dart';
import 'package:jisho/utils/session.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    GlobalKey<FormState> keyForm = GlobalKey<FormState>();

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        gradient: RadialGradient(
          center: const Alignment(0, -0.5),
          colors: [
            Colors.red.shade400,
            Colors.red.shade800,
          ],
          stops: const [.75, 1],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  },
                  child: ClipOval(
                    child: Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/9/9e/Flag_of_Japan.svg",
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Japanesse Dictionary",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Form(
                  key: keyForm,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    cursorColor: Colors.red.shade600,
                    controller: searchController,
                    onFieldSubmitted: (value) {
                      if (value.isNotEmpty) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(keyword: value)));
                      }
                    },
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      hintText: "Search",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.search_rounded,
                          color: Colors.grey,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          onPressed: () {
                            searchController.text = "";
                          },
                          icon: const Icon(
                            Icons.close_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              right: 8,
              top: 8,
              child: IconButton(
                onPressed: () {
                  sessionManager.deleteSession();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const LoginScreen())));
                },
                icon: const Icon(Icons.logout_rounded, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
