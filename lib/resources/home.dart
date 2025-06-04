import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import '../../resources/Main/app-page.dart';
import '../../resources/Main/barcode-page.dart';
import 'package:vibration/vibration.dart';
import '../utilities/values/colors.dart';
import 'Main/barcode-page.dart';
import 'Main/barcode-page2.dart';
import 'Main/barcode-page3.dart';
import 'Main/home-page.dart';
import 'Main/xac_nhan_page.dart';
import 'Users/user-info.dart';
//import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

// Hằng số cho màu sắc, kích thước, và khoảng cách
const Color navBarColor = Colors.white;
//const Color activeIconColor = primaryColor ;//Colors.orange;
//const Color shadowColor = Colors.orange;
const double navBarHeight = 70.0;
const double circleSize = 70.0; // Kích thước nút Barcode
const double iconSize = 40.0;
const double cornerRadius = 4.0;
const double elevation = 4.0;
const EdgeInsets navBarPadding = EdgeInsets.only(left: 3, right: 3, bottom: 0);

// Widget nút Barcode với hiệu ứng
class BarcodeButton extends StatefulWidget {
  final bool isActive;
  final VoidCallback onTap;
  const BarcodeButton({
    super.key,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<BarcodeButton> createState() => _BarcodeButtonState();
}
class _BarcodeButtonState extends State<BarcodeButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }
  @override
  void dispose() {_animationController.dispose();super.dispose();}
  void _handleTap() {
    //animationController.forward().then(() => _animationController.reverse());
    Vibration.vibrate(duration: 50); // Rung nhẹ khi nhấn
    widget.onTap();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: circleSize,
          height: circleSize,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: navBarColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            Icons.qr_code_scanner,
            color: widget.isActive ? primaryColor : Colors.black,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}

class qlsxHomePage extends StatefulWidget {
  const qlsxHomePage({super.key});
  @override
  State<qlsxHomePage> createState() => _qlsxHomePageState();
}

class _qlsxHomePageState extends State<qlsxHomePage> {
  int _tabIndex = 0;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _tabIndex);
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  void _onTabChanged(int index) {
    setState(() {
      _tabIndex = index;
    });
    _pageController.jumpToPage(index);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: SafeArea(
        child: CircleNavBar(
          activeIcons: [
            const Icon(Icons.home, color: primaryColor, size: iconSize),
            const Icon(Icons.grid_view_rounded, color: primaryColor, size: iconSize),
            const Icon(Icons.qr_code_scanner, color: primaryColor, size: iconSize),
            const Icon(Icons.list_alt, color: primaryColor, size: iconSize),
            const Icon(Icons.person, color: primaryColor, size: iconSize),
          ],
          inactiveIcons: const [
            Text("Trang Chủ"),
            Text("Ứng Dụng"),
            Text("Quét"),
            Text("Tiện Ích"),
            Text("Nhân Viên"),
          ],
          color: navBarColor,
          height: navBarHeight,
          circleWidth: circleSize,
          activeIndex: _tabIndex,
          onTap: _onTabChanged,
          padding: navBarPadding,
          cornerRadius: const BorderRadius.only(
            topLeft: Radius.circular(cornerRadius),
            topRight: Radius.circular(cornerRadius),
            bottomRight: Radius.circular(cornerRadius * 3),
            bottomLeft: Radius.circular(cornerRadius * 3),
          ),
          shadowColor: shadowColor,
          elevation: elevation,
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _tabIndex = index),
        children: [
          HomePage(),
          const AppPage(),
          BarcodeHomePage(),
          const XacNhanPage(),
          const EmployeeInfoPage(),
        ],
      ),
    );
  }
}