// To parse this JSON data, do
//
//     final tbl_NhanVien = tbl_NhanVienFromJson(jsonString);
import 'dart:convert';

tbl_NhanVien tbl_NhanVienFromJson(String str) => tbl_NhanVien.fromJson(json.decode(str));
String tbl_NhanVienToJson(tbl_NhanVien data) => json.encode(data.toJson());

class tbl_NhanVien {
  final int idNhanVien;
  final dynamic maNhanVien;
  final dynamic tenNhanVien;
  final dynamic ngaySinh;
  final String? noiSinh;
  // final dynamic maThe;
  final String taiKhoan;
  final String matKhau;
  // final int idQuocTich;
  // final int idDanToc;
  // final int idTonGiao;
  final String idKhuVuc;
  // final int idKhoi;
  // final int idPhongBan;
  // final dynamic phongBan;
  // final int idBoPhan;
  final String boPhan;
  // final int idChucVu;
  final String chucVu;
  // final int idTrinhDo;
  // final String trinhDo;
  // final int idTinhTrang;
  // final String tinhTrang;
  // final int idTo;
  // final dynamic to;
  // final int idCaLamViec;
  // final DateTime ngayVaoLam;
  // final DateTime ngayKyHopDong;
  // final DateTime ngayKyHopDong2;
  // final dynamic ngayKyHopDong3;
  // final DateTime ngayHetHanHopDong;
  // final DateTime ngayHetHanHopDong2;
  // final dynamic ngayHetHanHopDong3;
  // final dynamic ngayNghiViec;
  final String dienThoai;
  final dynamic diaChiTamTru;
  final String diaChiThuongTru;
  // final dynamic nguyenQuan;
  // final String soCmnd;
  // final DateTime ngayCapCmnd;
  // final String noiCapCmnd;
  final dynamic soTheCanCuoc;
  // final dynamic ngayCapTcc;
  // final dynamic noiCapTcc;
  final String gioiTinh;
  // final dynamic hinhNhanVien;
  // final dynamic giaoDien;
  // final String tinhTrangHonNhan;
  final dynamic email;
  // final String ngoaiNgu;
  // final String ghiChu;

  tbl_NhanVien({
    required this.idNhanVien,
    required this.maNhanVien,
    required this.tenNhanVien,
    required this.ngaySinh,
    required this.noiSinh,
    // required this.maThe,
     required this.taiKhoan,
    required this.matKhau,
    // required this.idQuocTich,
    // required this.idDanToc,
    // required this.idTonGiao,
     required this.idKhuVuc,
    // required this.idKhoi,
    // required this.idPhongBan,
    // required this.phongBan,
    // required this.idBoPhan,
    required this.boPhan,
    // required this.idChucVu,
    required this.chucVu,
    // required this.idTrinhDo,
    // required this.trinhDo,
    // required this.idTinhTrang,
    // required this.tinhTrang,
    // required this.idTo,
    // required this.to,
    // required this.idCaLamViec,
    // required this.ngayVaoLam,
    // required this.ngayKyHopDong,
    // required this.ngayKyHopDong2,
    // required this.ngayKyHopDong3,
    // required this.ngayHetHanHopDong,
    // required this.ngayHetHanHopDong2,
    // required this.ngayHetHanHopDong3,
    // required this.ngayNghiViec,
    required this.dienThoai,
    required this.diaChiTamTru,
    required this.diaChiThuongTru,
    // required this.nguyenQuan,
    // required this.soCmnd,
    // required this.ngayCapCmnd,
    // required this.noiCapCmnd,
     required this.soTheCanCuoc,
    // required this.ngayCapTcc,
    // required this.noiCapTcc,
    required this.gioiTinh,
    // required this.hinhNhanVien,
    // required this.giaoDien,
    // required this.tinhTrangHonNhan,
     required this.email,
    // required this.ngoaiNgu,
    // required this.ghiChu,
  });
  factory tbl_NhanVien.fromJson(Map<String, dynamic> json) => tbl_NhanVien(
    idNhanVien: json["IDNhanVien"],
    maNhanVien: json["MaNhanVien"],
    tenNhanVien: json["TenNhanVien"],
    ngaySinh: json["NgaySinh"],
    noiSinh: json["NoiSinh"],
    // maThe: json["MaThe"],
     taiKhoan: json["TaiKhoan"],
     matKhau: json["MatKhau"],
    // idQuocTich: json["IDQuocTich"],
    // idDanToc: json["IDDanToc"],
    // idTonGiao: json["IDTonGiao"],
     idKhuVuc: json["IDKhuVuc"],
    // idKhoi: json["IDKhoi"],
    // idPhongBan: json["IDPhongBan"],
    // phongBan: json["PhongBan"],
    // idBoPhan: json["IDBoPhan"],
    boPhan: json["BoPhan"],
    // idChucVu: json["IDChucVu"],
    chucVu: json["ChucVu"],
    // idTrinhDo: json["IDTrinhDo"],
    // trinhDo: json["TrinhDo"],
    // idTinhTrang: json["IDTinhTrang"],
    // tinhTrang: json["TinhTrang"],
    // idTo: json["IDTo"],
    // to: json["To"],
    // idCaLamViec: json["IDCaLamViec"],
    // ngayVaoLam: DateTime.parse(json["NgayVaoLam"]),
    // ngayKyHopDong: DateTime.parse(json["NgayKyHopDong"]),
    // ngayKyHopDong2: DateTime.parse(json["NgayKyHopDong2"]),
    // ngayKyHopDong3: json["NgayKyHopDong3"],
    // ngayHetHanHopDong: DateTime.parse(json["NgayHetHanHopDong"]),
    // ngayHetHanHopDong2: DateTime.parse(json["NgayHetHanHopDong2"]),
    // ngayHetHanHopDong3: json["NgayHetHanHopDong3"],
    // ngayNghiViec: json["NgayNghiViec"],
    dienThoai: json["DienThoai"],
    diaChiTamTru: json["DiaChiTamTru"],
    diaChiThuongTru: json["DiaChiThuongTru"],
    // nguyenQuan: json["NguyenQuan"],
    // soCmnd: json["SoCMND"],
    // ngayCapCmnd: DateTime.parse(json["NgayCapCMND"]),
    // noiCapCmnd: json["NoiCapCMND"],
     soTheCanCuoc: json["SoTheCanCuoc"],
    // ngayCapTcc: json["NgayCapTCC"],
    // noiCapTcc: json["NoiCapTCC"],
    gioiTinh: json["GioiTinh"],
    // hinhNhanVien: json["HinhNhanVien"],
    // giaoDien: json["GiaoDien"],
    // tinhTrangHonNhan: json["TinhTrangHonNhan"],
     email: json["Email"],
    // ngoaiNgu: json["NgoaiNgu"],
    // ghiChu: json["GhiChu"],
  );

  Map<String, dynamic> toJson() => {
    "IDNhanVien": idNhanVien,
    "MaNhanVien": maNhanVien,
    "TenNhanVien": tenNhanVien,
    "NgaySinh": ngaySinh,
    // "NoiSinh": noiSinh,
    // "MaThe": maThe,
    "TaiKhoan": taiKhoan,
    "MatKhau": matKhau,
    // "IDQuocTich": idQuocTich,
    // "IDDanToc": idDanToc,
    // "IDTonGiao": idTonGiao,
     "IDKhuVuc": idKhuVuc,
    // "IDKhoi": idKhoi,
    // "IDPhongBan": idPhongBan,
    // "PhongBan": phongBan,
    // "IDBoPhan": idBoPhan,
    "BoPhan": boPhan,
    // "IDChucVu": idChucVu,
    "ChucVu": chucVu,
    // "IDTrinhDo": idTrinhDo,
    // "TrinhDo": trinhDo,
    // "IDTinhTrang": idTinhTrang,
    // "TinhTrang": tinhTrang,
    // "IDTo": idTo,
    // "To": to,
    // "IDCaLamViec": idCaLamViec,
    // "NgayVaoLam": ngayVaoLam.toIso8601String(),
    // "NgayKyHopDong": ngayKyHopDong.toIso8601String(),
    // "NgayKyHopDong2": ngayKyHopDong2.toIso8601String(),
    // "NgayKyHopDong3": ngayKyHopDong3,
    // "NgayHetHanHopDong": ngayHetHanHopDong.toIso8601String(),
    // "NgayHetHanHopDong2": ngayHetHanHopDong2.toIso8601String(),
    // "NgayHetHanHopDong3": ngayHetHanHopDong3,
    // "NgayNghiViec": ngayNghiViec,
    "DienThoai": dienThoai,
    "DiaChiTamTru": diaChiTamTru,
    "DiaChiThuongTru": diaChiThuongTru,
    // "NguyenQuan": nguyenQuan,
    // "SoCMND": soCmnd,
    // "NgayCapCMND": ngayCapCmnd.toIso8601String(),
    // "NoiCapCMND": noiCapCmnd,
     "SoTheCanCuoc": soTheCanCuoc,
    // "NgayCapTCC": ngayCapTcc,
    // "NoiCapTCC": noiCapTcc,
    "GioiTinh": gioiTinh,
    // "HinhNhanVien": hinhNhanVien,
    // "GiaoDien": giaoDien,
    // "TinhTrangHonNhan": tinhTrangHonNhan,
     "Email": email,
    // "NgoaiNgu": ngoaiNgu,
    // "GhiChu": ghiChu,
  };
}
