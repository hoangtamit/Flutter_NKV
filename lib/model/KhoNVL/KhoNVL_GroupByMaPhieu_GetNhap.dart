import 'dart:convert';

KhoNVL_GroupByMaPhieu_GetNhap khoNvlGroupByMaPhieuGetIdKhuVucGetNhapFromJson(String str) => KhoNVL_GroupByMaPhieu_GetNhap.fromJson(json.decode(str));
String khoNvlGroupByMaPhieuGetIdKhuVucGetNhapToJson(KhoNVL_GroupByMaPhieu_GetNhap data) => json.encode(data.toJson());

class KhoNVL_GroupByMaPhieu_GetNhap {
  dynamic maPhieu;
  dynamic lo;
  dynamic kho;
  dynamic thaoTac;
  String? ngay;
  dynamic nhaCungCap;
  dynamic nguonNhapVao;
  dynamic nguoiQuanKho;
  int? tongSoLuong;
  int? soLuongVatLieu;
  bool? isActive;
  bool? isEnable;
  dynamic trangThai;

  KhoNVL_GroupByMaPhieu_GetNhap({
    this.maPhieu,
    this.lo,
    this.kho,
    this.thaoTac,
    this.ngay,
    this.nhaCungCap,
    this.nguonNhapVao,
    this.nguoiQuanKho,
    this.tongSoLuong,
    this.soLuongVatLieu,
    this.isActive,
    this.isEnable,
    this.trangThai,
  });

  KhoNVL_GroupByMaPhieu_GetNhap copyWith({
    dynamic maPhieu,
    dynamic lo,
    dynamic kho,
    dynamic thaoTac,
    String? ngay,
    dynamic nhaCungCap,
    dynamic nguonNhapVao,
    dynamic nguoiQuanKho,
    int? tongSoLuong,
    int? soLuongVatLieu,
    bool? isActive,
    bool? isEnable,
    dynamic trangThai,
  }) =>
      KhoNVL_GroupByMaPhieu_GetNhap(
        maPhieu: maPhieu ?? this.maPhieu,
        lo: lo ?? this.lo,
        kho: kho ?? this.kho,
        thaoTac: thaoTac ?? this.thaoTac,
        ngay: ngay ?? this.ngay,
        nhaCungCap: nhaCungCap ?? this.nhaCungCap,
        nguonNhapVao: nguonNhapVao ?? this.nguonNhapVao,
        nguoiQuanKho: nguoiQuanKho ?? this.nguoiQuanKho,
        tongSoLuong: tongSoLuong ?? this.tongSoLuong,
        soLuongVatLieu: soLuongVatLieu ?? this.soLuongVatLieu,
        isActive: isActive ?? this.isActive,
        isEnable: isEnable ?? this.isEnable,
        trangThai: trangThai ?? this.trangThai,
      );

  factory KhoNVL_GroupByMaPhieu_GetNhap.fromJson(Map<String, dynamic> json) => KhoNVL_GroupByMaPhieu_GetNhap(
    maPhieu: json["maPhieu"],
    lo: json["lo"],
    kho: json["kho"],
    thaoTac: json["thaoTac"],
    ngay: json["ngay"],
    nhaCungCap: json["nhaCungCap"],
    nguonNhapVao: json["nguonNhapVao"],
    nguoiQuanKho: json["nguoiQuanKho"],
    tongSoLuong: json["tongSoLuong"],
    soLuongVatLieu: json["soLuongVatLieu"],
    isActive: json["isActive"],
    isEnable: json["isEnable"],
    trangThai: json["trangThai"],
  );

  Map<String, dynamic> toJson() => {
    "maPhieu": maPhieu,
    "lo": lo,
    "kho": kho,
    "thaoTac": thaoTac,
    "ngay": ngay,
    "nhaCungCap": nhaCungCap,
    "nguonNhapVao": nguonNhapVao,
    "nguoiQuanKho": nguoiQuanKho,
    "tongSoLuong": tongSoLuong,
    "soLuongVatLieu": soLuongVatLieu,
    "isActive": isActive,
    "isEnable": isEnable,
    "trangThai": trangThai,
  };
}
