import 'dart:convert';

tbl_KhoBTP_TP tbl_KhoBTP_TPFromJson(String str) => tbl_KhoBTP_TP.fromJson(json.decode(str));

String tbl_KhoBTP_TPToJson(tbl_KhoBTP_TP data) => json.encode(data.toJson());

class tbl_KhoBTP_TP {
  String? IDKhoBTP_TP;
  String? MaKhoBTP_TP;
  String? MaPhieu;
  String? Kho;
  String? ThaoTac;
  String? NhapXuat;
  String? SCD;
  String? TenKhachHang;
  String? MaSanPham;
  String? Size;
  String? LoaiHang;
  String? Nguon;
  String? Lo;
  DateTime? Ngay;
  int? SoLuongNhap;
  int? SoLuongXuat;
  int? SoLuong;
  String? DonViTinh;
  String? QuyCach;
  String? ViTri;
  String? GhiChu;
  String? NhanVien;
  String? TrangThai;
  String? IDKhuVuc;
  String? CreateBy;
  DateTime? CreateDate;
  String? ModifyBy;
  DateTime? ModifyDate;
  String? IDTinhLieu;
  bool? isEnable;

  tbl_KhoBTP_TP({
    required this.IDKhoBTP_TP,
    required this.MaKhoBTP_TP,
    required this.MaPhieu,
    required this.Kho,
    required this.ThaoTac,
    required this.NhapXuat,
    required this.SCD,
    required this.TenKhachHang,
    required this.MaSanPham,
    required this.Size,
    required this.LoaiHang,
    required this.Nguon,
    required this.Lo,
    required this.Ngay,
    required this.SoLuongNhap,
    required this.SoLuongXuat,
    required this.SoLuong,
    required this.DonViTinh,
    required this.QuyCach,
    required this.ViTri,
    required this.GhiChu,
    required this.NhanVien,
    required this.TrangThai,
    required this.IDKhuVuc,
    required this.CreateBy,
    required this.CreateDate,
    required this.ModifyBy,
    required this.ModifyDate,
    required this.IDTinhLieu,
    required this.isEnable,
  });

  Map<String, dynamic> toJson() => {
    'IDKhoBTP_TP': IDKhoBTP_TP,
    'MaKhoBTP_TP': MaKhoBTP_TP,
    'MaPhieu': MaPhieu,
    'Kho': Kho,
    'ThaoTac': ThaoTac,
    'NhapXuat': NhapXuat,
    'SCD': SCD,
    'TenKhachHang': TenKhachHang,
    'MaSanPham': MaSanPham,
    'Size': Size,
    'LoaiHang': LoaiHang,
    'Nguon': Nguon,
    'Lo': Lo,
    'Ngay': Ngay,
    'SoLuongNhap': SoLuongNhap,
    'SoLuongXuat': SoLuongXuat,
    'SoLuong': SoLuong,
    'DonViTinh': DonViTinh,
    'QuyCach': QuyCach,
    'ViTri': ViTri,
    'GhiChu': GhiChu,
    'NhanVien': NhanVien,
    'TrangThai': TrangThai,
    'IDKhuVuc': IDKhuVuc,
    'CreateBy': CreateBy,
    'CreateDate': CreateDate?.toIso8601String(),
    'ModifyBy': ModifyBy,
    'ModifyDate': ModifyDate?.toIso8601String(),
    'IDTinhLieu': IDTinhLieu,
    'isEnable': isEnable,
  };

  factory tbl_KhoBTP_TP.fromJson(Map<String, dynamic> json) => tbl_KhoBTP_TP(
    IDKhoBTP_TP: json['IDKhoBTP_TP']?.toString() ?? '',
    MaKhoBTP_TP: json['MaKhoBTP_TP']?.toString() ?? '',
    MaPhieu: json['MaPhieu']?.toString() ?? '',
    Kho: json['Kho']?.toString() ?? '',
    ThaoTac: json['ThaoTac']?.toString() ?? '',
    NhapXuat: json['NhapXuat']?.toString() ?? '',
    SCD: json['SCD']?.toString() ?? '',
    TenKhachHang: json['TenKhachHang']?.toString() ?? '',
    MaSanPham: json['MaSanPham']?.toString() ?? '',
    Size: json['Size']?.toString() ?? '',
    LoaiHang: json['LoaiHang']?.toString() ?? '',
    Nguon: json['Nguon']?.toString() ?? '',
    Lo: json['Lo']?.toString() ?? '',
    Ngay: DateTime.tryParse(json['Ngay'] ?? '') ?? DateTime.now(),
    SoLuongNhap: int.tryParse(json['SoLuongNhap']?.toString() ?? '0') ?? 0,
    SoLuongXuat: int.tryParse(json['SoLuongXuat']?.toString() ?? '0') ?? 0,
    SoLuong: int.tryParse(json['SoLuong']?.toString() ?? '0') ?? 0,
    DonViTinh: json['DonViTinh']?.toString() ?? '',
    QuyCach: json['QuyCach']?.toString() ?? '',
    ViTri: json['ViTri']?.toString() ?? '',
    GhiChu: json['GhiChu']?.toString() ?? '',
    NhanVien: json['NhanVien']?.toString() ?? '',
    TrangThai: json['TrangThai']?.toString() ?? '',
    IDKhuVuc: json['IDKhuVuc']?.toString() ?? '',
    CreateBy: json['CreateBy']?.toString() ?? '',
    CreateDate: DateTime.tryParse(json['CreateDate'] ?? '') ?? DateTime.now(),
    ModifyBy: json['ModifyBy']?.toString() ?? '',
    ModifyDate: DateTime.tryParse(json['ModifyDate'] ?? '') ?? DateTime.now(),
    IDTinhLieu: json['IDTinhLieu']?.toString() ?? '',
    isEnable: json['isEnable'] is bool ? json['isEnable'] : false,
  );
}
