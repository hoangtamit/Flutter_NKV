import 'package:flutter/material.dart';

class WDatatable {
  static const TextStyle headerStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: Colors.black87,
  );
  static DataCell buildDataCell(String value, {double width = 60}) {
    return DataCell(
      Center(
        child: SizedBox(
          width: width,
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}


