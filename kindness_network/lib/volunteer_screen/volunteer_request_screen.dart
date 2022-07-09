import 'package:flutter/material.dart';
import 'package:kindness_network/common/constants.dart';
import 'package:kindness_network/common/widgets/language_selector.dart';
import 'package:kindness_network/data/firebase.dart';
import 'package:kindness_network/data/request.dart';

class VolunteerRequestScreen extends StatefulWidget {
  static const String routeName = 'volunteer-request';
  const VolunteerRequestScreen({Key? key, required this.request}) : super(key: key);
  final Request request;

  @override
  State<VolunteerRequestScreen> createState() => _VolunteerRequestScreenState();
}

class _VolunteerRequestScreenState extends State<VolunteerRequestScreen> {
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
                          jobType: widget.request.jobType,
                          isAccepted: false,
                          acceptedId: -1,
                          requestTime: DateTime.now());
                      Firebase().pushDataToList('request/', request.toJson());
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