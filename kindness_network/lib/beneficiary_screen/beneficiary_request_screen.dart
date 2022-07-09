import 'package:flutter/material.dart';
import 'package:kindness_network/common/constants.dart';
import 'package:kindness_network/common/widgets/language_selector.dart';

class BeneficiaryRequestScreen extends StatefulWidget {
  static const String routeName = '/beneficiary-request';
  const BeneficiaryRequestScreen({Key? key, required this.requestType}) : super(key: key);
  final String requestType;

  @override
  State<BeneficiaryRequestScreen> createState() => _BeneficiaryRequestScreenState();
}

class _BeneficiaryRequestScreenState extends State<BeneficiaryRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              children: [
                const LanguageSelector(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}