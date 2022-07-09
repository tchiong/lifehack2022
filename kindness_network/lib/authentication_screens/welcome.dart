import 'package:flutter/material.dart';
import 'package:kindness_network/beneficiary_screen/beneficiary_screen.dart';
import 'package:kindness_network/common/constants.dart';
import 'package:kindness_network/common/widgets/language_selector.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '/welcome';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void navigateToBeneficiaryScreen() {
    Navigator.pushNamedAndRemoveUntil(context, BeneficiaryScreen.routeName, (_) => false);
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: 
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [ 
              const LanguageSelector(),
              const Text("Are you a...", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
              const SizedBox(height: 10,),
              SizedBox(
                width: double.infinity,
                height: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(defaultRadius),
                    ),
                  ),
                  onPressed: (){}, 
                  child: const Text("Volunteer"),
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                height: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
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