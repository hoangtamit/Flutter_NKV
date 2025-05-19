import 'package:flutter/cupertino.dart';
import 'package:nkv/widgets/wdatatable.dart';
int columnNumber = 12;
class screen{
  //MediaQuery.of(context).size.width = 411.428
  //MediaQuery.of(context).size.height = 866.285
  static double widthFullScreen(dynamic context){
    final width = MediaQuery.of(context).size.width;
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