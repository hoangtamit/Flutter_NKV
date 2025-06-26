import 'dart:developer' as developer;
import '../../model/ThuMua/VatLieu_Get4C.dart';
import '../NhanVien/authorize_api.dart';

class VatLieuApi{
  static Future<List<VatLieu_Get4C>> VatLieu_LoadData4C() async {
    try {
      final Data = await AuthorizeApi.Post('VatLieu/VatLieu_LoadData4C');
      if (Data == null) {
        developer.log('API returned null data', name: 'Get1C');
        return [];
      }
      final dsData = Data.map((e) => VatLieu_Get4C.fromJson(e)).toList();
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
  static Future<List<VatLieu_Get4C>> VatLieu4C_GetLoaiHang(String LoaiHang) async {
    try {
      final data = {'LoaiHang': LoaiHang,};
      final Data = await AuthorizeApi.Get_Data('VatLieu/VatLieu4C_GetLoaiHang',data);
      if (Data == null) {
        developer.log('API returned null data', name: 'Get1C');
        return [];
      }
      final dsData = Data.map((e) => VatLieu_Get4C.fromJson(e)).toList();
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