import 'package:flutter/material.dart';
import 'package:kindness_network/common/constants.dart';
import 'package:kindness_network/common/widgets/language_selector.dart';
import 'package:kindness_network/data/firebase.dart';
import 'package:kindness_network/data/request.dart';
import 'package:kindness_network/data/users.dart';

class BeneficiaryRequestScreen extends StatefulWidget {
  static const String routeName = '/beneficiary-request';
  const BeneficiaryRequestScreen({Key? key, required this.requestType})
      : super(key: key);
  final String requestType;

  @override
  State<BeneficiaryRequestScreen> createState() =>
      _BeneficiaryRequestScreenState();
}

class _BeneficiaryRequestScreenState extends State<BeneficiaryRequestScreen> {
  late int userId;
  @override
  void initState() {
    userId = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Details"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              children: [
                const LanguageSelector(),
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
                        const Text("09 Jul 22, 17:00",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400)),
                        Text(widget.requestType,
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
                  height: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text("Assigned Volunteer:",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600)),
                      Text("Pending",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400)),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Estimated Arrival:",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600)),
                      Text("Pending",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400)),
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
                      primary: darkBlue,
                      textStyle: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.w500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Call",
                        style: TextStyle(color: Colors.black)),
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
                      primary: red,
                      textStyle: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.w500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Cancel",
                        style: TextStyle(color: Colors.black)),
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
                      primary: Colors.blue,
                      textStyle: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.w500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius),
                      ),
                    ),
                    onPressed: () async {
                      int id = await Request.generateRequestId();
                      Request request = Request(
                          id: id,
                          requesterId: userId,
                          jobType: widget.requestType,
                          isAccepted: false,
                          acceptedId: null,
                          requestTime: DateTime.now());
                      Firebase().pushData('request/', request.toJson());
                    },
                    child: const Text("Complete",
                        style: TextStyle(color: Colors.black)),
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
