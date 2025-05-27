import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class fDateTime{
  static bool isValidDateTime(String dateTimeString) {
    final RegExp dateTimeRegex = RegExp(
        r'^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\/)\d{4}( )[0-1][0-9]|2[0-3]:[0-5][0-9]$');
    if (!dateTimeRegex.hasMatch(dateTimeString)) {
      return false;
    }
    try {
      DateFormat('dd/MM/yyyy HH:mm').parseStrict(dateTimeString);
      return true;
    } catch (e) {
      return false;
    }
  }
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
  static String DD_MM_YYYY_HH_MM(String value){
    try {
      var format = DateFormat('dd/MM/yyyy HH:mm');
      final datetime = format.format(DateTime.parse(value));
      return datetime;
    }catch(e){
      debugPrint('----------------------------------Lỗi : ${e.toString()}');
      return value;
    }
  }
  static String DD_MM_YYYY_HH_MM_SS(String value){
    try {
      var format = DateFormat('dd/MM/yyyy HH:mm:ss');
      final datetime = format.format(DateTime.parse(value));
      return datetime;
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