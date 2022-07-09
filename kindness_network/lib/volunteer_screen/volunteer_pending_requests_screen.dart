import 'package:flutter/material.dart';
import 'package:kindness_network/common/constants.dart';
import 'package:kindness_network/data/request.dart';
import 'package:kindness_network/volunteer_screen/volunteer_request_screen.dart';

class VolunteerPendingRequestsScreen extends StatefulWidget {
  const VolunteerPendingRequestsScreen({Key? key, required this.userId})
      : super(key: key);
  final int userId;

  @override
  State<VolunteerPendingRequestsScreen> createState() =>
      _VolunteerPendingRequestsScreenState();
}

class _VolunteerPendingRequestsScreenState
    extends State<VolunteerPendingRequestsScreen> {
  late Future<List<Request>> _calculation;

  @override
  void initState() {
    _calculation = Request.getAllAcceptedRequestsForVolunteer(widget.userId);
    super.initState();
  }

  void navigateToRequest(Request request) {
    Navigator.pushNamed(context, VolunteerRequestScreen.routeName,
        arguments: request);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upcoming Requests"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Request>>(
        future: _calculation, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<List<Request>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              children = const <Widget>[
                Center(child: Text("No Requests yet!"))
              ];
            } else {
              children = snapshot.data!.map((request) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
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
                            Text("${request.requestTime}",
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w400)),
                            Text(request.jobType.toString(),
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.underline)),
                            request.isAccepted
                                ? Text(request.requesterId.toString(),
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600))
                                : const Text("No Volunteer",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
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
                            navigateToRequest(request);
                          },
                          child: const Text("View",
                              style: TextStyle(color: Colors.black)),
                        ),
                      )
                    ],
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
