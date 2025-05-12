import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class widgetText
{
  static Text txt01(String text){
    return Text(text,style: const TextStyle(color: Colors.black));
  }
  static Text txt02(String text,double size)
  {
    return Text(
      text,style: TextStyle(fontSize: size),
    );
  }
  static Text txt03(String text,double size,FontWeight weight)
  {
    return Text(
      text,style: TextStyle(fontSize: size,fontWeight: weight),
    );
  }
  static Text txt04(String text,double size,FontWeight weight,FontStyle fontStyle)
  {
    return Text(
      text,style: TextStyle(fontSize: size,fontWeight: weight,fontStyle: fontStyle),
    );
  }
}
