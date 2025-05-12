import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';

import 'Main/home-page.dart';
import 'barcode_home.dart';

class NKVHomePage extends StatefulWidget {
  const NKVHomePage({super.key});
  @override
  State<NKVHomePage> createState() => _NKVHomePageState();
}
class _NKVHomePageState extends State<NKVHomePage> with SingleTickerProviderStateMixin {
  int _tabIndex = 1;
  int get tabIndex => _tabIndex;
  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CircleNavBar(
        activeIcons: const [
          Icon(Icons.home, color: Colors.orange),
          Icon(Icons.person, color: Colors.orange),
          Icon(Icons.qr_code_scanner, color: Colors.orange),
          Icon(Icons.home, color: Colors.orange),
          Icon(Icons.person, color: Colors.orange),
        ],
        inactiveIcons: const [
          Text("Home"),
          Text("Ulities"),
          Text("Bacode"),
          Text("User"),
          Text("User2"),
        ],
        color: Colors.white,
        height: 60,
        circleWidth: 60,
        activeIndex: tabIndex,
        onTap: (index) {
          tabIndex = index;
          pageController.jumpToPage(tabIndex);
        },
        padding: const EdgeInsets.only(left: 3, right: 3, bottom: 3),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        shadowColor: Colors.purple,
        elevation: 10,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (v) {
          tabIndex = v;
        },
        children: [
          HomePage(),
          HomePage(),
          HomePage(),
          //BarcodeHome(),
          // BarcodeHome(),
          // Container(
          //     width: double.infinity,
          //     height: double.infinity,
          //     color: Colors.green),
          // Container(
          //     width: double.infinity,
          //     height: double.infinity,
          //     color: Colors.blue),
        ],
      ),
    );
  }
}