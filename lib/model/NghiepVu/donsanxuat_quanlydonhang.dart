// To parse this JSON data, do
//
//     final DonSanXuat_QuanLyDonHang = DonSanXuat_QuanLyDonHangFromJson(jsonString);

import 'dart:convert';
//Future<DonSanXuat_QuanLyDonHang> DonSanXuat_QuanLyDonHangFromJson(String str) async => DonSanXuat_QuanLyDonHang.fromJson(json.decode(str));
DonSanXuat_QuanLyDonHang DonSanXuat_QuanLyDonHangFromJson(String str) => DonSanXuat_QuanLyDonHang.fromJson(json.decode(str));

String DonSanXuat_QuanLyDonHangToJson(DonSanXuat_QuanLyDonHang data) => json.encode(data.toJson());

class DonSanXuat_QuanLyDonHang {
  final String scd;
  final String maDonHang;
  final String phienBan;
  final String tenKhachHang;
  final String tenSanPham;
  final String kichThuoc;
  final String boPhan;
  final DateTime ngayXuongDon;
  final DateTime ngayGiaoHang;
  final int soLuong;
  final String loaiSanPham;
  final String vatLieu;
  final String idQuanLyDonHang;
  final String? nghiepVuXuongDon;
  final String? thietKeNhan;
  final String? thietKeHoanThanh;
  // final dynamic ctpNhan;
  // final dynamic ctpHoanThanh;
  // final dynamic ctfNhan;
  // final dynamic ctfHoanThanh;
  // final dynamic offsetNhan;
  // final dynamic offsetHoanThanh;
  // final dynamic temVaiNhan;
  // final dynamic temVaiHoanThanh;
  // final dynamic danhThiepNhan;
  // final dynamic danhThiepHoanThanh;
  // final dynamic kyThuatSoNhan;
  // final dynamic kyThuatSoHoanThanh;
  // final dynamic stickerNhan;
  // final dynamic stickerHoanThanh;
  // final dynamic sauInNhan;
  // final dynamic sauInHoanThanh;
  // final dynamic inChuNhan;
  // final dynamic inChuHoanThanh;
  // final dynamic kiemPhamNhan;
  // final dynamic kiemPhamHoanThanh;
  // final dynamic khoBtpNhan;
  // final dynamic khoBtpHoanThanh;
  // final dynamic hoanThanh;
  // final dynamic donSuCo;
  // final dynamic ghiChu;

  DonSanXuat_QuanLyDonHang({
    required this.scd,
    required this.maDonHang,
    required this.phienBan,
    required this.tenKhachHang,
    required this.tenSanPham,
    required this.kichThuoc,
    required this.boPhan,
    required this.ngayXuongDon,
    required this.ngayGiaoHang,
    required this.soLuong,
    required this.loaiSanPham,
    required this.vatLieu,
    required this.idQuanLyDonHang,
    this.nghiepVuXuongDon,
    this.thietKeNhan,
    this.thietKeHoanThanh,
    // required this.ctpNhan,
    // required this.ctpHoanThanh,
    // required this.ctfNhan,
    // required this.ctfHoanThanh,
    // required this.offsetNhan,
    // required this.offsetHoanThanh,
    // required this.temVaiNhan,
    // required this.temVaiHoanThanh,
    // required this.danhThiepNhan,
    // required this.danhThiepHoanThanh,
    // required this.kyThuatSoNhan,
    // required this.kyThuatSoHoanThanh,
    // required this.stickerNhan,
    // required this.stickerHoanThanh,
    // required this.sauInNhan,
    // required this.sauInHoanThanh,
    // required this.inChuNhan,
    // required this.inChuHoanThanh,
    // required this.kiemPhamNhan,
    // required this.kiemPhamHoanThanh,
    // required this.khoBtpNhan,
    // required this.khoBtpHoanThanh,
    // required this.hoanThanh,
    // required this.donSuCo,
    // required this.ghiChu,
  });

  factory DonSanXuat_QuanLyDonHang.fromJson(Map<String, dynamic> json) => DonSanXuat_QuanLyDonHang(
    scd: json["SCD"],
    maDonHang: json["MaDonHang"],
    phienBan: json["PhienBan"],
    tenKhachHang: json["TenKhachHang"],
    tenSanPham: json["TenSanPham"],
    kichThuoc: json["KichThuoc"],
    boPhan: json["BoPhan"],
    ngayXuongDon: DateTime.parse(json["NgayXuongDon"]),
    ngayGiaoHang: DateTime.parse(json["NgayGiaoHang"]),
    soLuong: json["SoLuong"],
    loaiSanPham: json["LoaiSanPham"],
    vatLieu: json["VatLieu"],
    idQuanLyDonHang: json["IDQuanLyDonHang"],
    nghiepVuXuongDon: json["NghiepVu_XuongDon"],
    thietKeNhan: json["ThietKeNhan"],
    thietKeHoanThanh: json["ThietKeHoanThanh"],
    // ctpNhan: json["CtpNhan"],
    // ctpHoanThanh: json["CtpHoanThanh"],
    // ctfNhan: json["CtfNhan"],
    // ctfHoanThanh: json["CtfHoanThanh"],
    // offsetNhan: json["OffsetNhan"],
    // offsetHoanThanh: json["OffsetHoanThanh"],
    // temVaiNhan: json["TemVaiNhan"],
    // temVaiHoanThanh: json["TemVaiHoanThanh"],
    // danhThiepNhan: json["DanhThiepNhan"],
    // danhThiepHoanThanh: json["DanhThiepHoanThanh"],
    // kyThuatSoNhan: json["KyThuatSoNhan"],
    // kyThuatSoHoanThanh: json["KyThuatSoHoanThanh"],
    // stickerNhan: json["StickerNhan"],
    // stickerHoanThanh: json["StickerHoanThanh"],
    // sauInNhan: json["SauInNhan"],
    // sauInHoanThanh: json["SauInHoanThanh"],
    // inChuNhan: json["InChuNhan"],
    // inChuHoanThanh: json["InChuHoanThanh"],
    // kiemPhamNhan: json["KiemPhamNhan"],
    // kiemPhamHoanThanh: json["KiemPhamHoanThanh"],
    // khoBtpNhan: json["KhoBTPNhan"],
    // khoBtpHoanThanh: json["KhoBTPHoanThanh"],
    // hoanThanh: json["HoanThanh"],
    // donSuCo: json["DonSuCo"],
    // ghiChu: json["GhiChu"],
  );

  Map<String, dynamic> toJson() => {
    "SCD": scd,
    // "MaDonHang": maDonHang,
    // "PhienBan": phienBan,
    // "TenKhachHang": tenKhachHang,
    // "TenSanPham": tenSanPham,
    // "KichThuoc": kichThuoc,
    // "BoPhan": boPhan,
    // "NgayXuongDon": ngayXuongDon.toIso8601String(),
    // "NgayGiaoHang": ngayGiaoHang.toIso8601String(),
    // "SoLuong": soLuong,
    // "LoaiSanPham": loaiSanPham,
    // "VatLieu": vatLieu,
    // "IDQuanLyDonHang": idQuanLyDonHang,
    // "NghiepVu_XuongDon": nghiepVuXuongDon,
    // "ThietKeNhan": thietKeNhan,
    // "ThietKeHoanThanh": thietKeHoanThanh,
    // "CtpNhan": ctpNhan,
    // "CtpHoanThanh": ctpHoanThanh,
    // "CtfNhan": ctfNhan,
    // "CtfHoanThanh": ctfHoanThanh,
    // "OffsetNhan": offsetNhan,
    // "OffsetHoanThanh": offsetHoanThanh,
    // "TemVaiNhan": temVaiNhan,
    // "TemVaiHoanThanh": temVaiHoanThanh,
    // "DanhThiepNhan": danhThiepNhan,
    // "DanhThiepHoanThanh": danhThiepHoanThanh,
    // "KyThuatSoNhan": kyThuatSoNhan,
    // "KyThuatSoHoanThanh": kyThuatSoHoanThanh,
    // "StickerNhan": stickerNhan,
    // "StickerHoanThanh": stickerHoanThanh,
    // "SauInNhan": sauInNhan,
    // "SauInHoanThanh": sauInHoanThanh,
    // "InChuNhan": inChuNhan,
    // "InChuHoanThanh": inChuHoanThanh,
    // "KiemPhamNhan": kiemPhamNhan,
    // "KiemPhamHoanThanh": kiemPhamHoanThanh,
    // "KhoBTPNhan": khoBtpNhan,
    // "KhoBTPHoanThanh": khoBtpHoanThanh,
    // "HoanThanh": hoanThanh,
    // "DonSuCo": donSuCo,
    // "GhiChu": ghiChu,
  };
}
