import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

Userxn UserxnFromJson(String str) => Userxn.fromJson(json.decode(str));
String UserxnToJson(Userxn data) => json.encode(data.toJson());

class Userxn {
  final int? stt ;
  final String SCD;
  final String KhachHang;
  final String TenSanPham;
  final int SoLuong;
  final String NgayGiaoHang;
  final bool isxacNhan;
  final bool ishoanThanh;
  Userxn({
    this.stt,
    required this.SCD,
    required this.KhachHang,
    required this.TenSanPham,
    required this.SoLuong,
    required this.NgayGiaoHang,
    required this.isxacNhan,
    required this.ishoanThanh,
  });

  factory Userxn.fromJson(Map<String, dynamic> json) => Userxn(
    stt: json["stt"],
    SCD: json["SCD"],
    KhachHang: json["KhachHang"],
    TenSanPham: json["TenSanPham"],
    SoLuong: json["SoLuong"],
    NgayGiaoHang: json["NgayGiaoHang"],
    isxacNhan: json["isxacNhan"],
    ishoanThanh: json["ishoanThanh"],
  );
  Map<String, dynamic> toJson() => {
    "SCD": SCD,
    "KhachHang": KhachHang,
    "TenSanPham": TenSanPham,
    "SoLuong": SoLuong,
  };
  static Future<List<Userxn>> Userxn_Api() async {
    List<Userxn> dsUserxn = [];
    return dsUserxn;
  }

  static List<Userxn> Userxn_Api2() {
    List<Userxn> dsUserxn = [];
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    Userxn user = Userxn(stt:0,SCD: 'LAN-000000-0000', KhachHang:  'Demo', TenSanPham: '', SoLuong: 100,NgayGiaoHang:formattedDate,isxacNhan: true,ishoanThanh:true);
    dsUserxn.add(user);
    return dsUserxn;
  }
}


