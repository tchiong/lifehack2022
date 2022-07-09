import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kindness_network/beneficiary_screen/beneficiary_request_screen.dart';
import 'package:kindness_network/common/constants.dart';
import 'package:kindness_network/common/widgets/language_selector.dart';
import 'package:kindness_network/data/request.dart';

import '../data/firebase.dart';

class BeneficiaryCreateRequestScreen extends StatefulWidget {
  const BeneficiaryCreateRequestScreen({Key? key, required this.userId})
      : super(key: key);
  final int userId;

  @override
  State<BeneficiaryCreateRequestScreen> createState() =>
      _BeneficiaryCreateRequestScreenState();
}

class _BeneficiaryCreateRequestScreenState
    extends State<BeneficiaryCreateRequestScreen> {
  JobType selected = JobType.mental;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = const TimeOfDay(hour: 12, minute: 0);
  late Request userRequest;

  void navigateToRequest(String requestType) {
    Navigator.pushNamed(context, BeneficiaryRequestScreen.routeName,
        arguments: userRequest);
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        selectedTime = newTime;
      });
    }
  }

  void selectJobType(JobType type) {
    setState(() {
      selected = type;
    });
  }

  void setRequest(Request request) {
    setState(() {
      userRequest = request;
    });
  }

  Future<Request> pushRequestToFirebase(JobType selectedType,
      DateTime selectedDate, TimeOfDay selectedTime) async {
    int id = await Request.generateRequestId();
    DateTime date = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    Request request = Request(
        id: id,
        requesterId: widget.userId,
        jobType: selectedType,
        isAccepted: false,
        acceptedId: -1,
        requestTime: date,
        isCompleted: false);
    Firebase().pushDataToList('request/', request.toJson());
    return request;
  }

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
                const SizedBox(
                  height: 5,
                ),
                Text(selected.toString(),
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 400,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      SizedBox(
                        width: 125,
                        height: 140,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: darkBlue,
                            textStyle: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultRadius),
                            ),
                          ),
                          onPressed: () {
                            selectJobType(JobType.mental);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/mental-wellbeing.svg',
                                height: 70,
                                width: 70,
                              ),
                              Text(JobType.mental.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 125,
                        height: 140,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: lightBlue,
                            textStyle: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultRadius),
                            ),
                          ),
                          onPressed: () {
                            selectJobType(JobType.housekeeping);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/housekeeping.svg',
                                height: 70,
                                width: 70,
                              ),
                              Text(JobType.housekeeping.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 125,
                        height: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: lightBlue,
                            textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultRadius),
                            ),
                          ),
                          onPressed: () {
                            selectJobType(JobType.mobility);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/wheelchair.svg',
                                height: 70,
                                width: 70,
                              ),
                              Text(JobType.mobility.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 125,
                        height: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: darkBlue,
                            textStyle: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultRadius),
                            ),
                          ),
                          onPressed: () {
                            selectJobType(JobType.literacy);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/digital-literacy.svg',
                                height: 70,
                                width: 70,
                              ),
                              Text(JobType.literacy.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Date: ",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd').format(selectedDate),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: const Text(
                            "Select Date",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Time: ",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          selectedTime.format(context),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            _selectTime();
                          },
                          child: const Text(
                            "Select Time",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius),
                      ),
                    ),
                    onPressed: () async {
                      Request request = await pushRequestToFirebase(
                          selected, selectedDate, selectedTime);
                      setRequest(request);
                      navigateToRequest(selected.toString());
                    },
                    child: const Text("Confirm"),
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
