import 'package:flutter/material.dart';
import 'package:kindness_network/authentication_screens/welcome.dart';
import 'package:kindness_network/beneficiary_screen/beneficiary_main.dart';
import 'package:kindness_network/beneficiary_screen/beneficiary_request_screen.dart';
import 'package:kindness_network/data/request.dart';
import 'package:kindness_network/volunteer_screen/volunteer_main.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case WelcomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const WelcomeScreen());

    case BeneficiaryMainScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const BeneficiaryMainScreen());

    case BeneficiaryRequestScreen.routeName:
      var requestTypeStr = routeSettings.arguments as String;
      JobType requestType = JobType.mobility;
      switch (requestTypeStr) {
        case 'Mental Wellbeing':
          {
            requestType = JobType.mental;
          }
          break;
        case 'House-keeping':
          {
            requestType = JobType.housekeeping;
          }
          break;
        case 'Mobility':
          {
            requestType = JobType.mobility;
          }
          break;
        case 'Digital Literacy':
          {
            requestType = JobType.literacy;
          }
          break;
      }
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => BeneficiaryRequestScreen(requestType: requestType));
    
    case VolunteerMainScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const VolunteerMainScreen());

    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                  body: Center(
                child: Text('Screen does not exists'),
              )));
  }
}
