import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:qlsx/resources/Main/barcode-page.dart';
import 'package:qlsx/resources/Users/finger-print.dart';
import 'package:qlsx/resources/Users/login_page.dart';
import 'package:qlsx/resources/app.dart';
import 'package:qlsx/resources/home.dart';
import 'package:qlsx/services/secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'api/NhanVien/authorize_api.dart';
//final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
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
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) async => runApp (MyApp(await pageFirst())));
  //]).then((_) => runApp(MyApp()));
}

Future <Widget> pageFirst() async {
  var result = await AuthorizeApi.checkToken();
  if(result) {
    // Thêm navigatorObservers vào MaterialApp

    return const qlsxHomePage();
  } else {
    return LoginPage();
  }
}
