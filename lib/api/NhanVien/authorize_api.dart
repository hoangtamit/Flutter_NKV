import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../model/NhanVien/tbl_nhanvien.dart';
import '../../resources/Users/finger-print.dart';
import '../../services/secure_storage.dart';
import '../../utilities/globals.dart';
import '../../utilities/url.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer' as developer;

class AuthorizeApi {
  static Future<List<dynamic>> Post(String Url) async {
    try {
      final uri = Uri.parse('${GetUrl.Api}api/v1/$Url');
      final token = await GetToken();
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.post(uri, headers: headers);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final data = body['Result']['Data'];
        return data;
      } else {
        debugPrint('Lỗi HTTP: ${response.statusCode} - ${response.body}');
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (err) {
      debugPrint('Lỗi Exception: $err');
      rethrow;
    }
  }
  static Future<List<dynamic>> Post2 (String Url) async {
    try{
      final url = Uri.parse('${GetUrl.Api}api/v1/$Url');
      final token = await GetToken();
      var header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.post(url, headers: header);
      var  body = jsonDecode(response.body);
      var Data = body['Result']['Data'];
      return Data;
    } on Exception
    catch(err){
      debugPrint('Lỗi------------------------------------- $err');
      // make it explicit that this function can throw exceptions
      rethrow;
    }
  }
  static Future<List<dynamic>> Post_Data (String url,Map<String,dynamic> data) async {
    try{
      final uri = Uri.parse('${GetUrl.Api}api/v1/$url');
      final token = await GetToken();
      var body = json.encode(data);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      // Gọi API
      final response = await http.post(uri, headers: headers, body: body);
      // Debug phản hồi
      print('API URL: $uri');
      print('API Status: ${response.statusCode}');
      print('API Body: ${response.body}');
      // Kiểm tra mã trạng thái
      if (response.statusCode != 200) {developer.log('API error: ${response.statusCode} ${response.body}', name: 'AuthorizeApi.Post_Data');return [];}
      // Giải mã JSON
      final jsonResponse = jsonDecode(response.body);
      // Kiểm tra cấu trúc JSON
      if (jsonResponse is Map<String, dynamic> && jsonResponse['Result'] is Map<String, dynamic> && jsonResponse['Result']['Data'] is List) {
        return jsonResponse['Result']['Data'] as List<dynamic>;
      }
      developer.log('Invalid API response format: $jsonResponse', name: 'AuthorizeApi.Post_Data');return [];
    }
    catch (e, stackTrace) {developer.log('Error in Post_Data: $e', name: 'AuthorizeApi.Post_Data', error: e, stackTrace: stackTrace);return [];}

  }
  static Future<List<Map<String, dynamic>>> Post_Data_Json(String url, String json) async {
    try {
      final uri = Uri.parse('${GetUrl.Api}api/v1/$url');
      final token = await GetToken();
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.post(uri, headers: headers, body: json);
      if (response.statusCode != 200) {
        throw Exception('Yêu cầu thất bại với mã trạng thái: ${response.statusCode}');
      }
      final body = jsonDecode(response.body);
      if (body['Result'] == null || body['Result']['Data'] == null) {
        throw Exception('Dữ liệu trả về không hợp lệ');
      }
      return List<Map<String, dynamic>>.from(body['Result']['Data']);
    } catch (err) {
      debugPrint('Lỗi trong Post_Data2: $err');
      rethrow;
    }
  }
  static Future<List<dynamic>> Get (String Url) async {
    try{
      final url = Uri.parse('${GetUrl.Api}api/v1/$Url');
      final token = await GetToken();
      var header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(url, headers: header);
      var  body = jsonDecode(response.body);
      var Data = body['Result']['Data'];
      return Data;
    } on Exception
    catch(err){
      debugPrint('Lỗi------------------------------------- $err');
      // make it explicit that this function can throw exceptions
      rethrow;
    }
  }
  static Future<List<dynamic>> Get_Data (String Url,Map<String,String> data) async {
    try{
      int dem = 0;
      String result = '';
      data.forEach((key, value) {
        if(dem == 0) {
          result += key + '='  + value;
        } else {
          result += '&' + key + '='  + value;
        }
        dem++;
      });
      final url = Uri.parse('${GetUrl.Api}api/v1/$Url?$result');
      final token = await GetToken();
        var header = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        };
        var Data;
      await http.get(url, headers: header).then((response) {
        if(response.statusCode == 200) {
          var body = jsonDecode(response.body);
          if(body['Result']!= null) {
            if (body['Result']['Data'] != null) {
              Data = body['Result']['Data'];
            }
          }
          else{
              debugPrint('Result-------------------------------------');
            }
        }
      }).catchError((ex){
        debugPrint('Lỗi------------------------------------- $ex');
      });
      return Data;
    }
    catch(ex){
      rethrow;
    }
  }
  static Future<bool> Get_Data2 (String Url,Map<String,String> data) async {
    try{
      int dem = 0;
      String result = '';
      data.forEach((key, value) {
        if(dem == 0) {
          result += key + '='  + value;
        } else {
          result += '&' + key + '='  + value;
        }
        dem++;
      });
      final url = Uri.parse('${GetUrl.Api}api/v1/$Url?$result');
      final token = await GetToken();
      var header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var Data;
      await http.get(url, headers: header).then((response) {
        if(response.statusCode == 200) {
          var body = jsonDecode(response.body);
          if(body['Result']!= null) {
            if (body['Result']['Data'] != null) {
              Data = body['Result']['Data'];
            }
          }
          else{
            debugPrint('Result-------------------------------------');
          }
        }
      }).catchError((ex){
        debugPrint('Lỗi------------------------------------- $ex');
      });
      return Data;
    }
    catch(ex){
      rethrow;
    }
  }
  static Future<String> Get_Data_File (String Url,Map<String,String> data) async {
    try{
      int dem = 0;
      String result = '';
      data.forEach((key, value) {
        if(dem == 0)
          result += key + '='  + value;
        else
          result += '&' + key + '='  + value;
        dem++;
      });
      final url = Uri.parse('${GetUrl.Api}api/v1/$Url?$result');
      final token = await GetToken();
      var header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(url, headers: header);
      var path = await saveFile(response);
      return path;
    } on Exception
    catch(err){
      debugPrint('Lỗi------------------------------------- $err');
      // make it explicit that this function can throw exceptions
      rethrow;
    }
  }

  static Future<String> Login(String khuvuc,String username, String password,bool remember) async {
    try {
      SecureStorage storage = SecureStorage();
      storage.deleteAll();
      final uri = Uri.parse('${GetUrl.Api}api/v1/auth/get-token');
      final IDKhuVuc;
      if (khuvuc == 'Long An') {
        IDKhuVuc = 'LAN';
      }
      else if (khuvuc == 'Bắc Ninh') {
        IDKhuVuc = 'BNH';
      }
      else {
        IDKhuVuc = 'ZJG';
      }
      var data = {
        'IDKhuVuc': IDKhuVuc,
        'TaiKhoan': username,
        'Password': password
      };
      var response = await http.post(uri, headers: {
        "content-type": "application/json",
        "accept": "application/json",
      }, body: json.encode(data));
      if (response.body.isEmpty) return false.toString();
      final body = jsonDecode(response.body);
      final Data = body['Result']['Data'];
      final NhanVien = Data['NhanVien'];
      //tbl_NhanVien nv = tbl_NhanVienFromJson(NhanVien);
      var nv = NhanVien.map((e) => tbl_NhanVien.fromJson(e)).toList();
      final nhanvienStr = jsonEncode(nv.map((e) => e.toJson()).toList());
      final message = body['Result']['Message'];
      if (Data == null) {
        return message;
      }
      final token = body['Result']['Data']['Token'];
      final tokenExp = body['Result']['Data']['TokenExp'];


      await storage.write('token', token);
      await storage.write('token_exp', tokenExp.toString());
      await storage.write('khuvuc', khuvuc);
      await storage.write('IDKhuVuc', IDKhuVuc);
      await storage.write('username', username);
      await storage.write('nhanvien', nhanvienStr);
      //await storage.write('NhanVien', nv);
      if(remember) {
        await storage.write('password', password);
      } else {
        await storage.delete('password');
      }
      await storage.write('rememberMe', remember.toString());
      await storage.write('success', 'true');
      Globals.NhanVien = nv[0];
      return true.toString();
    } catch (e) {
      debugPrint('Login exception: $e');
      return false.toString();
    }
  }
  static Future<bool> Register(String khuvuc,String MaNhanVien,String username, String password,String phone) async {
    final uri = Uri.parse('${GetUrl.Api}api/v1/auth/Register');
    final String IDKhuVuc;
    if(khuvuc == 'Long An') {
      IDKhuVuc = 'LAN';
    }
    else if(khuvuc == 'Bắc Ninh') {
      IDKhuVuc = 'BNH';
    }
    else{
      IDKhuVuc = 'ZJG';
    }
    var data = {
      'IDKhuVuc': IDKhuVuc,
      "MaNhanVien": MaNhanVien,
      'Username': username,
      'Password': password,
      'Phone': phone,
    };
    var response = await http.post(uri, headers: {
      "content-type": "application/json",
      "accept": "application/json",
    }, body: json.encode(data));

    if (response.body.isEmpty) return false;
    final body = jsonDecode(response.body);
    final Data = body['Result']['Data'];
    if (Data == null) return false;

    return true;
  }
  static Future<Map<String, dynamic>> getUserProfileData() async {
    SecureStorage storage = SecureStorage(); // Read all values
    final allValues = await storage.readAll();
    if(allValues.isEmpty) {
      var map = { 'success' : 'false' };
      return map;
    }
    return allValues;
  }
  static Future<String> GetToken() async {
    SecureStorage storage = SecureStorage(); // Read all values
    final allValues = await storage.readAll();
    String token = '';
    if(allValues.isNotEmpty)
       token = allValues['token'];
    return token;
  }
  static Future<bool> checkToken() async {
    final allValues = await getUserProfileData();
    final token = allValues['token'];
    if (token != null && token.isNotEmpty && !JwtDecoder.isExpired(token)) {
      // bool authenticated = await authenticateWithBiometrics();
      // if (authenticated) {
      final nhanvienStr = allValues['nhanvien'];
      if (nhanvienStr != null) {
        try {
          final list = jsonDecode(nhanvienStr) as List;
          final dsNhanVien = list.map((e) => tbl_NhanVien.fromJson(e)).toList();
          Globals.NhanVien = dsNhanVien[0];
        }
        catch(e){
          debugPrint('Login exception: $e');
          return false;
        }

      }
      else
        {
          return false;
        }
        return true; // Vào app nếu xác thực thành công
      // } else {
      //   return false; // Nếu xác thực thất bại
      //}
    } else {
      return false; // Không có token hoặc token hết hạn
    }
    if(token != null && token != "") {
      DateTime expiryDate = JwtDecoder.getExpirationDate(token);
      print('expiryDate $expiryDate');
      var isExpired = JwtDecoder.isExpired(token);
      return true;
    }
    if(allValues.isEmpty || allValues['success'] == 'false' ) {
      return false;
    }
    final khuvuc = allValues['khuvuc'];
    final username = allValues['username'];
    final password = allValues['password'];
    Map<String,String> data = {
      'DatabaseName': khuvuc,
      'Username': username,
      'Password': password
    };
    const String message = '';
    var ds = await Login(khuvuc,username,password,true);
    if(ds == 'true') {
      return true;
    }
    return false;
  }
  static Future<String> saveFile(http.Response response) async {
    Uint8List? bytes = Uint8List.fromList(response.bodyBytes);
    var file = File('');
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        status = await Permission.storage.request();
      }
      if (status.isGranted) {
        const downloadsFolderPath = '/storage/emulated/0/Download/';
        Directory dir = Directory(downloadsFolderPath);
        var fileName = response.headers['content-disposition'].toString().split(';')[1].split('=')[1];
        file = File('${dir.path}$fileName');
      }
      try {
        await file.writeAsBytes(bytes.buffer
            .asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
      } on FileSystemException
      catch (err) {
        if (kDebugMode) {
          print(err.toString());
        }
      }
    }
    return file.path;
  }
}


//saveFile('example.pdf');
// final pdf = pw.Document();
// pdf.addPage(pw.Page(
//     pageFormat: PdfPageFormat.a4,
//     build: (pw.Context context) {
//       return pw.Center(
//         child: pw.Text(response.bodyBytes.toString()),
//       );
//     }));
// final file = File(path);
// if (!await file.exists()) {
//   await file.create();
// }
// File? file = await downloadPDF('1234', 'xxxxxx');
// await file.writeAsBytes(response);

// List<int> data = pdf.save();
// await file.writeAsBytes(response.bodyBytes);
//
// Future<void> writeToFile(ByteData data, String path) {
//   final buffer = data.buffer;
//   return new File(path).writeAsBytes(
//       buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
// }
// writeToFile(response.bodyBytes, path);
// var httpClient = new HttpClient();
// var request = await httpClient.getUrl(Uri.parse('https://localhost:5003/api/v1/DonSanXuat/ExportPdf'));
// var response = await request.close();
//  var bytes = await consolidateHttpClientResponseBytes(response);
// String dir = (await getApplicationDocumentsDirectory()).path;
// File file = new File('$dir/$filename');
// await file.writeAsBytes(bytes);

// final taskId = await FlutterDownloader.enqueue(
//   url: 'your download link',
//   savedDir: 'the path of directory where you want to save downloaded files',
//   showNotification: true, // show download progress in status bar (for Android)
//   openFileFromNotification: true, // click on notification to open downloaded file (for Android)
// );
// final downloaderUtils = DownloaderUtils(
//   progressCallback: (current, total) {
//     final progress = (current / total) * 100;
//     print('Downloading: $progress');
//   },
//   file: File('$path_to_store_file/'),
//   progress: ProgressImplementation(),
//   onDone: () => print('Download done'),
//   deleteOnCancel: true,
// );
