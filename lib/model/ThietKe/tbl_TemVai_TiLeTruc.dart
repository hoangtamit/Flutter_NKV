import 'dart:convert';

tbl_TemVai_TiLeTruc tbl_TemVai_TiLeTrucFromJson(String str) => tbl_TemVai_TiLeTruc.fromJson(json.decode(str));

String tbl_TemVai_TiLeTrucToJson(tbl_TemVai_TiLeTruc data) => json.encode(data.toJson());

class tbl_TemVai_TiLeTruc {
  int? IDTiLeTruc;
  int? SoTruc;
  double? DoDayBanIn;
  double? KichThuocBangIn;
  double? KichThuocThanhPham;
  double? KichThuocDonHang;
  int? SoLuongDanTrang;
  String? TiLeRutKichThuoc;
  String? TiLeRutKichThuocAD;
  String? TiLeQuyDoi;
  int? SoLuongTruc;
  bool? TrucHienCo;
  String? DienGiai;
  String? GhiChu;
  String? IDKhuVuc;

  tbl_TemVai_TiLeTruc({
    required this.IDTiLeTruc,
    required this.SoTruc,
    required this.DoDayBanIn,
    required this.KichThuocBangIn,
    required this.KichThuocThanhPham,
    required this.KichThuocDonHang,
    required this.SoLuongDanTrang,
    required this.TiLeRutKichThuoc,
    required this.TiLeRutKichThuocAD,
    required this.TiLeQuyDoi,
    required this.SoLuongTruc,
    required this.TrucHienCo,
    required this.DienGiai,
    required this.GhiChu,
    required this.IDKhuVuc,
  });

  Map<String, dynamic> toJson() => {
    'IDTiLeTruc': IDTiLeTruc,
    'SoTruc': SoTruc,
    'DoDayBanIn': DoDayBanIn,
    'KichThuocBangIn': KichThuocBangIn,
    'KichThuocThanhPham': KichThuocThanhPham,
    'KichThuocDonHang': KichThuocDonHang,
    'SoLuongDanTrang': SoLuongDanTrang,
    'TiLeRutKichThuoc': TiLeRutKichThuoc,
    'TiLeRutKichThuocAD': TiLeRutKichThuocAD,
    'TiLeQuyDoi': TiLeQuyDoi,
    'SoLuongTruc': SoLuongTruc,
    'TrucHienCo': TrucHienCo,
    'DienGiai': DienGiai,
    'GhiChu': GhiChu,
    'IDKhuVuc': IDKhuVuc,
  };

  factory tbl_TemVai_TiLeTruc.fromJson(Map<String, dynamic> json) => tbl_TemVai_TiLeTruc(
    IDTiLeTruc: int.tryParse(json['IDTiLeTruc']?.toString() ?? '0') ?? 0,
    SoTruc: int.tryParse(json['SoTruc']?.toString() ?? '0') ?? 0,
    DoDayBanIn: double.tryParse(json['DoDayBanIn']?.toString() ?? '0') ?? 0,
    KichThuocBangIn: double.tryParse(json['KichThuocBangIn']?.toString() ?? '0') ?? 0,
    KichThuocThanhPham: double.tryParse(json['KichThuocThanhPham']?.toString() ?? '0') ?? 0,
    KichThuocDonHang: double.tryParse(json['KichThuocDonHang']?.toString() ?? '0') ?? 0,
    SoLuongDanTrang: int.tryParse(json['SoLuongDanTrang']?.toString() ?? '0') ?? 0,
    TiLeRutKichThuoc: json['TiLeRutKichThuoc']?.toString() ?? '',
    TiLeRutKichThuocAD: json['TiLeRutKichThuocAD']?.toString() ?? '',
    TiLeQuyDoi: json['TiLeQuyDoi']?.toString() ?? '',
    SoLuongTruc: int.tryParse(json['SoLuongTruc']?.toString() ?? '0') ?? 0,
    TrucHienCo: json['TrucHienCo'] is bool ? json['TrucHienCo'] : false,
    DienGiai: json['DienGiai']?.toString() ?? '',
    GhiChu: json['GhiChu']?.toString() ?? '',
    IDKhuVuc: json['IDKhuVuc']?.toString() ?? '',
  );
}
