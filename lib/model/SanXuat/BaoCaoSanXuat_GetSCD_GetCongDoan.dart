import 'dart:convert';

BaoCaoSanXuat_GetSCD_GetCongDoan BaoCaoSanXuat_GetSCD_GetCongDoanFromJson(String str) => BaoCaoSanXuat_GetSCD_GetCongDoan.fromJson(json.decode(str));

String BaoCaoSanXuat_GetSCD_GetCongDoanToJson(BaoCaoSanXuat_GetSCD_GetCongDoan data) => json.encode(data.toJson());

class BaoCaoSanXuat_GetSCD_GetCongDoan {
 String NgayTrongTuan;
 String CaLamViec;
 String MSNV;
 String TenNhanVien;
 String CongDoan;
  String CongDoanSanXuat;
 String CongDoanKiemPham;
 String SCD;
 String BoPhan;
 String TenKhachHang;
 String TenSanPham;
 int? SoLuong;
 int? LanhLieu;
 int? SoLuongDat_Sheet;
 int? SoLuongLoi_Sheet;
 String? ThoiGianCanhChinh_BatDau;
 String? ThoiGianCanhChinh_KetThuc;
 String? ThoiGianChayMay_BatDau;
 String? ThoiGianChayMay_KetThuc;
 String? ThoiGianPhuTro_BatDau;
 String? ThoiGianPhuTro_KetThuc;
 int? ThoiGianChayMay;
 String GhiChu;
 int? SoLuongSanXuat;
 String IDKhuVuc;
 String DonViTinh;
 String QuyCach;
 String KhoGiayIn;

BaoCaoSanXuat_GetSCD_GetCongDoan({
required this.NgayTrongTuan,
required this.CaLamViec,
required this.MSNV,
required this.TenNhanVien,
required this.CongDoan,
  required this.CongDoanSanXuat,
  required this.CongDoanKiemPham,
required this.SCD,
required this.BoPhan,
required this.TenKhachHang,
required this.TenSanPham,
required this.SoLuong,
required this.LanhLieu,
required this.SoLuongDat_Sheet,
required this.SoLuongLoi_Sheet,
required this.ThoiGianCanhChinh_BatDau,
required this.ThoiGianCanhChinh_KetThuc,
  required this.ThoiGianChayMay_BatDau,
  required this.ThoiGianChayMay_KetThuc,
  required this.ThoiGianPhuTro_BatDau,
  required this.ThoiGianPhuTro_KetThuc,
required this.ThoiGianChayMay,
required this.GhiChu,
required this.SoLuongSanXuat,
required this.IDKhuVuc,
required this.DonViTinh,
required this.QuyCach,
required this.KhoGiayIn,
});

Map<String, dynamic> toJson() => {
'NgayTrongTuan': NgayTrongTuan,
'CaLamViec': CaLamViec,
'MSNV': MSNV,
'TenNhanVien': TenNhanVien,
'CongDoan': CongDoan,
  'CongDoanSanXuat': CongDoanSanXuat,
  'CongDoanKiemPham': CongDoanKiemPham,
'SCD': SCD,
'BoPhan': BoPhan,
'TenKhachHang': TenKhachHang,
'TenSanPham': TenSanPham,
'SoLuong': SoLuong,
'LanhLieu': LanhLieu,
'SoLuongDat_Sheet': SoLuongDat_Sheet,
'SoLuongLoi_Sheet': SoLuongLoi_Sheet,
'ThoiGianCanhChinh_BatDau': ThoiGianCanhChinh_BatDau,
'ThoiGianCanhChinh_KetThuc': ThoiGianCanhChinh_KetThuc,
  'ThoiGianChayMay_BatDau': ThoiGianChayMay_BatDau,
  'ThoiGianChayMay_KetThuc': ThoiGianChayMay_KetThuc,
  'ThoiGianPhuTro_BatDau': ThoiGianPhuTro_BatDau,
  'ThoiGianPhuTro_KetThuc': ThoiGianPhuTro_KetThuc,
  'ThoiGianChayMay': ThoiGianChayMay,
'GhiChu': GhiChu,
'SoLuongSanXuat': SoLuongSanXuat,
'IDKhuVuc': IDKhuVuc,
'DonViTinh': DonViTinh,
'QuyCach': QuyCach,
'KhoGiayIn': KhoGiayIn,
};

factory BaoCaoSanXuat_GetSCD_GetCongDoan.fromJson(Map<String, dynamic> json) => BaoCaoSanXuat_GetSCD_GetCongDoan(
NgayTrongTuan: json['NgayTrongTuan']?.toString() ?? '',
CaLamViec: json['CaLamViec']?.toString() ?? '',
MSNV: json['MSNV']?.toString() ?? '',
TenNhanVien: json['TenNhanVien']?.toString() ?? '',
CongDoan: json['CongDoan']?.toString() ?? '',
  CongDoanSanXuat: json['CongDoanSanXuat']?.toString() ?? '',
  CongDoanKiemPham: json['CongDoanKiemPham']?.toString() ?? '',
SCD: json['SCD']?.toString() ?? '',
BoPhan: json['BoPhan']?.toString() ?? '',
TenKhachHang: json['TenKhachHang']?.toString() ?? '',
TenSanPham: json['TenSanPham']?.toString() ?? '',
SoLuong: json['SoLuong'],
LanhLieu: json['LanhLieu'],
SoLuongDat_Sheet: json['SoLuongDat_Sheet'],
SoLuongLoi_Sheet: json['SoLuongLoi_Sheet'],
  ThoiGianCanhChinh_BatDau: json['ThoiGianCanhChinh_BatDau'] ?? '',
  ThoiGianCanhChinh_KetThuc: json['ThoiGianCanhChinh_KetThuc'] ?? '',
  ThoiGianChayMay_BatDau: json['ThoiGianChayMay_BatDau'] ?? '',
  ThoiGianChayMay_KetThuc: json['ThoiGianChayMay_KetThuc'] ?? '',
  ThoiGianPhuTro_BatDau: json['ThoiGianPhuTro_BatDau'] ?? '',
  ThoiGianPhuTro_KetThuc: json['ThoiGianPhuTro_KetThuc'] ?? '',
  ThoiGianChayMay: json['ThoiGianChayMay'],
GhiChu: json['GhiChu']?.toString() ?? '',
SoLuongSanXuat: json['SoLuongSanXuat'],
IDKhuVuc: json['IDKhuVuc']?.toString() ?? '',
DonViTinh: json['DonViTinh']?.toString() ?? '',
QuyCach: json['QuyCach']?.toString() ?? '',
KhoGiayIn: json['KhoGiayIn']?.toString() ?? '',
);
}
