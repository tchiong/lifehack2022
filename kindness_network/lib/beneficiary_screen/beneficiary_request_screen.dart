import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kindness_network/beneficiary_screen/beneficiary_feedback_screen.dart';
import 'package:kindness_network/beneficiary_screen/beneficiary_main.dart';
import 'package:kindness_network/common/constants.dart';
import 'package:kindness_network/common/widgets/language_selector.dart';
import 'package:kindness_network/data/request.dart';
import 'package:kindness_network/data/users.dart';

class BeneficiaryRequestScreen extends StatefulWidget {
  static const String routeName = '/beneficiary-request';
  const BeneficiaryRequestScreen({Key? key, required this.request})
      : super(key: key);
  final Request request;

  @override
  State<BeneficiaryRequestScreen> createState() =>
      _BeneficiaryRequestScreenState();
}

class _BeneficiaryRequestScreenState extends State<BeneficiaryRequestScreen> {
  void navigateToBeneficiaryScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, BeneficiaryMainScreen.routeName, (_) => false,
        arguments: widget.request);
  }

  void navigateToBeneficiaryFeedbackScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, BeneficiaryFeedbackScreen.routeName, (_) => false,
        arguments: widget.request);
  }

  showPhoneDialog() async {
    User? acceptedUser =
        await User.getUserFromUserId(widget.request.acceptedId);
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: widget.request.acceptedId == -1
            ? const Text('Not Accepted')
            : const Text('Accepted'),
        content: widget.request.acceptedId == -1
            ? const Text(
                'Please give volunteers some time to accept the request')
            : Text(acceptedUser?.phoneNumber ?? ''),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? acceptedUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Details"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
            ),
            child: Column(
              children: [
                LanguageSelector(
                  userId: widget.request.requesterId,
                ),
                Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: const BoxDecoration(
                      color: lightBlue,
                      borderRadius:
                          BorderRadius.all(Radius.circular(defaultRadius)),
                    ),
                    width: double.infinity,
                    height: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Request Raised:",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600)),
                        Text(
                            DateFormat('yyyy-MM-dd hh:mm')
                                .format(widget.request.requestTime),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400)),
                        Text(widget.request.jobType.toString(),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline)),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: const BoxDecoration(
                    color: lightBlue,
                    borderRadius:
                        BorderRadius.all(Radius.circular(defaultRadius)),
                  ),
                  width: double.infinity,
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Assigned Volunteer:",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600)),
                      widget.request.isAccepted
                          ? Text(widget.request.acceptedId.toString(),
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600))
                          : const Text("No Volunteer",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red)),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      primary: darkBlue,
                      textStyle: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.w500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius),
                      ),
                    ),
                    onPressed: () async => {showPhoneDialog()},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Call",
                            style: TextStyle(color: Colors.black)),
                        SvgPicture.asset('assets/icons/phone-call.svg',
                            height: 80, width: 80),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      primary: red,
                      textStyle: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.w500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius),
                      ),
                    ),
                    onPressed: () {
                      Request.deleteRequestById(widget.request.id);
                      navigateToBeneficiaryScreen();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Cancel",
                            style: TextStyle(color: Colors.black)),
                        SvgPicture.asset('assets/icons/cancel.svg',
                            height: 80, width: 80),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      primary: Colors.blue,
                      textStyle: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.w500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius),
                      ),
                    ),
                    onPressed: () async {
                      Request.completeRequestBenficiary(widget.request);
                      navigateToBeneficiaryFeedbackScreen();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Complete",
                            style: TextStyle(color: Colors.black)),
                        SvgPicture.asset('assets/icons/tick.svg',
                            height: 80, width: 80),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
