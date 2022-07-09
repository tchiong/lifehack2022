import 'package:flutter/material.dart';
import 'package:kindness_network/volunteer_screen/volunteer_past_requests_screen.dart';
import 'package:kindness_network/volunteer_screen/volunteer_view_requests.dart';

class VolunteerMainScreen extends StatefulWidget {
  static const String routeName = 'volunteer-screen';
  const VolunteerMainScreen({Key? key, required this.userId}) : super(key: key);
  final int userId;

  @override
  State<VolunteerMainScreen> createState() => _VolunteerMainScreenState();
}

class _VolunteerMainScreenState extends State<VolunteerMainScreen> {
  int _page = 0;
  final double bottomBarWidth = 42;
  final double bottomBarBorder = 5;

  late List<Widget> pages;

  @override
  void initState() {
    pages = [
      VolunteerViewRequestsScreen(
        userId: widget.userId,
      ),
      const Center(child: Text("upcoming")),
      const Center(child: Text("past")),
    ];
    super.initState();
  }

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black87,
        items: [
          BottomNavigationBarItem(
              icon: SizedBox(
                width: bottomBarWidth,
                child: const Icon(Icons.list),
              ),
              label: 'View Request'),
          BottomNavigationBarItem(
              icon: SizedBox(
                width: bottomBarWidth,
                child: const Icon(Icons.pending_outlined),
              ),
              label: 'Upcoming Request'),
          BottomNavigationBarItem(
              icon: SizedBox(
                width: bottomBarWidth,
                child: const Icon(Icons.history),
              ),
              label: 'Past Request'),
        ],
        onTap: (int index) {
          updatePage(index);
        },
      ),
    );
  }
}
