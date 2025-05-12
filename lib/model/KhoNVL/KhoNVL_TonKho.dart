// To parse this JSON data, do
//
//     final KhoNVL_TonKho = KhoNVL_TonKhoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

KhoNVL_TonKho KhoNVL_TonKhoFromJson(String str) => KhoNVL_TonKho.fromJson(json.decode(str));

String KhoNVL_TonKhoToJson(KhoNVL_TonKho data) => json.encode(data.toJson());

class KhoNVL_TonKho {
  dynamic kho;
  String maVatLieu;
  dynamic loaiHang;
  //dynamic maAvery;
  dynamic tenHangHoa;
  dynamic donViTinh;
  dynamic quyCach;
  dynamic viTri;
  //dynamic lo;
  //int dinhMucToiThieu;
  //int dinhMucToiDa;
  double? tondauky;
  double? tongnhap;
  double? tongxuat;
  double? toncuoiky;
  double? soLuongKiemKe;
  dynamic maVatLieuChuyenDoi;
  //int soLuongTinhLieu;
  //int tonKhoThucTe;
  dynamic maKyCong;
  bool isKiemKe;
  dynamic idKhuVuc;

  KhoNVL_TonKho({
    required this.kho,
    required this.maVatLieu,
    required this.loaiHang,
    //required this.maAvery,
    required this.tenHangHoa,
    required this.donViTinh,
    required this.quyCach,
    required this.viTri,
    //required this.lo,
    //required this.dinhMucToiThieu,
    //required this.dinhMucToiDa,
    required this.tondauky,
    required this.tongnhap,
    required this.tongxuat,
    required this.toncuoiky,
    required this.soLuongKiemKe,
    //required this.soLuongTinhLieu,
    //required this.tonKhoThucTe,
    required this.idKhuVuc,
    required this.maKyCong,
    required this.isKiemKe,
    required this.maVatLieuChuyenDoi,
  });

  factory KhoNVL_TonKho.fromJson(Map<String, dynamic> json) => KhoNVL_TonKho(
    kho: json["Kho"],
    maVatLieu: json["MaVatLieu"],
    loaiHang: json["LoaiHang"],
    //maAvery: json["maAvery"],
    tenHangHoa: json["TenHangHoa"],
    donViTinh: json["DonViTinh"],
    quyCach: json["QuyCach"],
    viTri: json["ViTri"],
    //lo: json["lo"],
    //dinhMucToiThieu: json["dinhMucToiThieu"],
    //dinhMucToiDa: json["dinhMucToiDa"],
    tondauky: json["tondauky"],
    tongnhap: json["tongnhap"],
    tongxuat: json["tongxuat"],
    toncuoiky: json["toncuoiky"],
    soLuongKiemKe: json["SoLuongKiemKe"],
    //soLuongTinhLieu: json["soLuongTinhLieu"],
    //tonKhoThucTe: json["tonKhoThucTe"],
    idKhuVuc: json["idKhuVuc"],
    maKyCong: json["MaKyCong"],
    isKiemKe: json["isKiemKe"],
    maVatLieuChuyenDoi: json["MaVatLieuChuyenDoi"],
  );

  Map<String, dynamic> toJson() => {
    "Kho": kho,
    "MaVatLieu": maVatLieu,
    "LoaiHang": loaiHang,
    //"maAvery": maAvery,
    "TenHangHoa": tenHangHoa,
    "DonViTinh": donViTinh,
    "QuyCach": quyCach,
    "ViTri": viTri,
    //"lo": lo,
    //"dinhMucToiThieu": dinhMucToiThieu,
    //"dinhMucToiDa": dinhMucToiDa,
    "tondauky": tondauky,
    "tongnhap": tongnhap,
    "tongxuat": tongxuat,
    "toncuoiky": toncuoiky,
    "SoLuongKiemKe": soLuongKiemKe,
    //"soLuongTinhLieu": soLuongTinhLieu,
    //"tonKhoThucTe": tonKhoThucTe,
    "IDKhuVuc": idKhuVuc,
    "MaKyCong": maKyCong,
    "isKiemKe": isKiemKe,
    "MaVatLieuChuyenDoi": maVatLieuChuyenDoi,
  };
}
