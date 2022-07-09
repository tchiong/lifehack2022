import 'package:flutter/material.dart';
import 'package:kindness_network/authentication_screens/welcome_screen.dart';
import 'package:kindness_network/router.dart';
import 'package:kindness_network/data/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomeScreen(),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
