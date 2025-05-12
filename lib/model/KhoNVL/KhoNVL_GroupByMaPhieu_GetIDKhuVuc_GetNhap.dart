import 'dart:convert';

KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap khoNvlGroupByMaPhieuGetIdKhuVucGetNhapFromJson(String str) => KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap.fromJson(json.decode(str));
String khoNvlGroupByMaPhieuGetIdKhuVucGetNhapToJson(KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap data) => json.encode(data.toJson());

class KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap {
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
  // bool? isActive;
  // bool? isEnable;
  //dynamic trangThai;

  KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap({
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
    // this.isActive,
    // this.isEnable,
    //this.trangThai,
  });

  KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap copyWith({
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
    // bool? isActive,
    // bool? isEnable,
    // dynamic trangThai,
  }) =>
      KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap(
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
        // isActive: isActive ?? this.isActive,
        // isEnable: isEnable ?? this.isEnable,
        // trangThai: trangThai ?? this.trangThai,
      );

  factory KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap.fromJson(Map<String, dynamic> json) => KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap(
    maPhieu: json["MaPhieu"],
    lo: json["Lo"],
    kho: json["Kho"],
    thaoTac: json["ThaoTac"],
    ngay: json["Ngay"],
    nhaCungCap: json["NhaCungCap"],
    nguonNhapVao: json["NguonNhapVao"],
    nguoiQuanKho: json["NguoiQuanKho"],
    tongSoLuong: json["TongSoLuong"],
    soLuongVatLieu: json["SoLuongVatLieu"],
    // isActive: json["isActive"],
    // isEnable: json["isEnable"],
    // trangThai: json["trangThai"],
  );

  Map<String, dynamic> toJson() => {
    "MaPhieu": maPhieu,
    "Lo": lo,
    "Kho": kho,
    "ThaoTac": thaoTac,
    "Ngay": ngay,
    "NhaCungCap": nhaCungCap,
    "NguonNhapVao": nguonNhapVao,
    "NguoiQuanKho": nguoiQuanKho,
    "TongSoLuong": tongSoLuong,
    "SoLuongVatLieu": soLuongVatLieu,
    // "isActive": isActive,
    // "isEnable": isEnable,
    // "trangThai": trangThai,
  };
}
