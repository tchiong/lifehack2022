import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kindness_network/common/constants.dart';
import 'package:kindness_network/data/request.dart';

import '../data/users.dart';

class VolunteerPastRequestsScreen extends StatefulWidget {
  const VolunteerPastRequestsScreen({Key? key, required this.userId})
      : super(key: key);
  final int userId;

  @override
  State<VolunteerPastRequestsScreen> createState() =>
      _VolunteerPastRequestsScreenState();
}

class _VolunteerPastRequestsScreenState
    extends State<VolunteerPastRequestsScreen> {
  late Future<List<Request>> _calculation;
  late Future<List<User>> _users;

  @override
  void initState() {
    _calculation = Request.getAllCompletedRequestsForVolunteer(widget.userId);
    _users = User.getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Past Requests"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([
          _calculation,
          _users
        ]), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            List<Request> calculation = snapshot.data?[0];
            List<User> users = snapshot.data?[1];
            if (calculation.isEmpty) {
              children = const <Widget>[
                Center(child: Text("No Requests Completed yet!"))
              ];
            } else {
              children = calculation.map((request) {
                User requesterUser =
                    users.firstWhere((user) => user.id == request.requesterId);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
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
                      children: [
                        Text(requesterUser.address,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        Text(
                            DateFormat('yyyy-MM-dd hh:mm')
                                .format(request.requestTime),
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w400)),
                        Text(request.jobType.toString(),
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline)),
                        RichText(
                            text: TextSpan(
                          text: "Age: ",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: requesterUser.age.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        )),
                      ],
                    ),
                  ),
                );
              }).toList();
            }
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = <Widget>[
              Center(
                child: Column(
                  children: const [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    )
                  ],
                ),
              ),
            ];
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              child: Column(
                children: children,
              ),
            ),
          );
        },
      ),
    );
  }
}
