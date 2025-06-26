import 'package:flutter/material.dart';

class wDatatable {
  static const double columnSpacing =  16;
  static const TextStyle headerStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: Colors.black87,
  );
  static DataColumn buildDataColumn(String label, {double width = 70}) {
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
  static DataCell buildDataCell(String value,  {double width = 70,VoidCallback? onTap}) {
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
      onTap: onTap, // Áp dụng callback onTap
    );
  }
  static DataCell buildDataCell_Check(BuildContext context,String value,  {double width = 70,VoidCallback? onTap}) {
    return DataCell(
      Center(
        child: Checkbox(
        value: value.toLowerCase() == 'đúng' || value.toLowerCase() == 'true'|| value.toLowerCase() == '1',
          fillColor: WidgetStateProperty.resolveWith<Color?>(
                (states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.blue;
              }
              return Theme.of(context).colorScheme.surface;
            },
          ),
        onChanged: null, // Đặt null để làm checkbox chỉ đọc
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


