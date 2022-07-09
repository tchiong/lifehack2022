import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kindness_network/common/constants.dart';
import 'package:kindness_network/data/request.dart';

import '../data/users.dart';

class BeneficiaryPastRequestsScreen extends StatefulWidget {
  const BeneficiaryPastRequestsScreen({Key? key, required this.userId})
      : super(key: key);
  final int userId;

  @override
  State<BeneficiaryPastRequestsScreen> createState() =>
      _BeneficiaryPastRequestsScreenState();
}

class _BeneficiaryPastRequestsScreenState
    extends State<BeneficiaryPastRequestsScreen> {
  late Future<List<Request>> _calculation;
  late Future<User?> _user;

  @override
  void initState() {
    _calculation = Request.getAllCompletedRequestsForBeneficiary(widget.userId);
    _user = User.getUserFromUserId(widget.userId);
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
          _user
        ]), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              children = const <Widget>[
                Center(child: Text("No Requests Completed yet!"))
              ];
            } else {
              List<Request> calculation = snapshot.data?[0];
              User? user = snapshot.data?[1];
              children = calculation.map((request) {
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
                                  text: user == null ? '' : user.age.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400),
                                )
                              ]))
                        ]),
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
