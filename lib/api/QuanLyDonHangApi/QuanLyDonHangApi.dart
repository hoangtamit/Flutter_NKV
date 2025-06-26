import 'dart:convert';
import 'dart:developer' as developer;

import '../../model/QuanLyDonHang/CheckData_NghiepVuNotNull_HoanThanhNull.dart';
import '../../model/QuanLyDonHang/QuanLyDonHang_HoanThanhNull_Unpivoted.dart';
import '../../utilities/loading_dialog.dart';
import '../NhanVien/authorize_api.dart';

class QuanLyDonHangApi{
  static Future<List<QuanLyDonHang_HoanThanhNull_Unpivoted>> QuanLyDonHang_XacNhan(QuanLyDonHang_HoanThanhNull_Unpivoted tb) async {
    try {
  var encode = tb.toJson();
  var json = jsonEncode(encode);
  final Data = await AuthorizeApi.Post_Data_Json('QuanLyDonHang/QuanLyDonHang_XacNhan',json);
  if (Data == null) {
  developer.log('API returned null data', name: 'QuanLyDonHang_XacNhan');return [];
  }
  final dsData = Data.map((e) => QuanLyDonHang_HoanThanhNull_Unpivoted.fromJson(e)).toList();
  developer.log('Loaded ${dsData.length} items', name: 'QuanLyDonHang_XacNhan');
  return dsData;
  } catch (e, stackTrace) {
      developer.log('Error in QuanLyDonHang_XacNhan: $e', name: 'QuanLyDonHang_XacNhan', error: e, stackTrace: stackTrace,);
      return [];
    }
}
  static Future<List<QuanLyDonHang_HoanThanhNull_Unpivoted>> QuanLyDonHang_HoanThanhNull_Unpivoted_GetCongDoan() async {
    try {
      final Data = await AuthorizeApi.Get('QuanLyDonHang/QuanLyDonHang_HoanThanhNull_Unpivoted_GetCongDoan');
      if (Data == null) {
        developer.log('API returned null data', name: 'QuanLyDonHang_HoanThanhNull_Unpivoted_GetCongDoan');return [];
      }
      final dsData = Data.map((e) => QuanLyDonHang_HoanThanhNull_Unpivoted.fromJson(e)).toList();
      developer.log('Loaded ${dsData.length} items', name: 'QuanLyDonHang_HoanThanhNull_Unpivoted_GetCongDoan');
      return dsData;
    } catch (e, stackTrace) {
      developer.log('Error in QuanLyDonHang_HoanThanhNull_Unpivoted_GetCongDoan: $e',name: 'QuanLyDonHang_HoanThanhNull_Unpivoted_GetCongDoan',error: e,stackTrace: stackTrace,);return [];
    }
  }
  static Future<List<CheckData_NghiepVuNotNull_HoanThanhNull>> CheckData() async {
    try {
      final Data = await AuthorizeApi.Get('QuanLyDonHang/CheckData');
      if (Data == null) {
        developer.log('API returned null data', name: 'CheckData');return [];
      }
      final dsData = Data.map((e) => CheckData_NghiepVuNotNull_HoanThanhNull.fromJson(e)).toList();
      developer.log('Loaded ${dsData.length} items', name: 'CheckData');
      return dsData;
    } catch (e, stackTrace) {
      developer.log('Error in CheckData: $e',name: 'CheckData',error: e,stackTrace: stackTrace,);return [];
    }
  }

}