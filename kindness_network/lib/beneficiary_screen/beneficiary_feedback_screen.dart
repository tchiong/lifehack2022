import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kindness_network/beneficiary_screen/beneficiary_main.dart';
import 'package:kindness_network/common/constants.dart';
import 'package:kindness_network/common/widgets/custom_textfield.dart';
import 'package:kindness_network/common/widgets/language_selector.dart';

import 'package:kindness_network/data/request.dart';

class BeneficiaryFeedbackScreen extends StatefulWidget {
  static const String routeName = '/beneficiary-feedback';
  const BeneficiaryFeedbackScreen({Key? key, required this.request})
      : super(key: key);
  final Request request;

  @override
  State<BeneficiaryFeedbackScreen> createState() =>
      _BeneficiaryFeedbackScreenState();
}

class _BeneficiaryFeedbackScreenState extends State<BeneficiaryFeedbackScreen> {
  double rating = 1;
  TextEditingController feedbackController = TextEditingController();
  void navigateToBeneficiaryScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, BeneficiaryMainScreen.routeName, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
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
                      Text(widget.request.requestTime.toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400)),
                      Text(widget.request.jobType.toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline)),
                    ],
                  ),
                ),
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
                    children: const [
                      Text("Assigned Volunteer:",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600)),
                      Text("Pending", // Change to request.acceptedId's name
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400)),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
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
                      const Text("Request Complete:",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600)),
                      Text(
                          widget.request.requestTime
                              .toString(), // Change to request.acceptedId's name
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400)),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "How was your experience?",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset('assets/icons/volunteer.svg',
                        width: 80, height: 80),
                    Column(
                      children: [
                        const Text(
                          "Please rate out of 5",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        RatingBar.builder(
                          initialRating: rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star_outline_outlined,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (newRating) {
                            setState(() {
                              rating = newRating;
                            });
                          },
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: feedbackController,
                  hintText: "Enter your feedback",
                  maxLines: 3,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
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
                    onPressed: () =>
                        {navigateToBeneficiaryScreen()}, //TODO: Submit feedback
                    child: const Text("Submit",
                        style: TextStyle(color: Colors.black)),
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
