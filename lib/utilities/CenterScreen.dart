import 'package:flutter/material.dart';
import '../../widgets/wAppBar.dart';
import '../utilities/values/screen.dart';

class CenterScreen extends StatefulWidget {
  final String title;
  final Widget child; // Widget con được truyền vào
  final Color? color;
  final double? formWidth;
  const CenterScreen({super.key,
  required this.title,
  required this.child,
    this.color,
    this.formWidth,
  });
  @override
  _CenterScreenState createState() => _CenterScreenState();
}
class _CenterScreenState extends State<CenterScreen> {
  @override
  Widget build(BuildContext context) {
    // Sử dụng formWidth được truyền vào hoặc lấy từ ScreenUtils
    final width = widget.formWidth ?? screen.widthForm(context);
    return Scaffold(
      appBar: wAppBar.buildAppBar(widget.title,onRefresh: () {setState(() {});},),
      body: Center(
        child: Container(
          width: width, // Chiều rộng động
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          color: widget.color,
          child: widget.child, // Sử dụng widget con được truyền vào
        ),
      ),
    );
  }
}
