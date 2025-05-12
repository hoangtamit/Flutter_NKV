// To parse this JSON data, do
//
//     final tbDonSanXuat = tbDonSanXuatFromJson(jsonString);

import 'dart:convert';

tbDonSanXuat tbDonSanXuatFromJson(String str) => tbDonSanXuat.fromJson(json.decode(str));

String tbDonSanXuatToJson(tbDonSanXuat data) => json.encode(data.toJson());

class tbDonSanXuat {
  final String scd;
  final String? maDonHang;
  final String? phienBan;
  final String? tenKhachHang;
  final String? tenSanPham;
  final String? kichThuoc;
  final String? boPhan;
  final DateTime? ngayXuongDon;
  final String? ngayGiaoHang;
  final int? soLuong;
  // final String loaiSanPham;
  // final String vatLieu;
  // final String vatLieu2;
  // final String vatLieu3;
  // final dynamic hinhMatPhai;
  // final dynamic hinhMatTrai;
  // final String mauMatPhai;
  // final String mauMatTrai;
  // final String phuongPhapIn;
  // final String giaCongMatPhai;
  // final String giaCongMatTrai;
  // final String phuongPhapCat;
  // final String boGoc;
  // final String ducLo;
  // final String nhanVienNghiepVu;
  // final String chuY;
  // final String chamCatDapHop;
  // final String khac;
  // final String loaiChi;
  // final dynamic doDai;
  // final String giaCongSau;
  // final String giaCongSauInMatTrai;
  // final String kho;
  // final dynamic inChuMaVach;
  // final dynamic hinhKhuon;
  // final DateTime thoiGianXuongDon;
  // final String chinhSua;
  // final int sku;
  // final dynamic stt;
  // final String congDoanSanXuat;
  // final String congDoanKiemPham;
  // final dynamic khuVuc;
  // final dynamic dongBoDuLieu;
  // final dynamic waterMark;
  // final String idKhuVuc;

  tbDonSanXuat({
    required this.scd,
    this.maDonHang,
    this.phienBan,
    this.tenKhachHang,
    this.tenSanPham,
    this.kichThuoc,
    this.boPhan,
    this.ngayXuongDon,
    this.ngayGiaoHang,
    this.soLuong,
    // this.loaiSanPham,
    // this.vatLieu,
    // this.vatLieu2,
    // this.vatLieu3,
    // this.hinhMatPhai,
    // this.hinhMatTrai,
    // this.mauMatPhai,
    // this.mauMatTrai,
    // this.phuongPhapIn,
    // this.giaCongMatPhai,
    // this.giaCongMatTrai,
    // this.phuongPhapCat,
    // this.boGoc,
    // this.ducLo,
    // this.nhanVienNghiepVu,
    // this.chuY,
    // this.chamCatDapHop,
    // this.khac,
    // this.loaiChi,
    // this.doDai,
    // this.giaCongSau,
    // this.giaCongSauInMatTrai,
    // this.kho,
    // this.inChuMaVach,
    // this.hinhKhuon,
    // this.thoiGianXuongDon,
    // this.chinhSua,
    // this.sku,
    // this.stt,
    // this.congDoanSanXuat,
    // this.congDoanKiemPham,
    // this.khuVuc,
    // this.dongBoDuLieu,
    // this.waterMark,
    // this.idKhuVuc,
  });

  factory tbDonSanXuat.fromJson(Map<String, dynamic> json) => tbDonSanXuat(
    scd: json["SCD"],
    maDonHang: json["MaDonHang"],
    phienBan: json["PhienBan"],
    tenKhachHang: json["TenKhachHang"],
    tenSanPham: json["TenSanPham"],
    kichThuoc: json["KichThuoc"],
    boPhan: json["BoPhan"],
    // ngayXuongDon: json["NgayXuongDon"],
    ngayGiaoHang: json["NgayGiaoHang"],
    soLuong: json["SoLuong"],
    // loaiSanPham: json["LoaiSanPham"],
    // vatLieu: json["VatLieu"],
    // vatLieu2: json["VatLieu2"],
    // vatLieu3: json["VatLieu3"],
    // hinhMatPhai: json["HinhMatPhai"],
    // hinhMatTrai: json["HinhMatTrai"],
    // mauMatPhai: json["MauMatPhai"],
    // mauMatTrai: json["MauMatTrai"],
    // phuongPhapIn: json["PhuongPhapIn"],
    // giaCongMatPhai: json["GiaCongMatPhai"],
    // giaCongMatTrai: json["GiaCongMatTrai"],
    // phuongPhapCat: json["PhuongPhapCat"],
    // boGoc: json["BoGoc"],
    // ducLo: json["DucLo"],
    // nhanVienNghiepVu: json["NhanVienNghiepVu"],
    // chuY: json["ChuY"],
    // chamCatDapHop: json["ChamCatDapHop"],
    // khac: json["Khac"],
    // loaiChi: json["LoaiChi"],
    // doDai: json["DoDai"],
    // giaCongSau: json["GiaCongSau"],
    // giaCongSauInMatTrai: json["GiaCongSauInMatTrai"],
    // kho: json["Kho"],
    // inChuMaVach: json["InChu_MaVach"],
    // hinhKhuon: json["HinhKhuon"],
    // thoiGianXuongDon: DateTime.parse(json["ThoiGianXuongDon"]),
    // chinhSua: json["ChinhSua"],
    // sku: json["SKU"],
    // stt: json["STT"],
    // congDoanSanXuat: json["CongDoanSanXuat"],
    // congDoanKiemPham: json["CongDoanKiemPham"],
    // khuVuc: json["KhuVuc"],
    // dongBoDuLieu: json["DongBoDuLieu"],
    // waterMark: json["WaterMark"],
    // idKhuVuc: json["IDKhuVuc"],
  );

  Map<String, dynamic> toJson() => {
    "SCD": scd,
    "MaDonHang": maDonHang,
    "PhienBan": phienBan,
    "TenKhachHang": tenKhachHang,
    "TenSanPham": tenSanPham,
    "KichThuoc": kichThuoc,
    "BoPhan": boPhan,
    // "NgayXuongDon": DateTime.parse(ngayXuongDon as String).toIso8601String(),
    "NgayGiaoHang": DateTime.parse(ngayGiaoHang as String).toIso8601String(),
    "SoLuong": soLuong,
    // "LoaiSanPham": loaiSanPham,
    // "VatLieu": vatLieu,
    // "VatLieu2": vatLieu2,
    // "VatLieu3": vatLieu3,
    // "HinhMatPhai": hinhMatPhai,
    // "HinhMatTrai": hinhMatTrai,
    // "MauMatPhai": mauMatPhai,
    // "MauMatTrai": mauMatTrai,
    // "PhuongPhapIn": phuongPhapIn,
    // "GiaCongMatPhai": giaCongMatPhai,
    // "GiaCongMatTrai": giaCongMatTrai,
    // "PhuongPhapCat": phuongPhapCat,
    // "BoGoc": boGoc,
    // "DucLo": ducLo,
    // "NhanVienNghiepVu": nhanVienNghiepVu,
    // "ChuY": chuY,
    // "ChamCatDapHop": chamCatDapHop,
    // "Khac": khac,
    // "LoaiChi": loaiChi,
    // "DoDai": doDai,
    // "GiaCongSau": giaCongSau,
    // "GiaCongSauInMatTrai": giaCongSauInMatTrai,
    // "Kho": kho,
    // "InChu_MaVach": inChuMaVach,
    // "HinhKhuon": hinhKhuon,
    // "ThoiGianXuongDon": thoiGianXuongDon.toIso8601String(),
    // "ChinhSua": chinhSua,
    // "SKU": sku,
    // "STT": stt,
    // "CongDoanSanXuat": congDoanSanXuat,
    // "CongDoanKiemPham": congDoanKiemPham,
    // "KhuVuc": khuVuc,
    // "DongBoDuLieu": dongBoDuLieu,
    // "WaterMark": waterMark,
    // "IDKhuVuc": idKhuVuc,
  };
}
