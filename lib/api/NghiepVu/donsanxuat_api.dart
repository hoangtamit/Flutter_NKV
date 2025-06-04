import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../../model/NghiepVu/donsanxuat_quanlydonhang.dart';
import '../../model/NghiepVu/tbdonsanxuat.dart';
import '../../model/NghiepVu/tbl_danhsachsanpham.dart';
import '../NhanVien/authorize_api.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DonSanXuatApi {

  static Future<List<tbDonSanXuat>> LoadData() async {
    final Data = await AuthorizeApi.Post('DonSanXuat/LoadData');
    final dsData = Data.map((e) => tbDonSanXuat.fromJson(e)).toList();
    return dsData;
  }
  static Future<List<tbl_DanhSachSanPham>> DanhSachSanPham() async {
    final Data = await AuthorizeApi.Get('DonSanXuat/DanhSachSanPham');
    final dsData = Data.map((e) => tbl_DanhSachSanPham.fromJson(e)).toList();
    return dsData;
  }
  static Future<List<tbl_DanhSachSanPham>> DanhSachSanPham_Pdf(String tensanpham) async {
    final data = { 'TenSanPham' : tensanpham };
    final Data = await AuthorizeApi.Get_Data('DonSanXuat/DanhSachSanPham_Pdf',data);
    final dsData = Data.map((e) => tbl_DanhSachSanPham.fromJson(e)).toList();
    return dsData;
  }
  static Future<List<tbDonSanXuat>> DonSanXuat_LoadData_Json() async {
    final String body = await rootBundle.loadString('assets/json/donsanxuat_loaddata.json');
    final json = await jsonDecode(body);
    final results = json['Result'] as List<dynamic>;
    final dsData = results.map((e) => tbDonSanXuat.fromJson(e)).toList();
    return dsData;
  }
  static Future<List<tbDonSanXuat>> DonSanXuat_GetSCD(String SCD) async {
    try {
      var data = {
        'SCD' : SCD,
      };
      final Data = await AuthorizeApi.Get_Data('DonSanXuat/GetSCD',data);
      if (Data == null) {
        developer.log('API returned null data', name: 'GetSCD');return [];
      }
      final dsData = Data.map((e) => tbDonSanXuat.fromJson(e)).toList();
      developer.log('Loaded ${dsData.length} items', name: 'DonSanXuat_GetSCD');
      return dsData;
    } catch (e, stackTrace) {
      developer.log('Error in DonSanXuat_GetSCD: $e',name: 'DonSanXuat_GetSCD',error: e,stackTrace: stackTrace,);return [];
    }
  }
  static Future<List<DonSanXuat_QuanLyDonHang>> DonSanXuat_QuanLyDonhang_GetSCD(String scd) async {
    final data = { 'SCD' : scd };
    final Data  = await AuthorizeApi.Get_Data('DonSanXuat/GetIDQuanLyDonHang', data);
    final dsData = Data.map((e) => DonSanXuat_QuanLyDonHang.fromJson(e)).toList();
    debugPrint('-----------------------dsData :$dsData');
    return dsData;
  }
  static Future<List<DonSanXuat_QuanLyDonHang>> QuanLyDonhang_XacNhan(String scd) async {
    // final url = 'https://api.nkv.com.vn/api/v1/QuanLyDonHang/XacNhan?SCD=$scd';
    try {
      final data = { 'SCD': scd,'BoPhan' : "ThietKeNhan",'XacNhan':'admin_2023-10-30'};
      final Data = await AuthorizeApi.Get_Data('DonSanXuat/GetIDQuanLyDonHang', data);
      final dsData = Data.map((e) => DonSanXuat_QuanLyDonHang.fromJson(e))
          .toList();
      return dsData;
    }
    catch(ex){ rethrow;}
  }
  static Future<List<tbl_DanhSachSanPham>> OpenPdf(String SCD) async {
    List<tbl_DanhSachSanPham> dsSanPham = [];
    final data = {'SCD': SCD};
    final Data = await AuthorizeApi.Post_Data('DonSanXuat/ExportPdf', data);
    final dsData = Data.map((e) => tbl_DanhSachSanPham.fromJson(e)).toList();
    debugPrint('----------------------------------${dsData.length}');
    return dsData; // Trả về danh sách với url là đường dẫn cục bộ
  }
  static Future<List<tbl_DanhSachSanPham>> DownloadPdf(String SCD) async {
    List<tbl_DanhSachSanPham> dsSanPham = [];
    final data = {'SCD': SCD};
    final Data = await AuthorizeApi.Post_Data('DonSanXuat/ExportPdf', data);
    final dsData = Data.map((e) => tbl_DanhSachSanPham.fromJson(e)).toList();
    if(Platform.isAndroid || Platform.isIOS) {
      final directory = await getDownloadsDirectory();
      if (directory == null) {
        throw Exception('Không thể truy cập thư mục Downloads');
      }
    }
    for (var i = 0; i < dsData.length; i++) {
      var file = await DownloadService.downloadFile(dsData[i].url, dsData[i].name);
      var tb = tbl_DanhSachSanPham(id: i, name: dsData[i].name, url: file.path); // Lưu đường dẫn cục bộ
      dsSanPham.add(tb);
    }
    debugPrint('----------------------------------${dsData.length}');
    return dsData; // Trả về danh sách với url là đường dẫn cục bộ
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

  static Future<List<tbl_DanhSachSanPham>> Getdssp(String tensanpham) async {
    List<tbl_DanhSachSanPham> dsSanPham = [];
    var value =  await DonSanXuatApi.DanhSachSanPham_Pdf(tensanpham);
    for(var i = 0 ; i < value.length;i++) {
      var file = await DownloadService.downloadFile(value[i].url,'${value[i].name}.pdf');
      var tb = tbl_DanhSachSanPham(id: i, name: value[i].name, url: file.path);
      dsSanPham.add(tb);
    }
    debugPrint('----------------------------------${dsSanPham.length}');
    return value;
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