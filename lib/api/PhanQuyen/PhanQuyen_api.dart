import 'dart:developer' as developer;
import '../../model/PhanQuyen/tbl_PhanQuyen_V2.dart';
import '../NhanVien/authorize_api.dart';
class PhanQuyenApi{

static Future<List<tbl_PhanQuyen_V2>> PhanQuyen_V2_GetMaNhanVien_GetID_V2(String MaNhanVien, String ID) async {
  try {
  var data = {   
 'MaNhanVien' : MaNhanVien,
 'ID' : ID,
  };
    final Data = await AuthorizeApi.Get_Data('PhanQuyen/PhanQuyen_V2_GetMaNhanVien_GetID_V2',data);
    if (Data == null) {
     developer.log('API returned null data', name: 'PhanQuyen_V2_GetMaNhanVien_GetID_V2');return [];
     }
    final dsData = Data.map((e) => tbl_PhanQuyen_V2.fromJson(e)).toList();
    developer.log('Loaded ${dsData.length} items', name: 'PhanQuyen_V2_GetMaNhanVien_GetID_V2');
    return dsData;
  } catch (e, stackTrace) {
    developer.log('Error in PhanQuyen_V2_GetMaNhanVien_GetID_V2: $e',name: 'PhanQuyen_V2_GetMaNhanVien_GetID_V2',error: e,stackTrace: stackTrace,);return []; 
  }
}

}
