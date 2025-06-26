import '../../model/ThietKe/tbKhoGiayIn.dart';
import '../NhanVien/authorize_api.dart';

class KhoGiayInApi {
  static Future<List<tbKhoGiayIn>> LoadData() async {
    final Data = await AuthorizeApi.Post('ThietKe/KhoGiayIn_LoadData');
    final dsData = Data.map((e) => tbKhoGiayIn.fromJson(e)).toList();
    print('-------------$dsData');
    return dsData;
  }
}

