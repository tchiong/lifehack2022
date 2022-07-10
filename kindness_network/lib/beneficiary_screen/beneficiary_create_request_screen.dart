import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kindness_network/beneficiary_screen/beneficiary_request_screen.dart';
import 'package:kindness_network/common/constants.dart';
import 'package:kindness_network/common/widgets/language_selector.dart';
import 'package:kindness_network/data/request.dart';
import 'package:kindness_network/data/users.dart';

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
  late Future<Lang?> _userLang;

  Future<Lang?> refreshLang() async {
    Lang? lang = await User.getUserFromUserId(widget.userId).then(
      (value) {
        if (value != null) {
          return value.language;
        } else {
          return Lang.en;
        }
      },
    );
    return lang;
  }

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
      isCompletedAcceptee: false,
      isCompletedBeneficiary: false,
      completedTime: null,
      rating: -1,
      feedback: '',
    );
    Firebase().pushDataToList('request/', request.toJson());
    return request;
  }

  @override
  void initState() {
    _userLang = refreshLang();
    super.initState();
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
                LanguageSelector(
                  userId: widget.userId,
                  callback: refreshLang,
                ),
                const SizedBox(
                  height: 5,
                ),
                FutureBuilder(
                    future: _userLang,
                    builder:
                        (BuildContext context, AsyncSnapshot<Lang?> snapshot) {
                      if (snapshot.hasData) {
                        Lang? userLang = snapshot.data;
                        return Text(
                            userLang == Lang.ch
                                ? selected.toChinese()
                                : selected.toString(),
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w600));
                      } else {
                        return Text(selected.toString(),
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w600));
                      }
                    }),
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
                              FutureBuilder(
                                  future: _userLang,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<Lang?> snapshot) {
                                    if (snapshot.hasData) {
                                      Lang? userLang = snapshot.data;
                                      return Text(
                                          userLang == Lang.ch
                                              ? JobType.mental.toChinese()
                                              : JobType.mental.toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black));
                                    } else {
                                      return Text(selected.toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black));
                                    }
                                  }),
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
                              FutureBuilder(
                                  future: _userLang,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<Lang?> snapshot) {
                                    if (snapshot.hasData) {
                                      Lang? userLang = snapshot.data;
                                      return Text(
                                          userLang == Lang.ch
                                              ? JobType.housekeeping.toChinese()
                                              : JobType.housekeeping.toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black));
                                    } else {
                                      return Text(selected.toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black));
                                    }
                                  }),
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
                              FutureBuilder(
                                  future: _userLang,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<Lang?> snapshot) {
                                    if (snapshot.hasData) {
                                      Lang? userLang = snapshot.data;
                                      return Text(
                                          userLang == Lang.ch
                                              ? JobType.mobility.toChinese()
                                              : JobType.mobility.toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black));
                                    } else {
                                      return Text(selected.toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black));
                                    }
                                  }),
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
                              FutureBuilder(
                                  future: _userLang,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<Lang?> snapshot) {
                                    if (snapshot.hasData) {
                                      Lang? userLang = snapshot.data;
                                      return Text(
                                          userLang == Lang.ch
                                              ? JobType.literacy.toChinese()
                                              : JobType.literacy.toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black));
                                    } else {
                                      return Text(selected.toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black));
                                    }
                                  }),
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
                        FutureBuilder(
                            future: _userLang,
                            builder: (BuildContext context,
                                AsyncSnapshot<Lang?> snapshot) {
                              if (snapshot.hasData) {
                                Lang? userLang = snapshot.data;
                                return Text(
                                    userLang == Lang.ch ? '日期' : "Date: ",
                                    style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w400));
                              } else {
                                return const Text(
                                  "Date: ",
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w400),
                                );
                              }
                            }),
                        Text(
                          DateFormat('yyyy-MM-dd').format(selectedDate),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: FutureBuilder(
                              future: _userLang,
                              builder: (BuildContext context,
                                  AsyncSnapshot<Lang?> snapshot) {
                                if (snapshot.hasData) {
                                  Lang? userLang = snapshot.data;
                                  return Text(
                                      userLang == Lang.ch
                                          ? '选择日期'
                                          : "Select Date",
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400));
                                } else {
                                  return const Text(
                                    "Select Date",
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w400),
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FutureBuilder(
                            future: _userLang,
                            builder: (BuildContext context,
                                AsyncSnapshot<Lang?> snapshot) {
                              if (snapshot.hasData) {
                                Lang? userLang = snapshot.data;
                                return Text(
                                    userLang == Lang.ch ? '时间' : "Time: ",
                                    style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w400));
                              } else {
                                return const Text(
                                  "Time: ",
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w400),
                                );
                              }
                            }),
                        Text(
                          selectedTime.format(context),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            _selectTime();
                          },
                          child: FutureBuilder(
                              future: _userLang,
                              builder: (BuildContext context,
                                  AsyncSnapshot<Lang?> snapshot) {
                                if (snapshot.hasData) {
                                  Lang? userLang = snapshot.data;
                                  return Text(
                                      userLang == Lang.ch
                                          ? '选择时间'
                                          : "Select Time",
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400));
                                } else {
                                  return const Text(
                                    "Select Time",
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w400),
                                  );
                                }
                              }),
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
                    child: FutureBuilder(
                        future: _userLang,
                        builder: (BuildContext context,
                            AsyncSnapshot<Lang?> snapshot) {
                          if (snapshot.hasData) {
                            Lang? userLang = snapshot.data;
                            return Text(userLang == Lang.ch ? '确认' : "Confirm");
                          } else {
                            return const Text(
                              "Confirm",
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.w400),
                            );
                          }
                        }),
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
