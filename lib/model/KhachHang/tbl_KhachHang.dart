import 'dart:convert';

tbl_KhachHang tbl_KhachHangFromJson(String str) => tbl_KhachHang.fromJson(json.decode(str));

String tbl_KhachHangToJson(tbl_KhachHang data) => json.encode(data.toJson());

class tbl_KhachHang {
  String? IDKhachHang;
  int? STT;
  String? MaKhachHang;
  String? TenCongTy;
  String? TenKhachHang;
  String? LoaiKhachHang;
  String Alias;
  String? Nhom;
  String? DienGiai;
  String? DiaChi;
  String? MaSoThue;
  String? NguoiLienHe;
  String? Email;
  String? DienThoai;
  String? TinhTrang;
  String? GhiChu;
  String? IDKhuVuc;
  String? CreateBy;
  DateTime? CreateDate;
  String? ModifyBy;
  DateTime? ModifyDate;

  tbl_KhachHang({
    required this.IDKhachHang,
    required this.STT,
    required this.MaKhachHang,
    required this.TenCongTy,
    required this.TenKhachHang,
    required this.LoaiKhachHang,
    required this.Alias,
    required this.Nhom,
    required this.DienGiai,
    required this.DiaChi,
    required this.MaSoThue,
    required this.NguoiLienHe,
    required this.Email,
    required this.DienThoai,
    required this.TinhTrang,
    required this.GhiChu,
    required this.IDKhuVuc,
    required this.CreateBy,
    required this.CreateDate,
    required this.ModifyBy,
    required this.ModifyDate,
  });

  Map<String, dynamic> toJson() => {
    'IDKhachHang': IDKhachHang,
    'STT': STT,
    'MaKhachHang': MaKhachHang,
    'TenCongTy': TenCongTy,
    'TenKhachHang': TenKhachHang,
    'LoaiKhachHang': LoaiKhachHang,
    'Alias': Alias,
    'Nhom': Nhom,
    'DienGiai': DienGiai,
    'DiaChi': DiaChi,
    'MaSoThue': MaSoThue,
    'NguoiLienHe': NguoiLienHe,
    'Email': Email,
    'DienThoai': DienThoai,
    'TinhTrang': TinhTrang,
    'GhiChu': GhiChu,
    'IDKhuVuc': IDKhuVuc,
    'CreateBy': CreateBy,
    'CreateDate': CreateDate?.toIso8601String(),
    'ModifyBy': ModifyBy,
    'ModifyDate': ModifyDate?.toIso8601String(),
  };

  factory tbl_KhachHang.fromJson(Map<String, dynamic> json) => tbl_KhachHang(
    IDKhachHang: json['IDKhachHang']?.toString() ?? '',
    STT: int.tryParse(json['STT']?.toString() ?? '0') ?? 0,
    MaKhachHang: json['MaKhachHang']?.toString() ?? '',
    TenCongTy: json['TenCongTy']?.toString() ?? '',
    TenKhachHang: json['TenKhachHang']?.toString() ?? '',
    LoaiKhachHang: json['LoaiKhachHang']?.toString() ?? '',
    Alias: json['Alias']?.toString() ?? '',
    Nhom: json['Nhom']?.toString() ?? '',
    DienGiai: json['DienGiai']?.toString() ?? '',
    DiaChi: json['DiaChi']?.toString() ?? '',
    MaSoThue: json['MaSoThue']?.toString() ?? '',
    NguoiLienHe: json['NguoiLienHe']?.toString() ?? '',
    Email: json['Email']?.toString() ?? '',
    DienThoai: json['DienThoai']?.toString() ?? '',
    TinhTrang: json['TinhTrang']?.toString() ?? '',
    GhiChu: json['GhiChu']?.toString() ?? '',
    IDKhuVuc: json['IDKhuVuc']?.toString() ?? '',
    CreateBy: json['CreateBy']?.toString() ?? '',
    CreateDate: DateTime.tryParse(json['CreateDate'] ?? '') ?? DateTime.now(),
    ModifyBy: json['ModifyBy']?.toString() ?? '',
    ModifyDate: DateTime.tryParse(json['ModifyDate'] ?? '') ?? DateTime.now(),
  );
}
