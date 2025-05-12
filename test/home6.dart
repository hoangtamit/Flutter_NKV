import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:nkv/resources/Main/app-page.dart';
import 'package:nkv/resources/Main/barcode-page.dart';
import 'package:vibration/vibration.dart';
import 'Main/home-page.dart';
import 'Users/user-info.dart';
import 'Main/barcode_home.dart';
//import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

// Hằng số cho màu sắc, kích thước, và khoảng cách
const Color navBarColor = Colors.white;
const Color activeIconColor = Colors.orange;
const Color shadowColor = Colors.orange;
const double navBarHeight = 70.0;
const double circleSize = 70.0; // Kích thước nút Barcode
const double iconSize = 40.0;
const double cornerRadius = 4.0;
const double elevation = 4.0;
const EdgeInsets navBarPadding = EdgeInsets.only(left: 3, right: 3, bottom: 3);

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
            color: widget.isActive ? activeIconColor : Colors.black,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}

class NKVHomePage extends StatefulWidget {
  const NKVHomePage({super.key});
  @override
  State<NKVHomePage> createState() => _NKVHomePageState();
}

class _NKVHomePageState extends State<NKVHomePage> {
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
  void _openBarcodeScanner() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BarcodeScannerPage()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CircleNavBar(
        activeIcons: [
          const Icon(Icons.home, color: activeIconColor, size: iconSize),
          const Icon(Icons.grid_view_rounded, color: activeIconColor, size: iconSize),
          BarcodeButton(
            isActive: _tabIndex == 2,
            onTap: () => _onTabChanged(2),
          ),
          const Icon(Icons.list_alt, color: activeIconColor, size: iconSize),
          const Icon(Icons.person, color: activeIconColor, size: iconSize),
        ],
        inactiveIcons: const [
          Text("Trang Chủ"),
          Text("Ứng Dụng"),
          Text("Barcode"),
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
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _tabIndex = index),
        children: [
          HomePage(),
          const AppPage(),
          BarcodeScannerPage(),
          // BarcodeButton(
          //   isActive: false, // Không cần active vì không điều hướng trong PageView
          //   onTap: BarcodeScannerPage,
          // ),
          const BarcodeHome(),
          const EmployeeInfoPage(),
        ],
      ),
    );
  }
}

// Trang quét barcode
// class BarcodeScannerPage extends StatefulWidget {
//   const BarcodeScannerPage({super.key});
//
//   @override
//   State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
// }
// class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
//   MobileScannerController controller = MobileScannerController();
//   String? scannedCode;
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Quét mã barcode'),
//         backgroundColor: activeIconColor,
//         foregroundColor: Colors.white,
//       ),
//       body: Stack(
//         children: [
//           MobileScanner(
//             controller: controller,
//             onDetect: (capture) {
//               final List<Barcode> barcodes = capture.barcodes;
//               if (barcodes.isNotEmpty) {
//                 setState(() {
//                   scannedCode = barcodes.first.rawValue;
//                 });
//                 if (scannedCode != null) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Mã barcode: $scannedCode'),
//                       duration: const Duration(seconds: 3),
//                     ),
//                   );
// // Tạm dừng camera sau khi quét thành công
//                   controller.stop();
//                 }
//               }
//             },
//           ),
//           Positioned(
//             bottom: 20,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: activeIconColor,
//                   foregroundColor: Colors.white,
//                 ),
//                 child: const Text('Đóng'),
//               ),
//             ),
//           ),
//           if (scannedCode != null)
//             Positioned(
//               top: 20,
//               left: 0,
//               right: 0,
//               child: Center(
//                 child: Container(
//                   padding: const EdgeInsets.all(16),
//                   color: Colors.black54,
//                   child: Text(
//                     'Mã đã quét: $scannedCode',
//                     style: const TextStyle(color: Colors.white, fontSize: 16),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

