import 'package:nkv/model/ThietKe/tbKhoGiayIn.dart';
import '../NhanVien/authorize_api.dart';

class KhoGiayInApi {
  static Future<List<tbKhoGiayIn>> LoadData() async {
    final Data = await AuthorizeApi.Post('KhoGiayIn/LoadData');
    final dsData = Data.map((e) => tbKhoGiayIn.fromJson(e)).toList();
    return dsData;
  }
}

