import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../model/NhanVien/tbl_nhanvien.dart';
import 'authorize_api.dart';

class NhanVienApi {
  static Future<tbl_NhanVien?> GetNhanVien(String TaiKhoan, String MatKhau) async {
    var data = {
      'TaiKhoan': TaiKhoan,
      'MatKhau': MatKhau
    };
    // await AuthorizeApi.Post_Data('NhanVien/GetData2', data).then((value) {
    //   var dsData = value.map((job) => tbl_NhanVien.fromJson(job)).single;
    //   return dsData;
    // }).catchError((onError){
    //   return null;
    // });

    var json = await AuthorizeApi.Post_Data('NhanVien/GetData2', data);
    if(json.isEmpty){
      return null;
    }
    var dsData = json.map((job) => tbl_NhanVien.fromJson(job)).single;
    return dsData;
  }

  static Future<void> AllLoadData() async {
    var json = await AuthorizeApi.Post('NhanVien/LoadData');
    var ds = json.map((job) => tbl_NhanVien.fromJson(job)).toList();
  }
}


