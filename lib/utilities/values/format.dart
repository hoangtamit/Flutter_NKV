import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

class fDateTime{
  static String YYYY_MM_DD(String value){
    final datetime = DateTime.parse(value);
    String result = DateFormat('yyyy-MM-dd').format(datetime);
    return result;
  }
  static String DD_MM_YYYY(String value){
    try {
      final datetime = DateTime.parse(value.replaceAll('/', '-'));
      final result = DateFormat('dd/MM/yyyy').format(datetime);
      return result;
    }catch(e){
      debugPrint('----------------------------------Lỗi : ${e.toString()}');
      return value;
    }
  }
  static String YYYY_MM(String value){
    final datetime = DateTime.parse(value);
    String result = DateFormat('yyyyMM').format(datetime);
    return result;
  }
  static String YYYYMM() {
    String s = DateFormat("yyyyMM").format(DateTime.now());
    return s;
  }
  DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    try {
      // Thử phân tích trực tiếp (cho định dạng ISO 8601)
      return DateTime.parse(value);
    } catch (e) {
      // Nếu thất bại, thử các định dạng khác
      try {
        // Ví dụ: định dạng "dd/MM/yyyy HH:mm:ss"
        final format = DateFormat('dd/MM/yyyy HH:mm:ss');
        return format.parse(value);
      } catch (e) {
        print('Lỗi phân tích DateTime: $value');
        return null; // Hoặc xử lý lỗi khác
      }
    }
  }
}
String formatSoLuong(int? soluong) {
  final formatter = NumberFormat("#,##0", "vi_VN");
  return formatter.format(soluong);
}
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