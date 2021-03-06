import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kindness_network/authentication_screens/user_type_selector_screen.dart';
import 'package:kindness_network/beneficiary_screen/beneficiary_main.dart';
import 'package:kindness_network/common/constants.dart';
import 'package:kindness_network/common/widgets/language_selector.dart';
import 'package:kindness_network/volunteer_screen/volunteer_main.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key, required this.isBeneficiary}) : super(key: key);
  final bool isBeneficiary;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void navigateToMainScreen(int userId) {
    if (widget.isBeneficiary) {
      Navigator.pushNamedAndRemoveUntil(
          context, BeneficiaryMainScreen.routeName, (_) => false,
          arguments: userId);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, VolunteerMainScreen.routeName, (_) => false,
          arguments: userId);
    }
  }

  void navigateToTypeSelector() {
    Navigator.pushNamed(context, UserTypeSelectorScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            navigateToTypeSelector();
          },
        ),
        title: const Text("Log In"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              children: [
                const LanguageSelector(userId: -1), // TODO not tied to any user
                const SizedBox(height: 20),
                const Text("Log in with Singpass",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                const SizedBox(height: 10),
                SizedBox(
                    height: 260,
                    width: double.infinity,
                    child: SvgPicture.asset(
                      'assets/icons/singpass.svg',
                    )),
                const SizedBox(height: 20),
                const Text("Tap the QR code to log in with Singpass",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                widget.isBeneficiary
                    ? Column(
                        children: [
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: darkBlue,
                                textStyle: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w500),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius),
                                ),
                              ),
                              onPressed: () {
                                navigateToMainScreen(0);
                              },
                              child: const Text("Beneficiary Test Acc 1",
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: darkBlue,
                                textStyle: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w500),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius),
                                ),
                              ),
                              onPressed: () {
                                navigateToMainScreen(1);
                              },
                              child: const Text("Beneficiary Test Acc 2",
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      )
                    : const SizedBox(
                        height: 20,
                      ),
                !widget.isBeneficiary
                    ? Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: darkBlue,
                                textStyle: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w500),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius),
                                ),
                              ),
                              onPressed: () {
                                navigateToMainScreen(2);
                              },
                              child: const Text("Volunteer Test Acc 1",
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      )
                    : const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
