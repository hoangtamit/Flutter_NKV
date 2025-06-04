import 'dart:developer' as developer;
import '../../model/BoPhan/tbl_BoPhan.dart';
import '../NhanVien/authorize_api.dart';

class BoPhanApi{
  static Future<List<tbl_BoPhan>> Get1C() async {
    try {
      final Data = await AuthorizeApi.Post('BoPhan/Get1C');
      if (Data == null) {
        developer.log('API returned null data', name: 'Get1C');
        return [];
      }
      final dsData = Data.map((e) => tbl_BoPhan.fromJson(e)).toList();
      developer.log('Loaded ${dsData.length} items', name: 'Get1C');
      return dsData;
    } catch (e, stackTrace) {
      developer.log(
        'Error in Get1C: $e',
        name: 'Get1C',
        error: e,
        stackTrace: stackTrace,
      );
      return [];
    }
  }

}