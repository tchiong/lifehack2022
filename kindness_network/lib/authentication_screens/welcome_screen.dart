import 'package:flutter/material.dart';
import 'package:kindness_network/authentication_screens/user_type_selector_screen.dart';
import 'package:kindness_network/common/constants.dart';
import 'package:kindness_network/common/widgets/language_selector.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = 'loginOrRegister';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void navigateToUserTypeSelector() {
    Navigator.pushNamed(context, UserTypeSelectorScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const LanguageSelector(
                      userId: -1), // TODO not tied to any user
                  const SizedBox(
                    height: 120,
                  ),
                  const Text(
                    "Welcome to Kindess Network!",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: lightBlue,
                        textStyle: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(defaultRadius),
                        ),
                      ),
                      onPressed: () {
                        navigateToUserTypeSelector();
                      },
                      child: const Text("Log In",
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
