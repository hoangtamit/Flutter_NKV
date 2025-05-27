import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/Main/home-page.dart';

class wAppBar {
  static PreferredSizeWidget buildAppBar(
      String title, {
        Color? backgroundColor = primaryColor,
        VoidCallback? onRefresh,
      }) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: onRefresh,
        ),
      ],
      backgroundColor: backgroundColor,
      foregroundColor: Colors.white,
    );
  }
}
