import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:nkv/resources/Users/finger-print.dart';
import 'package:nkv/resources/Users/login_page.dart';
import 'package:nkv/resources/app.dart';
import 'package:nkv/resources/home.dart';
import 'package:nkv/services/secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'api/NhanVien/authorize_api.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() async {
  //HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) async => runApp (MyApp (await pageFirst())));
  //]).then((_) => runApp(MyApp()));
}

Future <Widget> pageFirst() async {
  // SecureStorage storage = SecureStorage(); // Read all values
  // final allValues = await storage.readAll();
  // final token = allValues['token'];
  // if (token != null && token.isNotEmpty && !JwtDecoder.isExpired(token)) {
  //   bool authenticated = await authenticateWithBiometrics();
  //   if (authenticated) {
  //     return NKVHomePage(); // Vào app nếu xác thực thành công
  //   } else {
  //     return LoginPage(); // Nếu xác thực thất bại
  //   }
  // } else {
  //   return LoginPage(); // Không có token hoặc token hết hạn
  // }
  var result = await AuthorizeApi.checkToken();
  if(result) {
    return const NKVHomePage();
  } else {
    return LoginPage();
  }
  return await AuthorizeApi.checkToken() ?  const NKVHomePage(): LoginPage();
}
