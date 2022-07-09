import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kindness_network/common/constants.dart';
import 'package:kindness_network/common/widgets/language_selector.dart';

class BeneficiaryScreen extends StatefulWidget {
  const BeneficiaryScreen({Key? key}) : super(key: key);

  @override
  State<BeneficiaryScreen> createState() => _BeneficiaryScreenState();
}

class _BeneficiaryScreenState extends State<BeneficiaryScreen> {
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
                            textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(defaultRadius),
                            ),
                          ),
                          onPressed: (){}, 
                          child: const Text("Mental Wellbeing", textAlign: TextAlign.center,),
                        ),
                      ),
                      SizedBox(
                        width: 125,
                        height: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(defaultRadius),
                            ),
                          ),
                          onPressed: (){}, 
                          child: const Text("House Keeping", textAlign: TextAlign.center,),
                        ),
                      ),
                      SizedBox(
                        width: 125,
                        height: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(defaultRadius),
                            ),
                          ),
                          onPressed: (){}, 
                          child: const Text("Mobility", textAlign: TextAlign.center,),
                        ),
                      ),
                      SizedBox(
                        width: 125,
                        height: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(defaultRadius),
                            ),
                          ),
                          onPressed: (){}, 
                          child: const Text("Digital Literacy", textAlign: TextAlign.center,),
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
                    primary: Colors.black,
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