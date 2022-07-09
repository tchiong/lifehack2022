import 'package:flutter/material.dart';
import 'package:kindness_network/authentication_screens/welcome.dart';
import 'package:kindness_network/beneficiary_screen/beneficiary_screen.dart';
import 'package:kindness_network/common/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomeScreen(),
       routes: {
              welcomeRoute: (context) => const WelcomeScreen(),
              beneficiaryRoute: (context) => const BeneficiaryScreen(),
          },
    );
  }
}