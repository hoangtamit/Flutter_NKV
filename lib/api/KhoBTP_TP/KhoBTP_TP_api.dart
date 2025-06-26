import 'dart:developer' as developer;
import '../../model/KhoBTP_TP/KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetNhap.dart';
import '../../model/KhoBTP_TP/KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat.dart';
import '../../model/KhoBTP_TP/KhoBTP_TP_TonKho.dart';
import '../../model/KhoBTP_TP/KhoBTP_TP_XuatKho_ChiTiet.dart';
import '../../model/KhoBTP_TP/tbl_KhoBTP_TP.dart';
import '../NhanVien/authorize_api.dart';
class KhoBTP_TPApi{

static Future<List<KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetNhap>> KhoBTP_TP_GroupByMaPhieu_GetNhap() async {
  try {
    final Data = await AuthorizeApi.Post('KhoBTP_TP/KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetNhap');
    if (Data == null) {
     developer.log('API returned null data', name: 'KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetNhap');return [];
     }
    final dsData = Data.map((e) => KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetNhap.fromJson(e)).toList();
    developer.log('Loaded ${dsData.length} items', name: 'KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetNhap');
    return dsData;
  } catch (e, stackTrace) {
    developer.log('Error in KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetNhap: $e',name: 'KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetNhap',error: e,stackTrace: stackTrace,);return []; 
  }
}

static Future<List<tbl_KhoBTP_TP>> KhoBTP_TP_GetKhuVuc_GetNhapXuat(String NhapXuat) async {
  try {
  var data = {   
 'NhapXuat' : NhapXuat,
  };
    final Data = await AuthorizeApi.Get_Data('KhoBTP_TP/KhoBTP_TP_GetKhuVuc_GetNhapXuat',data);
    if (Data == null) {
     developer.log('API returned null data', name: 'KhoBTP_TP_GetKhuVuc_GetNhapXuat');return [];
     }
    final dsData = Data.map((e) => tbl_KhoBTP_TP.fromJson(e)).toList();
    developer.log('Loaded ${dsData.length} items', name: 'KhoBTP_TP_GetKhuVuc_GetNhapXuat');
    return dsData;
  } catch (e, stackTrace) {
    developer.log('Error in KhoBTP_TP_GetKhuVuc_GetNhapXuat: $e',name: 'KhoBTP_TP_GetKhuVuc_GetNhapXuat',error: e,stackTrace: stackTrace,);return []; 
  }
}

static Future<List<KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat>> KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat_V2() async {
  try {
    final Data = await AuthorizeApi.Post('KhoBTP_TP/KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat_V2');
    if (Data == null) {
     developer.log('API returned null data', name: 'KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat_V2');return [];
     }
    final dsData = Data.map((e) => KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat.fromJson(e)).toList();
    developer.log('Loaded ${dsData.length} items', name: 'KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat_V2');
    return dsData;
  } catch (e, stackTrace) {
    developer.log('Error in KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat_V2: $e',name: 'KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat_V2',error: e,stackTrace: stackTrace,);return []; 
  }
}

static Future<List<tbl_KhoBTP_TP>> KhoBTP_TP_GetIDKhuVuc_GetMaPhieu(String MaPhieu) async {
  try {
  var data = {   
 'MaPhieu' : MaPhieu,
  };
    final Data = await AuthorizeApi.Get_Data('KhoBTP_TP/KhoBTP_TP_GetIDKhuVuc_GetMaPhieu',data);
    if (Data == null) {
     developer.log('API returned null data', name: 'KhoBTP_TP_GetIDKhuVuc_GetMaPhieu');return [];
     }
    final dsData = Data.map((e) => tbl_KhoBTP_TP.fromJson(e)).toList();
    developer.log('Loaded ${dsData.length} items', name: 'KhoBTP_TP_GetIDKhuVuc_GetMaPhieu');
    return dsData;
  } catch (e, stackTrace) {
    developer.log('Error in KhoBTP_TP_GetIDKhuVuc_GetMaPhieu: $e',name: 'KhoBTP_TP_GetIDKhuVuc_GetMaPhieu',error: e,stackTrace: stackTrace,);return []; 
  }
}

static Future<List<KhoBTP_TP_TonKho>> TonKhoBTP_TP_ViTri_KhachHang_Lo() async {
  try {
    final Data = await AuthorizeApi.Post('KhoBTP_TP/TonKhoBTP_TP_ViTri_KhachHang_Lo');
    if (Data == null) {
     developer.log('API returned null data', name: 'TonKhoBTP_TP_ViTri_KhachHang_Lo');return [];
     }
    final dsData = Data.map((e) => KhoBTP_TP_TonKho.fromJson(e)).toList();
    developer.log('Loaded ${dsData.length} items', name: 'TonKhoBTP_TP_ViTri_KhachHang_Lo');
    return dsData;
  } catch (e, stackTrace) {
    developer.log('Error in TonKhoBTP_TP_ViTri_KhachHang_Lo: $e',name: 'TonKhoBTP_TP_ViTri_KhachHang_Lo',error: e,stackTrace: stackTrace,);return []; 
  }
}

static Future<List<tbl_KhoBTP_TP>> KhoBTP_TP_GetMaVatLieu_GetViTri_GetKho_GetLo(String MaSanPham, String ViTri, String Kho, String Lo) async {
  try {
  var data = {   
 'MaSanPham' : MaSanPham,
 'ViTri' : ViTri,
 'Kho' : Kho,
 'Lo' : Lo,
  };
    final Data = await AuthorizeApi.Get_Data('KhoBTP_TP/KhoBTP_TP_GetMaVatLieu_GetViTri_GetKho_GetLo',data);
    if (Data == null) {
     developer.log('API returned null data', name: 'KhoBTP_TP_GetMaVatLieu_GetViTri_GetKho_GetLo');return [];
     }
    final dsData = Data.map((e) => tbl_KhoBTP_TP.fromJson(e)).toList();
    developer.log('Loaded ${dsData.length} items', name: 'KhoBTP_TP_GetMaVatLieu_GetViTri_GetKho_GetLo');
    return dsData;
  } catch (e, stackTrace) {
    developer.log('Error in KhoBTP_TP_GetMaVatLieu_GetViTri_GetKho_GetLo: $e',name: 'KhoBTP_TP_GetMaVatLieu_GetViTri_GetKho_GetLo',error: e,stackTrace: stackTrace,);return []; 
  }
}

}
