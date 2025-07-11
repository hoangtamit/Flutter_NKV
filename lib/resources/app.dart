import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../api/NhanVien/authorize_api.dart';
import '../main.dart';
import '../utilities/app_theme.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  final Widget startPage;
  MyApp (this.startPage, {super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: !kIsWeb && Platform.isAndroid ? Brightness.light : Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Quản Lý Sản Xuất',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'arial',//''timesbd',
        primarySwatch: Colors.blue,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('vi', 'VN'), // Hỗ trợ tiếng Việt
      //   Locale('en', 'US'), // Hỗ trợ tiếng Anh (tùy chọn)
      // ],
      //navigatorObservers: [routeObserver],
      home: startPage,
      //initialRoute: startPage,
      //home: NKVHomePage(),
    );
  }
}

