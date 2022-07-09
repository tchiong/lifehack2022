import 'package:flutter/material.dart';
import 'package:kindness_network/authentication_screens/user_type_selector_screen.dart';
import 'package:kindness_network/common/constants.dart';
import 'package:kindness_network/common/widgets/language_selector.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void navigateToMainScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, UserTypeSelectorScreen.routeName, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log In"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              const LanguageSelector(),
              const SizedBox(
                height: 75,
              ),
              const SizedBox(height: 20),
              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    navigateToMainScreen();
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Log in with Singpass",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
