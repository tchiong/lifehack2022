import 'package:flutter/material.dart';
import 'package:kindness_network/authentication_screens/login.dart';
import 'package:kindness_network/beneficiary_screen/beneficiary_main.dart';
import 'package:kindness_network/common/constants.dart';
import 'package:kindness_network/common/widgets/language_selector.dart';
import 'package:kindness_network/volunteer_screen/volunteer_main.dart';

class UserTypeSelectorScreen extends StatefulWidget {
  static const String routeName = '/welcome';
  const UserTypeSelectorScreen({Key? key}) : super(key: key);

  @override
  State<UserTypeSelectorScreen> createState() => _UserTypeSelectorScreenState();
}

class _UserTypeSelectorScreenState extends State<UserTypeSelectorScreen> {
  void navigateToBeneficiaryScreen() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      BeneficiaryMainScreen.routeName,
      (_) => false,
    );
  }

  void navigateToVolunteerScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, VolunteerMainScreen.routeName, (_) => false,
        arguments: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              const LanguageSelector(),
              const Text(
                "Are you a...",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w500),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(defaultRadius),
                    ),
                  ),
                  onPressed: () {
                    navigateToVolunteerScreen();
                  },
                  child: const Text("Volunteer"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w500),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(defaultRadius),
                    ),
                  ),
                  onPressed: () {
                    navigateToBeneficiaryScreen();
                  },
                  child: const Text("Beneficiary"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
