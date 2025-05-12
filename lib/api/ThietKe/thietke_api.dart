import 'package:nkv/model/NghiepVu/tbl_danhsachsanpham.dart';
import 'package:nkv/model/ThietKe/ThongTinDanTrang_V2.dart';
import 'package:nkv/model/ThietKe/tbKhoGiayIn.dart';
import 'package:nkv/model/ThietKe/tbl_GiayLon.dart';
import '../NhanVien/authorize_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
class KhoGiayInApi {

  static Future<List<tbKhoGiayIn>> LoadData() async {
    final Data = await AuthorizeApi.Post('KhoGiayIn/LoadData');
    final dsData = Data.map((e) => tbKhoGiayIn.fromJson(e)).toList();
    return dsData;
  }
  static Future<List<tbKhoGiayIn>> KhoGiayIn_GetGiayLon(String GiayLon) async {
    final data = { 'GiayLon' : GiayLon };
    final Data = await AuthorizeApi.Post_Data('ThietKe/KhoGiayIn_GetGiayLon',data);
    final dsData = Data.map((e) => tbKhoGiayIn.fromJson(e)).toList();
    return dsData;
  }
  static Future<List<ThongTinDanTrang_V2>> TinhDanTrang(String GiayLon,String KichThuoc) async {
    KichThuoc  = '46x92';
    final data = { 'GiayLon' : GiayLon,'KichThuoc' : KichThuoc };
    final Data = await AuthorizeApi.Get_Data('ThietKe/TinhDanTrang',data);
    final dsData = Data.map((e) => ThongTinDanTrang_V2.fromJson(e)).toList();
    return dsData;
  }
  static Future<List<ThongTinDanTrang_V2>> tinhDanTrang( String json ) async {
    // Kiểm tra tham số đầu vào
    if (json.isEmpty) {
      throw Exception('GiayLon không được để trống');
    }
    // Chuẩn bị dữ liệu gửi API
    final requestData = {'json': json,};

    try {
      // Gọi API
      final responseData = await AuthorizeApi.Get_Data('ThietKe/TinhDanTrang', requestData);

      // Kiểm tra dữ liệu trả về
      if (responseData == null || responseData is! List) {
        throw Exception('Dữ liệu trả về từ API không hợp lệ');
      }

      // Ánh xạ dữ liệu sang danh sách ThongTinDanTrang_V2
      final dsData = responseData
          .map((e) => ThongTinDanTrang_V2.fromJson(e))
          .toList();
      return dsData;
    } catch (e) {
      // Xử lý lỗi
      throw Exception('Lỗi khi tính dàn trang: $e');
    }
  }
  static Future<List<tbl_DanhSachSanPham>> ExportPdf( String json,String json2 ) async {
    List<tbl_DanhSachSanPham> dsSanPham = [];
    // Kiểm tra tham số đầu vào
    if (json.isEmpty) {
      throw Exception('GiayLon không được để trống');
    }
    // Chuẩn bị dữ liệu gửi API
    final requestData = {'json': json,'json2': json2,};
    try {
      final responseData = await AuthorizeApi.Get_Data('ThietKe/ExportPdf', requestData);
      final dsData = responseData.map((e) => tbl_DanhSachSanPham.fromJson(e)).toList();
      final directory = await getDownloadsDirectory();
      if (directory == null) {
        throw Exception('Không thể truy cập thư mục Downloads');
      }
      if (responseData == null || responseData is! List) {
        throw Exception('Dữ liệu trả về từ API không hợp lệ');
      }
      for (var i = 0; i < dsData.length; i++) {
        var file = await DownloadService.downloadFile(dsData[i].url, dsData[i].name);
        var tb = tbl_DanhSachSanPham(id: i, name: dsData[i].name, url: file.path); // Lưu đường dẫn cục bộ
        dsSanPham.add(tb);
      }
      debugPrint('----------------------------------${dsSanPham.length}');
      return dsSanPham; // Trả về danh sách với url là đường dẫn cục bộ
    } catch (e) {
      // Xử lý lỗi
      throw Exception('Lỗi khi tính dàn trang: $e');
    }
  }
}

class GiayLonApi {
  static Future<List<tbl_GiayLon>> LoadData() async {
    final Data = await AuthorizeApi.Post('ThietKe/GiayLon_LoadData');
    final dsData = Data.map((e) => tbl_GiayLon.fromJson(e)).toList();
    return dsData;
  }
}
class DownloadService {
  static final _httpClient = HttpClient();
  static Future<File> downloadFile(String url, String filename) async {
    try {
      if (!await requestStoragePermission()) {
        throw Exception('Quyền truy cập bộ nhớ bị từ chối. Vui lòng cấp quyền trong cài đặt.');
      }
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Tải file thất bại: ${response.statusCode}');
      }
      final directory = await getDownloadsDirectory();
      if (directory == null) {
        throw Exception('Không thể truy cập thư mục Downloads');
      }
      String safeFilename = filename.replaceAll(RegExp(r'[^\w\d\.]'), '_');
      File file = File('${directory.path}/$safeFilename');
      if (await file.exists()) {
        safeFilename = '${safeFilename.split('.').first}_${DateTime.now().millisecondsSinceEpoch}.pdf';
        file = File('${directory.path}/$safeFilename');
      }
      await file.writeAsBytes(response.bodyBytes);
      debugPrint('File saved at: ${file.path}');
      return file;
    } catch (e, stackTrace) {
      debugPrint('Error downloading file: $e');
      debugPrint('StackTrace: $stackTrace');
      throw Exception('Không thể tải hoặc ghi file: $e');
    }
  }

}
Future<bool> requestStoragePermission() async {
  if (Platform.isAndroid) {
    // Kiểm tra phiên bản Android
    var sdkInt = await DeviceInfoPlugin().androidInfo.then((info) => info.version.sdkInt);
    if (sdkInt >= 30) { // Android 11+
      // Yêu cầu quyền MANAGE_EXTERNAL_STORAGE
      if (await Permission.manageExternalStorage.request().isGranted) {
        return true;
      } else {
        // Hiển thị thông báo hoặc mở cài đặt
        await openAppSettings();
        return false;
      }
    } else {
      // Yêu cầu quyền storage cho Android 10 trở xuống
      if (await Permission.storage.request().isGranted) {
        return true;
      } else {
        await openAppSettings();
        return false;
      }
    }
  }
  return true; // iOS hoặc các nền tảng khác
}

