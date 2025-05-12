import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowDialog {
 static showAlertDialog(BuildContext context,String text) {
    // set up the button
    Widget launchButton = TextButton(
      child: const Text("OK"),
      onPressed:  () {
        Navigator.of(context).pop(); // dismiss dialog
        //launchMissile();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Thông Báo"),
      content: Text(text),
      actions: [
        launchButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

 static showAlertDialog2(BuildContext context) {

   // set up the buttons
   Widget cancelButton = TextButton(
     child: Text("Cancel"),
     onPressed:  () {},
   );
   Widget continueButton = TextButton(
     child: Text("Continue"),
     onPressed:  () {},
   );

   // set up the AlertDialog
   AlertDialog alert = AlertDialog(
     title: Text("AlertDialog"),
     content: Text("Would you like to continue learning how to use Flutter alerts?"),
     actions: [
       cancelButton,
       continueButton,
     ],
   );

   // show the dialog
   showDialog(
     context: context,
     builder: (BuildContext context) {
       return alert;
     },
   );
 }
 static showAlertDialog3(BuildContext context) {
   // set up the buttons
   Widget remindButton = TextButton(
     child: Text("Remind me later"),
     onPressed:  () {},
   );
   Widget cancelButton = TextButton(
     child: Text("Cancel"),
     onPressed:  () {},
   );
   Widget launchButton = TextButton(
     child: Text("Launch missile"),
     onPressed:  () {},
   );

   // set up the AlertDialog
   AlertDialog alert = AlertDialog(
     title: Text("Notice"),
     content: Text("Launching this missile will destroy the entire universe. Is this what you intended to do?"),
     actions: [
       remindButton,
       cancelButton,
       launchButton,
     ],
   );

   // show the dialog
   showDialog(
     context: context,
     builder: (BuildContext context) {
       return alert;
     },
   );
 }

}