import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

final formatter = NumberFormat("#,##0", "en_US");
String formatNumber(int? number) {
  return number != null ? formatter.format(number) : "0";
}
String formatNumber2(dynamic number) {
  final formatter = NumberFormat("#,##0.##", "en_US");
  if (number == null) return "0";
  if (number is String) {
    final parsed = double.tryParse(number);
    return parsed != null ? formatter.format(parsed) : "0";
  }
  return formatter.format(number);
}