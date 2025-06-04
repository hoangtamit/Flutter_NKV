import 'dart:developer' as developer;
import '../../model/KhachHang/tbl_KhachHang.dart';
import '../NhanVien/authorize_api.dart';

class KhachHangApi{
static Future<List<tbl_KhachHang>> KhachHang_Get4C_V2() async {
  try {
    final Data = await AuthorizeApi.Post('KhachHang/KhachHang_Get4C_V2');
    if (Data == null) {developer.log('API returned null data', name: '{Name}');return [];}
    final dsData = Data.map((e) => tbl_KhachHang.fromJson(e)).toList();
    developer.log('Loaded ${dsData.length} items', name: 'KhachHang_Get4C_V2');
    return dsData;
  } catch (e, stackTrace) {
    developer.log('Error in {Name}: $e',name: '{Name}',error: e,stackTrace: stackTrace,);return []; 
  }
}

}
