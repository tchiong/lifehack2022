import 'package:flutter/material.dart';
import 'package:kindness_network/beneficiary_screen/beneficiary_request_screen.dart';
import 'package:kindness_network/common/constants.dart';
import 'package:kindness_network/common/widgets/language_selector.dart';

class BeneficiaryScreen extends StatefulWidget {
  static const String routeName = 'beneficiary-screen';
  const BeneficiaryScreen({Key? key}) : super(key: key);

  @override
  State<BeneficiaryScreen> createState() => _BeneficiaryScreenState();
}

class _BeneficiaryScreenState extends State<BeneficiaryScreen> {

 void navigateToRequest(String requestType) {
    Navigator.pushNamed(context, BeneficiaryRequestScreen.routeName, arguments: requestType);
  }

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
                const SizedBox(height: 20,),
                SizedBox(
                  height: 400,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: [
                      SizedBox(
                        width: 125,
                        height: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: darkBlue,
                            textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(defaultRadius),
                            ),
                          ),
                          onPressed: (){}, 
                          child: const Text("Mental Wellbeing", textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      SizedBox(
                        width: 125,
                        height: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: lightBlue,
                            textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(defaultRadius),
                            ),
                          ),
                          onPressed: (){}, 
                          child: const Text("House Keeping", textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      SizedBox(
                        width: 125,
                        height: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: lightBlue,
                            textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500,),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(defaultRadius),
                            ),
                          ),
                          onPressed: (){}, 
                          child: const Text("Mobility", textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      SizedBox(
                        width: 125,
                        height: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: darkBlue,
                            textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(defaultRadius),
                            ),
                          ),
                          onPressed: (){}, 
                          child: const Text("Digital Literacy", textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                width: double.infinity,
                height: 150,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black),
                    primary: Colors.black,
                    textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(defaultRadius),
                    ),
                  ),
                  onPressed: (){}, 
                  child: const Text("Emergency"),
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