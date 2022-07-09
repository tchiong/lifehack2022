import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kindness_network/common/constants.dart';
import 'package:kindness_network/data/request.dart';
import 'package:kindness_network/volunteer_screen/volunteer_request_screen.dart';

class VolunteerViewRequestsScreen extends StatefulWidget {
  const VolunteerViewRequestsScreen({Key? key}) : super(key: key);

  @override
  State<VolunteerViewRequestsScreen> createState() => _VolunteerViewRequestsScreenState();
}

class _VolunteerViewRequestsScreenState extends State<VolunteerViewRequestsScreen> {
  final Future<List<Request>> _calculation = Request.getAllActiveRequests();
  
  void acceptRequest(Request request) async {
    bool accepted = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you sure?"),
          content: Text(request.id.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
    _moveToRequestScreen(accepted, request);
  }

  void _moveToRequestScreen(bool accepted, Request request) {
    if (accepted) {
      Navigator.pushNamed(context, VolunteerRequestScreen.routeName,
        arguments: request);
    }
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
                            Text("Blk 38 Oxley Rd #01-00",
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                            Text(DateFormat('yyyy-MM-dd hh:mm').format(request.requestTime),
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w400)),
                            Text(request.jobType.toString(),
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.underline)),
                            RichText(
                              text: const TextSpan(
                                text: "Age: ", 
                                style: TextStyle(color:Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
                                children: [
                                  TextSpan(text: "99", style: TextStyle(color:Colors.black, fontSize: 24, fontWeight: FontWeight.w400),)
                                ],
                              )
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: darkBlue,
                    textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(defaultRadius),
                    ),
                  ),
                  onPressed: (){
                    acceptRequest(request);
                  }, 
                  child: const Text("Accept", style: TextStyle(color: Colors.black)),
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
      )
    );
  }
}