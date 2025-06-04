import 'package:nkv/api/PhanQuyen/PhanQuyen_api.dart';
import '../api/PhanQuyen/PhanQuyen_api.dart';
import '../utilities/globals.dart';

class Permission{
  static Future<bool> isPermission(String Name) async {
    try {
      var PhanQuyen = await PhanQuyenApi.PhanQuyen_V2_GetMaNhanVien_GetID_V2(Globals.NhanVien.maNhanVien,Name);
      if(PhanQuyen.isNotEmpty) {
          for(var item in PhanQuyen) {
            if(item.View == true) {
              return true;
            }
          }
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

}