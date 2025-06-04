import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../widgets/wdatatable.dart';
int columnNumber = 12;
class screen{
  //MediaQuery.of(context).size.width = 411.428
  //MediaQuery.of(context).size.height = 866.285
  static double widthFullScreen(dynamic context){
    final width = MediaQuery.of(context).size.width;
    return width;
  }
  static double widthForm(BuildContext context, {double widthform = 450,double heightform = 600}){
    // Xác định chiều rộng dựa trên nền tảng
    double width = MediaQuery.of(context).size.width; // Mặc định full width
    if (kIsWeb || Platform.isWindows || Platform.isMacOS) {

      width = MediaQuery.of(context).orientation == Orientation.portrait ? widthform : heightform;
    }
    return width;
  }
  static double width(dynamic context, double column, { double columnSpacing = wDatatable.columnSpacing }){
    final width = (MediaQuery.of(context).size.width - (columnSpacing * 2)) / columnNumber * column;
    return width;
  }
  static double heightFullScreen(dynamic context){
    final width = MediaQuery.of(context).size.height;
    return width;
  }
  static double height(dynamic context, int column){
    final width = MediaQuery.of(context).size.height / columnNumber * column;
    return width;
  }
}