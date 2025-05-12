import 'dart:convert';

tbKhoNVL tbKhoNvlFromJson(String str) => tbKhoNVL.fromJson(json.decode(str));
String tbKhoNvlToJson(tbKhoNVL data) => json.encode(data.toJson());

class tbKhoNVL {
//  String? idKhoNvl;
//  dynamic maKhoNvl;
//  String? idpo;
  dynamic maPhieu;
  dynamic lo;
  dynamic nhapXuat;
  dynamic thaoTac;
  dynamic scd;
  dynamic kho;
  dynamic ngay;
  dynamic idVatLieu;
  dynamic maVatLieu;
  dynamic soLuongNhap;
  dynamic soLuongXuat;
  dynamic soLuong;
  dynamic boPhan;
  dynamic hanSuDung;
  dynamic nhaCungCap;
  dynamic nguoiQuanKho;
  dynamic viTri;
  // dynamic ghiChu;
  // dynamic sttTinhLieu;
  // dynamic trangThai;
  // dynamic mauSac;
  // dynamic idKhuVuc;
  // dynamic createBy;
  // String? createDate;
  // dynamic modifyBy;
  // String? modifyDate;

  tbKhoNVL({
    // this.idKhoNvl,
    // this.maKhoNvl,
    // this.idpo,
    this.maPhieu,
    this.lo,
    this.nhapXuat,
    this.thaoTac,
    this.scd,
    this.kho,
    this.ngay,
    this.idVatLieu,
    this.maVatLieu,
    this.soLuongNhap,
    this.soLuongXuat,
    this.soLuong,
    this.boPhan,
    this.hanSuDung,
    this.nhaCungCap,
    this.nguoiQuanKho,
    this.viTri,
    // this.ghiChu,
    // this.sttTinhLieu,
    // this.trangThai,
    // this.mauSac,
    // this.idKhuVuc,
    // this.createBy,
    // this.createDate,
    // this.modifyBy,
    // this.modifyDate,
  });

  factory tbKhoNVL.fromJson(Map<String, dynamic> json) => tbKhoNVL(
    // idKhoNvl: json["IDKhoNVL"],
    // maKhoNvl: json["MaKhoNVL"],
    // idpo: json["IDPO"],
    maPhieu: json["MaPhieu"],
    lo: json["Lo"],
    nhapXuat: json["NhapXuat"],
    thaoTac: json["ThaoTac"],
    scd: json["SCD"],
    kho: json["Kho"],
    ngay: json["Ngay"],
    idVatLieu: json["IDVatLieu"],
    maVatLieu: json["MaVatLieu"],
    soLuongNhap: json["SoLuongNhap"],
    soLuongXuat: json["SoLuongXuat"],
    soLuong: json["SoLuong"],
    boPhan: json["BoPhan"],
    hanSuDung: json["HanSuDung"],
    nhaCungCap: json["NhaCungCap"],
    nguoiQuanKho: json["NguoiQuanKho"],
    viTri: json["ViTri"],
    // ghiChu: json["GhiChu"],
    // sttTinhLieu: json["SttTinhLieu"],
    // trangThai: json["TrangThai"],
    // mauSac: json["MauSac"],
    // idKhuVuc: json["IDKhuVuc"],
    // createBy: json["CreateBy"],
    // createDate: json["CreateDate"],
    // modifyBy: json["ModifyBy"],
    // modifyDate: json["ModifyDate"],
  );

  Map<String, dynamic> toJson() => {
    // "IDKhoNVL": idKhoNvl,
    // "MaKhoNVL": maKhoNvl,
    // "IDPO": idpo,
    "MaPhieu": maPhieu,
    "Lo": lo,
    "NhapXuat": nhapXuat,
    "ThaoTac": thaoTac,
    "SCD": scd,
    "Kho": kho,
    "Ngay": ngay,
    "IDVatLieu": idVatLieu,
    "MaVatLieu": maVatLieu,
    "SoLuongNhap": soLuongNhap,
    "SoLuongXuat": soLuongXuat,
    "SoLuong": soLuong,
    "BoPhan": boPhan,
    "HanSuDung": hanSuDung,
    "NhaCungCap": nhaCungCap,
    "NguoiQuanKho": nguoiQuanKho,
    "ViTri": viTri,
    // "GhiChu": ghiChu,
    // "SttTinhLieu": sttTinhLieu,
    // "TrangThai": trangThai,
    // "MauSac": mauSac,
    // "IDKhuVuc": idKhuVuc,
    // "CreateBy": createBy,
    // "CreateDate": createDate,
    // "ModifyBy": modifyBy,
    // "ModifyDate": modifyDate,
  };
}
