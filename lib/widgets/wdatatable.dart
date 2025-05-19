import 'package:flutter/material.dart';

class wDatatable {
  static const double columnSpacing =  16;
  static const TextStyle headerStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: Colors.black87,
  );
  static DataColumn buildDataColumn(String label, double width) {
    return DataColumn(
      label: SizedBox(
        width: width,
        child: Text(
          label,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: wDatatable.headerStyle,
        ),
      ),
    );
  }
  static DataCell buildDataCell(String value, double width ) {
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
  static DataCell buildDataCell2(String value, double width ) {
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


