import 'package:flutter/material.dart';
import 'package:kindness_network/authentication_screens/welcome.dart';
import 'package:kindness_network/beneficiary_screen/beneficiary_request_screen.dart';
import 'package:kindness_network/beneficiary_screen/beneficiary_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case WelcomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const WelcomeScreen()
      );

    case BeneficiaryScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BeneficiaryScreen()
      );
    
    case BeneficiaryRequestScreen.routeName:
      var requestType = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BeneficiaryRequestScreen(requestType: requestType)
      );
    
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(child: Text('Screen does not exists'),)
        )
      );
  }
}