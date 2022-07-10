import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kindness_network/common/constants.dart';
import 'package:kindness_network/common/widgets/language_selector.dart';
import 'package:kindness_network/data/request.dart';
import 'package:kindness_network/data/users.dart';
import 'package:kindness_network/volunteer_screen/volunteer_main.dart';

class VolunteerRequestScreen extends StatefulWidget {
  static const String routeName = 'volunteer-request';
  const VolunteerRequestScreen({Key? key, required this.request})
      : super(key: key);
  final Request request;

  @override
  State<VolunteerRequestScreen> createState() => _VolunteerRequestScreenState();
}

class _VolunteerRequestScreenState extends State<VolunteerRequestScreen> {
  late Future<User?> _requesterUser;

  void navigateToVolunteerScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, VolunteerMainScreen.routeName, (_) => false,
        arguments: widget.request.acceptedId);
  }

  showPhoneDialog() async {
    User? requesterUser =
        await User.getUserFromUserId(widget.request.requesterId);
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: widget.request.requesterId == -1
            ? const Text('Not Accepted')
            : const Text('Accepted'),
        content: widget.request.requesterId == -1
            ? const Text(
                'Please give volunteers some time to accept the request')
            : Text(requesterUser?.phoneNumber ?? ''),
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
  void initState() {
    _requesterUser = User.getUserFromUserId(widget.request.requesterId);
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
                LanguageSelector(
                  userId: widget.request.acceptedId,
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
                  child: FutureBuilder<User?>(
                      future: _requesterUser,
                      builder: (BuildContext context,
                          AsyncSnapshot<User?> snapshot) {
                        User? user;
                        if (snapshot.hasData) {
                          user = snapshot.data;
                        } else {
                          user = null;
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Special Requirements:",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600)),
                            Text(user == null ? '' : user.specialNeeds,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400)),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      }),
                  //
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
                    onPressed: () {
                      showPhoneDialog();
                    },
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
                      Request.removeRequestAcceptedId(widget.request);
                      navigateToVolunteerScreen();
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
                      Request.completeRequestVolunteer(widget.request);
                      navigateToVolunteerScreen();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
