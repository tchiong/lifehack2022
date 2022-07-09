

import 'package:flutter/material.dart';
import 'package:kindness_network/common/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: 
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [ 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [ 
                  TextButton(onPressed: (){}, child: const Text("English"),),
                  TextButton(onPressed: (){}, child: const Text("Bahasa Melayu"),),
                ],
              ),
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
                  onPressed: (){}, 
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