import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/Main/home-page.dart';
import '../../utilities/values/colors.dart';
class wAppBar {
  static PreferredSizeWidget buildAppBar(
      String title, {
        Color? backgroundColor = primaryColor,
        VoidCallback? onRefresh, List<IconButton>? actions,
      }) {
    return AppBar(
      title: Text(title, style: const TextStyle(color: Colors.black)),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: onRefresh,
        ),
      ],
      backgroundColor: backgroundColor,
      foregroundColor: Colors.black,
    );
  }
}
