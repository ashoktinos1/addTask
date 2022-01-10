
import 'package:flutter/material.dart';
import 'package:myproject1/views/home_page/task_page.dart';
import 'package:myproject1/views/leave_screen/leave_screen.dart';
import 'package:myproject1/views/puchscreen/punch_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  final _pages = [
    const PunchScreen(),
    LeaveScreen(
      leavetypes: null,
      typeofleaves: null,
      dates: null,
    ),
   const HomePage()
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[currentIndex],
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: currentIndex,
          duration: const Duration(milliseconds: 500),
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.fingerprint_rounded,
              ),
              title: const Text('Punch'),
              selectedColor: Colors.black,
              unselectedColor: Colors.grey,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.local_hospital_rounded),
              title: const Text('Leave'),
              selectedColor: Colors.black,
              unselectedColor: Colors.grey,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.task_alt_rounded),
              title: const Text('Task'),
              selectedColor: Colors.black,
              unselectedColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
