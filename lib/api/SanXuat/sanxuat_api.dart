import 'dart:convert';
import 'dart:developer' as developer;
import '../../model/SanXuat/tbl_BaoCaoSanXuat_V2.dart';

import '../../model/SanXuat/BaoCaoSanXuat_GetSCD_GetCongDoan.dart';
import '../NhanVien/authorize_api.dart';

class SanXuatApi {
  // static Future<List<BaoCaoSanXuat_GetSCD_GetCongDoan>> BaoCaoSanXuat_GetSCD_GetCongDoan2(String SCD, String CongDoan) async {
  //   try {
  //     var data = {
  //       'SCD': SCD,
  //       'CongDoan': CongDoan,
  //     };
  //     final Data = await AuthorizeApi.Get_Data('SanXuat/BaoCaoSanXuat_GetSCD_GetCongDoan', data);
  //     if (Data == null) {
  //       developer.log('API returned null data', name: 'BaoCaoSanXuat_GetSCD_GetCongDoan');
  //       return [];
  //     }
  //     final dsData = Data.map((e) => BaoCaoSanXuat_GetSCD_GetCongDoan.fromJson(e)).toList();
  //     developer.log('Loaded ${dsData.length} items', name: 'BaoCaoSanXuat_GetSCD_GetCongDoan');
  //     return dsData;
  //   } catch (e, stackTrace) {
  //     developer.log('Error in BaoCaoSanXuat_GetSCD_GetCongDoan: $e', name: 'BaoCaoSanXuat_GetSCD_GetCongDoan', error: e, stackTrace: stackTrace,);
  //     return [];
  //   }
  // }
  static Future<List<tbl_BaoCaoSanXuat_V2>> BaoCaoSanXuat_V2_GetSCD_GetCongDoan(String SCD, String CongDoan) async {
    try {
      var data = {
        'SCD': SCD,
        'CongDoan': CongDoan,
      };
      final Data = await AuthorizeApi.Get_Data('SanXuat/BaoCaoSanXuat_V2_GetSCD_GetCongDoan', data);
      if (Data == null) {
        developer.log('API returned null data', name: 'BaoCaoSanXuat_V2_GetSCD_GetCongDoan');
        return [];
      }
      final dsData = Data.map((e) => tbl_BaoCaoSanXuat_V2.fromJson(e)).toList();
      developer.log('Loaded ${dsData.length} items', name: 'BaoCaoSanXuat_V2_GetSCD_GetCongDoan');
      return dsData;
    } catch (e, stackTrace) {
      developer.log('Error in BaoCaoSanXuat_V2_GetSCD_GetCongDoan: $e', name: 'BaoCaoSanXuat_V2_GetSCD_GetCongDoan', error: e, stackTrace: stackTrace,);
      return [];
    }
  }
  static Future<List<tbl_BaoCaoSanXuat_V2>> BaoCaoSanXuat_V2_GetSCD_GetCongDoan_GroupBy(String SCD, String CongDoan) async {
    try {
      var data = {
        'SCD': SCD,
        'CongDoan': CongDoan,
      };
      final Data = await AuthorizeApi.Get_Data('SanXuat/BaoCaoSanXuat_V2_GetSCD_GetCongDoan_GroupBy', data);
      if (Data == null) {
        developer.log('API returned null data', name: 'BaoCaoSanXuat_V2_GetSCD_GetCongDoan_GroupBy');
        return [];
      }
      final dsData = Data.map((e) => tbl_BaoCaoSanXuat_V2.fromJson(e)).toList();
      developer.log('Loaded ${dsData.length} items', name: 'BaoCaoSanXuat_V2_GetSCD_GetCongDoan_GroupBy');
      return dsData;
    } catch (e, stackTrace) {
      developer.log('Error in BaoCaoSanXuat_V2_GetSCD_GetCongDoan_GroupBy: $e', name: 'BaoCaoSanXuat_V2_GetSCD_GetCongDoan_GroupBy', error: e, stackTrace: stackTrace,);
      return [];
    }
  }
  static Future<List<tbl_BaoCaoSanXuat_V2>> BaoCaoSanXuat_V2_GetIDBaoCaoSanXuat(tbl_BaoCaoSanXuat_V2 tb) async {
    try {
      final jsons = json.encode(tb.toJson());
      final Data = await AuthorizeApi.Post_Data_Json('SanXuat/BaoCaoSanXuat_V2_GetIDBaoCaoSanXuat', jsons);
      if (Data == null) {
        developer.log('API returned null data', name: 'BaoCaoSanXuat_V2_GetIDBaoCaoSanXuat');
        return [];
      }
      final dsData = Data.map((e) => tbl_BaoCaoSanXuat_V2.fromJson(e)).toList();
      developer.log('Loaded ${dsData.length} items', name: 'BaoCaoSanXuat_V2_GetIDBaoCaoSanXuat');
      return dsData;
    } catch (e, stackTrace) {
      developer.log('Error in BaoCaoSanXuat_V2_GetIDBaoCaoSanXuat: $e', name: 'BaoCaoSanXuat_V2_GetIDBaoCaoSanXuat', error: e, stackTrace: stackTrace,);
      return [];
    }
  }
  static Future<bool> BaoCaoSanXuat_V2_Insert_Json(String json) async {
    try {
      final Data = await AuthorizeApi.Post_Data_Json('SanXuat/BaoCaoSanXuat_V2_Insert_Json',json);
      if (Data == null) {
        developer.log('API returned null data', name: 'BaoCaoSanXuat_V2_Insert_Json');return false;
      }
      final dsData = Data.map((e) => tbl_BaoCaoSanXuat_V2.fromJson(e)).toList();
      developer.log('Loaded ${dsData.length} items', name: 'BaoCaoSanXuat_V2_Insert_Json');
      return true;
    } catch (e, stackTrace) {
      developer.log('Error in BaoCaoSanXuat_V2_Insert_Json: $e',name: 'BaoCaoSanXuat_V2_Insert_Json',error: e,stackTrace: stackTrace,);return false;
    }
  }

}
