import 'package:driverspy/screens/search_by_image.dart';
import 'package:driverspy/screens/search_by_number.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  Widget currentScreen = SearchByImage();

  void changeScreen(int index) {
    setState(() {
      currentIndex = index;
    });
    switch (index) {
      case 0:
        currentIndex = 0;
        currentScreen = SearchByImage();
      case 1:
        currentIndex = 1;
        currentScreen = SearchByNumber();
    }
  }

  @override
  Widget build(BuildContext context) {
    final driverSpyAppbar = AppBar(
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "lib/assets/appbar_logo.png",
            height: MediaQuery.of(context).size.height * 0.1,
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: driverSpyAppbar,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 84, 2, 114),
        enableFeedback: true,
        // fixedColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(116, 158, 158, 158),
        selectedIconTheme: IconThemeData(size: 30),
        unselectedIconTheme: IconThemeData(size: 20),
        onTap: changeScreen,
        showSelectedLabels: true,
        selectedFontSize: 15,
        unselectedFontSize: 10,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.scan_camera_24_regular),
            label: 'Image',
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.text_12_filled),
            label: 'Number',
          )
        ],
      ),
      body: currentScreen,
    );
  }
}
