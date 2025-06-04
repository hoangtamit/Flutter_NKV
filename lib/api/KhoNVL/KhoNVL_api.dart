import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../model/KhoNVL/tbKhoNVL.dart';
import '../../model/KhoNVL/tbl_Avery_GiaoHang.dart';
import '../../model/KhoNVL/tbl_ViTri.dart';
import '../../model/KhoNVL/KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap.dart';
import '../../model/KhoNVL/KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetXuat.dart';
import '../../model/KhoNVL/KhoNVL_GroupByMaPhieu_GetNhap.dart';
import '../../model/KhoNVL/KhoNVL_NhapKho_ChiTiet.dart';
import '../../model/KhoNVL/KhoNVL_TonKho.dart';
import '../../model/KhoNVL/KhoNVL_XuatKho_ChiTiet.dart';
import '../NhanVien/authorize_api.dart';
class KhoNVLApi {
  //------------------------------------Vị Trí--------------------------------------------//
  static Future<List<tbl_ViTri>> ViTri_LoadData() async {
    try{
      final Data = await AuthorizeApi.Post('KhoNVL/ViTri_LoadData');
      if (Data == null) {
        developer.log('API returned null data', name: 'ViTri_LoadData');
        return [];
      }
      // Chuyển đổi dữ liệu
      final dsData = Data.map((e) => tbl_ViTri.fromJson(e)).toList();
      developer.log('Loaded ${dsData.length} items', name: 'Avery_GiaoHang_LoadData');
      return dsData;
    } catch (e, stackTrace) {
      // Ghi log lỗi chi tiết
      developer.log(
        'Error in Avery_GiaoHang_LoadData: $e',
        name: 'Avery_GiaoHang_LoadData',
        error: e,
        stackTrace: stackTrace,
      );
      return []; // Trả về danh sách rỗng khi có lỗi
    }
  }
  //------------------------------------Avery Giao Hàng--------------------------------------------//

  static Future<List<tbl_Avery_GiaoHang>> Avery_GiaoHang_LoadData() async {
    try{
    final Data = await AuthorizeApi.Post('KhoNVL/Avery_GiaoHang_LoadData');
      if (Data == null) {
        developer.log('API returned null data', name: 'Avery_GiaoHang_LoadData');
        return [];
      }
    // Chuyển đổi dữ liệu
    final dsData = Data.map((e) => tbl_Avery_GiaoHang.fromJson(e)).toList();
    developer.log('Loaded ${dsData.length} items', name: 'Avery_GiaoHang_LoadData');
    return dsData;
    } catch (e, stackTrace) {
      // Ghi log lỗi chi tiết
      developer.log(
        'Error in Avery_GiaoHang_LoadData: $e',
        name: 'Avery_GiaoHang_LoadData',
        error: e,
        stackTrace: stackTrace,
      );
      return []; // Trả về danh sách rỗng khi có lỗi
    }
  }
  //------------------------------------Kho NVL--------------------------------------------//
  static Future<List<KhoNVL_TonKho>> TonKho_GetMaVatLieu(String MaVatLieu) async {
    final data = { 'MaVatLieu' : MaVatLieu };
    final Data = await AuthorizeApi.Get_Data('KhoNVL/TonKhoNVL_GetMaVatLieu',data);
    final dsData = Data.map((e) => KhoNVL_TonKho.fromJson(e)).toList();
    return dsData;
  }
  static Future<List<KhoNVL_TonKho>> TonKhoNVL_ViTri_GetMaVatLieu(String MaVatLieu) async {
    final data = { 'MaVatLieu' : MaVatLieu };
    final Data = await AuthorizeApi.Get_Data('KhoNVL/TonKhoNVL_ViTri_GetMaVatLieu',data);
    final dsData = Data.map((e) => KhoNVL_TonKho.fromJson(e)).toList();
    return dsData;
  }
  static Future<List<KhoNVL_TonKho>> TonKhoNVL_ViTri_GetMaVatLieu_GetViTri(String MaVatLieu,String ViTri) async {
    final data = { 'MaVatLieu' : MaVatLieu,'ViTri' : ViTri };
    final Data = await AuthorizeApi.Get_Data('KhoNVL/TonKhoNVL_ViTri_GetMaVatLieu_GetViTri',data);
    final dsData = Data.map((e) => KhoNVL_TonKho.fromJson(e)).toList();
    return dsData;
  }
  static Future<List<KhoNVL_TonKho>> TonKhoNVL_ViTri_GetMaVatLieu_GetViTri_GetKho(String MaVatLieu,String ViTri,String Kho) async {
    final data = { 'MaVatLieu' : MaVatLieu,'ViTri' : ViTri ,'Kho' : Kho};
    final Data = await AuthorizeApi.Get_Data('KhoNVL/TonKhoNVL_ViTri_GetMaVatLieu_GetViTri_GetKho',data);
    final dsData = Data.map((e) => KhoNVL_TonKho.fromJson(e)).toList();
    return dsData;
  }
  static Future<List<KhoNVL_TonKho>> TonKhoNVL_ViTri() async {
    final Data = await AuthorizeApi.Post('KhoNVL/TonKhoNVL_ViTri');
    final dsData = Data.map((e) => KhoNVL_TonKho.fromJson(e)).toList();
    return dsData;
  }
  static Future<List<KhoNVL_TonKho>> TonKhoNVL() async {
    final Data = await AuthorizeApi.Get('KhoNVL/TonKhoNVL_V2');
    final dsData = Data.map((e) => KhoNVL_TonKho.fromJson(e)).toList();
    return dsData;
  }
  static Future<List<tbKhoNVL>> KhoNVL_GetMaVatLieu(String MaVatLieu) async {
    final data = { 'MaVatLieu' : MaVatLieu };
    final Data = await AuthorizeApi.Get_Data('KhoNVL/GetMaVatLieu',data);
    //Convert json to list
    final dsData = Data.map((e) => tbKhoNVL.fromJson(e)).toList();
    return dsData;
  }
  static Future<List<tbKhoNVL>> KhoNVL_GetMaVatLieu_GetViTri_GetKho(String maVatLieu, String viTri, String kho) async {
    try {
      final json = jsonEncode({
        'maVatLieu': maVatLieu,
        'viTri': viTri,
        'kho': kho,
      });
      final data = await AuthorizeApi.Post_Data_Json('KhoNVL/GetMaVatLieu_GetViTri_GetKho', json);

      if (data == null || data.isEmpty) {
        debugPrint('Không nhận được dữ liệu từ API');
        return [];
      }
      final dsData = List<tbKhoNVL>.from(data.map((e) => tbKhoNVL.fromJson(e)));
      return dsData;
    } catch (err) {
      debugPrint('Lỗi trong KhoNVL_GetMaVatLieu_GetViTri_GetKho: $err');
      rethrow;
    }
  }
  static Future<List<KhoNVL_TonKho>> KhoNVL_KiemKe_Insert_V2(String MaKyCong,String MaVatLieu,String ViTri , String SoLuong) async {
    var data = {
      'MaKyCong' : MaKyCong,
      'MaVatLieu' : MaVatLieu,
      'ViTri' : ViTri,
      'SoLuong' : SoLuong
    };
    final Data = await AuthorizeApi.Get_Data('KhoNVL/KhoNVL_KiemKe_Insert_V2',data);
    final dsData = Data.map((e) => KhoNVL_TonKho.fromJson(e)).toList();
    return dsData;
  }
  static Future<List<KhoNVL_TonKho>> KhoNVL_DieuChinhKho(KhoNVL_TonKho tonkho) async {
    var data = tonkho.toJson();
    final Data = await AuthorizeApi.Post_Data('KhoNVL/KhoNVL_DieuChinhKho',data);
    final dsData = Data.map((e) => KhoNVL_TonKho.fromJson(e)).toList();
    return dsData;
  }
  static Future<List<KhoNVL_TonKho>> KhoNVL_ChuyenDoiMaVatLieu(KhoNVL_TonKho tonkho) async {
    var data = tonkho.toJson();
    final Data = await AuthorizeApi.Post_Data('KhoNVL/KhoNVL_ChuyenDoiMaVatLieu',data);
    final dsData = Data.map((e) => KhoNVL_TonKho.fromJson(e)).toList();
    return dsData;
  }
  static Future<List<tbKhoNVL>> KhoNVL_Insert_Json(String json) async {
    try {
      //var json = tb.toJson().toString();

      final Data = await AuthorizeApi.Post_Data_Json('KhoNVL/KhoNVL_Insert_Json',json);
      if (Data == null) {
        developer.log('API returned null data', name: 'KhoNVL_Insert_Json');
        return [];
      }
      final dsData = Data.map((e) => tbKhoNVL.fromJson(e)).toList();
      developer.log('Loaded ${dsData.length} items', name: 'KhoNVL_Insert_Json');
      return dsData;
    } catch (e, stackTrace) { developer.log('Error in KhoNVL_Insert_Json: $e', name: 'KhoNVL_Insert_Json', error: e, stackTrace: stackTrace,);
      return [];
    }
  }
  static Future<List<KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap>> KhoNVL_GroupByMaPhieu_GetNhap() async {
    try {
      final Data = await AuthorizeApi.Post('KhoNVL/KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap');
      if (Data == null) {
        developer.log('API returned null data', name: 'KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap');
        return [];
      }
      final dsData = Data.map((e) => KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap.fromJson(e)).toList();
      developer.log('Loaded ${dsData.length} items', name: 'KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap');
      return dsData;
    } catch (e, stackTrace) {
      developer.log(
        'Error in KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap: $e',
        name: 'KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap',
        error: e,
        stackTrace: stackTrace,
      );
      return [];
    }
  }
  static Future<List<KhoNVL_NhapKho_ChiTiet>> KhoNVL_GetIDKhuVuc_GetMaPhieu(String MaPhieu) async {
    try {
      var data = {
        'MaPhieu' : MaPhieu,
      };
      final Data = await AuthorizeApi.Post_Data('KhoNVL/KhoNVL_GetIDKhuVuc_GetMaPhieu',data);
      if (Data == null) {developer.log('API returned null data', name: '{txtName.Text.Trim()}');return [];}
      final dsData = Data.map((e) => KhoNVL_NhapKho_ChiTiet.fromJson(e)).toList();
      developer.log('Loaded ${dsData.length} items', name: 'KhoNVL_GetIDKhuVuc_GetMaPhieu');
      return dsData;
    } catch (e, stackTrace) {
      developer.log('Error in {txtName.Text.Trim()}: $e',name: '{txtName.Text.Trim()}',error: e,stackTrace: stackTrace,);return [];
    }
  }

static Future<List<KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetXuat>> KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetXuat_V2() async {
  try {
    final Data = await AuthorizeApi.Post('KhoNVL/KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetXuat_V2');
    if (Data == null) {
     developer.log('API returned null data', name: 'KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetXuat_V2');return [];
     }
    final dsData = Data.map((e) => KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetXuat.fromJson(e)).toList();
    developer.log('Loaded ${dsData.length} items', name: 'KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetXuat_V2');
    return dsData;
  } catch (e, stackTrace) {
    developer.log('Error in KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetXuat_V2: $e',name: 'KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetXuat_V2',error: e,stackTrace: stackTrace,);return []; 
  }
}

static Future<List<KhoNVL_XuatKho_ChiTiet>> KhoNVL_XuatKho_ChiTiet_V2(String MaPhieu) async {
  try {
  var data = {   
  'MaPhieu' : MaPhieu,
  };
    final Data = await AuthorizeApi.Get_Data('KhoNVL/KhoNVL_XuatKho_ChiTiet',data);
    if (Data == null) {
     developer.log('API returned null data', name: 'KhoNVL_XuatKho_ChiTiet');return [];
     }
    final dsData = Data.map((e) => KhoNVL_XuatKho_ChiTiet.fromJson(e)).toList();
    developer.log('Loaded ${dsData.length} items', name: 'KhoNVL_XuatKho_ChiTiet');
    return dsData;
  } catch (e, stackTrace) {
    developer.log('Error in KhoNVL_XuatKho_ChiTiet: $e',name: 'KhoNVL_XuatKho_ChiTiet',error: e,stackTrace: stackTrace,);return [];
  }
}

}
