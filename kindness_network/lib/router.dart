import 'package:flutter/material.dart';
import 'package:kindness_network/authentication_screens/login.dart';
import 'package:kindness_network/authentication_screens/welcome_screen.dart';
import 'package:kindness_network/authentication_screens/user_type_selector_screen.dart';
import 'package:kindness_network/beneficiary_screen/beneficiary_main.dart';
import 'package:kindness_network/beneficiary_screen/beneficiary_request_screen.dart';
import 'package:kindness_network/data/request.dart';
import 'package:kindness_network/volunteer_screen/volunteer_main.dart';
import 'package:kindness_network/volunteer_screen/volunteer_request_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case UserTypeSelectorScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const UserTypeSelectorScreen());

    case WelcomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const WelcomeScreen());

    case LoginScreen.routeName:
      var isBeneficiary = routeSettings.arguments as bool;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => LoginScreen(isBeneficiary: isBeneficiary));

    case BeneficiaryMainScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const BeneficiaryMainScreen(
                userId: 0,
              )); // TODO Pass Proper UserId

    case BeneficiaryRequestScreen.routeName:
      var request = routeSettings.arguments as Request;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => BeneficiaryRequestScreen(request: request));

    case VolunteerMainScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const VolunteerMainScreen(
                userId: 0,
              )); // TODO Pass Proper UserId

    case VolunteerRequestScreen.routeName:
      var request = routeSettings.arguments as Request;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => VolunteerRequestScreen(request: request));

    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                  body: Center(
                child: Text('Screen does not exists'),
              )));
  }
}
