import 'package:flutter/material.dart';
import 'package:kindness_network/beneficiary_screen/beneficiary_create_request_screen.dart';
import 'package:kindness_network/beneficiary_screen/beneficiary_pending_request_screen.dart';

class BeneficiaryMainScreen extends StatefulWidget {
  static const String routeName = 'beneficiary-screen';
  const BeneficiaryMainScreen({Key? key}) : super(key: key);

  @override
  State<BeneficiaryMainScreen> createState() => _BeneficiaryMainScreenState();
}

class _BeneficiaryMainScreenState extends State<BeneficiaryMainScreen> {
  int _page = 0;
  final double bottomBarWidth = 42;
  final double bottomBarBorder = 5;

  List<Widget> pages = [
    const BeneficiaryCreateRequestScreen(),
    const BeneficiaryPendingRequestScreen(),
    const Center(child: Text("View Past")),
  ];

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
                  child: const Icon(Icons.add_box_outlined),
                ),
                label: 'New Request'),
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