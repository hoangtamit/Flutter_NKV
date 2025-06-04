import 'dart:developer' as developer;
import 'package:nkv/model/NghiepVu/tbl_DanhSachSanPham.dart';
import '../NhanVien/authorize_api.dart';
class SanPhamApi{

  static Future<List<tbl_DanhSachSanPham>> SanPham4C_GetTenKhachHang(String TenKhachHang) async {
    try {
      var data = {
        'TenKhachHang' : TenKhachHang,
      };
      final Data = await AuthorizeApi.Get_Data('DonSanXuat/SanPham4C_GetTenKhachHang',data);
      if (Data == null) {
        developer.log('API returned null data', name: 'SanPham4C_GetTenKhachHang');return [];
      }
      final dsData = Data.map((e) => tbl_DanhSachSanPham.fromJson(e)).toList();
      developer.log('Loaded ${dsData.length} items', name: 'SanPham4C_GetTenKhachHang');
      return dsData;
    } catch (e, stackTrace) {
      developer.log('Error in SanPham4C_GetTenKhachHang: $e',name: 'SanPham4C_GetTenKhachHang',error: e,stackTrace: stackTrace,);return [];
    }
  }
  static Future<List<tbl_DanhSachSanPham>> SanPham_Get4C() async {
    try {
      final Data = await AuthorizeApi.Get('DonSanXuat/SanPham_Get4C');
      if (Data == null) {
        developer.log('API returned null data', name: 'SanPham_Get4C');return [];
      }
      final dsData = Data.map((e) => tbl_DanhSachSanPham.fromJson(e)).toList();
      developer.log('Loaded ${dsData.length} items', name: 'SanPham_Get4C');
      return dsData;
    } catch (e, stackTrace) {
      developer.log('Error in SanPham_Get4C: $e',name: 'SanPham_Get4C',error: e,stackTrace: stackTrace,);return [];
    }
  }


}
