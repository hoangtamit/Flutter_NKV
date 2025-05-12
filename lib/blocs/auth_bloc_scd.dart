import 'dart:async';
import 'package:flutter/cupertino.dart';
class AuthBlocSCD {
  //final _firAuth = FirAuth();

  final StreamController _nameController = StreamController();

  //Stream get nameStream => _nameController.stream;


  bool isValid(String barcode) {
    RegExp exp = RegExp(r'(\b\w{3}\-\d{6}\-\d{4}\b)');
    var match = exp.hasMatch(barcode.toString());
    if (barcode.isEmpty || match == false) {
      //_nameController.sink.addError("Nhập tên");
      return false;
    }
    return true;
  }

  void dispose() {
    _nameController.close();
  }
}
