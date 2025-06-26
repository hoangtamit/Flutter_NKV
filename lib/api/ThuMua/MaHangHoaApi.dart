import 'dart:developer' as developer;
import 'package:nkv/model/ThuMua/tbl_MaHangHoa.dart';
import '../NhanVien/authorize_api.dart';

class MaHangHoaApi{
  static Future<List<tbl_MaHangHoa>> MaHangHoa_LoadData() async {
    try {
      final Data = await AuthorizeApi.Post('MaHangHoa/MaHangHoa_LoadData');
      if (Data == null) {
        developer.log('API returned null data', name: 'MaHangHoa_LoadData');return [];
      }
      final dsData = Data.map((e) => tbl_MaHangHoa.fromJson(e)).toList();
      developer.log('Loaded ${dsData.length} items', name: 'MaHangHoa_LoadData');
      return dsData;
    } catch (e, stackTrace) {
      developer.log('Error in MaHangHoa_LoadData: $e',name: 'MaHangHoa_LoadData',error: e,stackTrace: stackTrace,);return [];
    }
  }
}
