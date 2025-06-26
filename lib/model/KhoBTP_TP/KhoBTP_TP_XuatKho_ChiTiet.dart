import 'dart:convert';

KhoBTP_TP_XuatKho_ChiTiet KhoBTP_TP_XuatKho_ChiTietFromJson(String str) => KhoBTP_TP_XuatKho_ChiTiet.fromJson(json.decode(str));

String KhoBTP_TP_XuatKho_ChiTietToJson(KhoBTP_TP_XuatKho_ChiTiet data) => json.encode(data.toJson());

class KhoBTP_TP_XuatKho_ChiTiet {
  dynamic? IDTinhLieu;
  dynamic IDKhoBTP_TP;
  String? SCD;
  String MaPhieu;
  String? MaKhoNVL;
  String? MaSanPham;
  String? TenKhachHang;
  String? LoaiHang;
  String? TenSanPham;
  String? Nguon;
  dynamic? SoLuongXuat;
  String? ViTri;
  String? Lo;
  String? ThaoTac;
  String? DonViTinh;
  String? QuyCach;
  String? GhiChu;
  String? IDKhuVuc;
  String? Kho;
  String? NhanVien;
  DateTime? Ngay;
  bool? isTinh;

  KhoBTP_TP_XuatKho_ChiTiet({
    required this.IDTinhLieu,
    required this.IDKhoBTP_TP,
    required this.SCD,
    required this.MaPhieu,
    required this.MaKhoNVL,
    required this.MaSanPham,
    required this.TenKhachHang,
    required this.LoaiHang,
    required this.TenSanPham,
    required this.Nguon,
    required this.SoLuongXuat,
    required this.ViTri,
    required this.Lo,
    required this.ThaoTac,
    required this.DonViTinh,
    required this.QuyCach,
    required this.GhiChu,
    required this.IDKhuVuc,
    required this.Kho,
    required this.NhanVien,
    required this.Ngay,
    required this.isTinh,
  });

  Map<String, dynamic> toJson() => {
    'IDTinhLieu': IDTinhLieu,
    'IDKhoBTP_TP': IDKhoBTP_TP,
    'SCD': SCD,
    'MaPhieu': MaPhieu,
    'MaKhoNVL': MaKhoNVL,
    'MaSanPham': MaSanPham,
    'TenKhachHang': TenKhachHang,
    'LoaiHang': LoaiHang,
    'TenSanPham': TenSanPham,
    'Nguon': Nguon,
    'SoLuongXuat': SoLuongXuat,
    'ViTri': ViTri,
    'Lo': Lo,
    'ThaoTac': ThaoTac,
    'DonViTinh': DonViTinh,
    'QuyCach': QuyCach,
    'GhiChu': GhiChu,
    'IDKhuVuc': IDKhuVuc,
    'Kho': Kho,
    'NhanVien': NhanVien,
    'Ngay': Ngay,
    'isTinh': isTinh,
  };

  factory KhoBTP_TP_XuatKho_ChiTiet.fromJson(Map<String, dynamic> json) => KhoBTP_TP_XuatKho_ChiTiet(
    IDTinhLieu: json['IDTinhLieu']?.toString() ?? '',
    IDKhoBTP_TP: json['IDKhoBTP_TP']?.toString() ?? '',
    SCD: json['SCD']?.toString() ?? '',
    MaPhieu: json['MaPhieu']?.toString() ?? '',
    MaKhoNVL: json['MaKhoNVL']?.toString() ?? '',
    MaSanPham: json['MaSanPham']?.toString() ?? '',
    TenKhachHang: json['TenKhachHang']?.toString() ?? '',
    LoaiHang: json['LoaiHang']?.toString() ?? '',
    TenSanPham: json['TenSanPham']?.toString() ?? '',
    Nguon: json['Nguon']?.toString() ?? '',
    SoLuongXuat: double.tryParse(json['SoLuongXuat']?.toString() ?? '0') ?? 0,
    ViTri: json['ViTri']?.toString() ?? '',
    Lo: json['Lo']?.toString() ?? '',
    ThaoTac: json['ThaoTac']?.toString() ?? '',
    DonViTinh: json['DonViTinh']?.toString() ?? '',
    QuyCach: json['QuyCach']?.toString() ?? '',
    GhiChu: json['GhiChu']?.toString() ?? '',
    IDKhuVuc: json['IDKhuVuc']?.toString() ?? '',
    Kho: json['Kho']?.toString() ?? '',
    NhanVien: json['NhanVien']?.toString() ?? '',
    Ngay: DateTime.tryParse(json['Ngay'] ?? '') ?? DateTime.now(),
    isTinh: json['isTinh']?.toString() == 'true' ? true : false,
  );
}
