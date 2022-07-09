import 'package:flutter/material.dart';
import 'package:kindness_network/common/constants.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  const LoginOrRegisterScreen({Key? key, required this.isBeneficiary}) : super(key: key);
  final bool isBeneficiary;

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: "Signing in as: ", 
            children: [
              TextSpan(text: widget.isBeneficiary ? "Beneficiary" : "Volunteer"),
            ],
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(children: [
            SizedBox(
                width: double.infinity,
                height: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: lightBlue,
                    textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(defaultRadius),
                    ),
                  ),
                  onPressed: () {
                    
                  }, 
                  child: const Text("Log In", style: TextStyle(color: Colors.black)),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: darkBlue,
                    textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(defaultRadius),
                    ),
                  ),
                  onPressed: () {
                    
                  }, 
                  child: const Text("Register", style: TextStyle(color: Colors.black)),
                ),
              ),
          ],)
        ),
      ),
    );
  }
}