import 'dart:convert';

DonSanXuat_Get15C DonSanXuat_Get15CFromJson(String str) => DonSanXuat_Get15C.fromJson(json.decode(str));

String DonSanXuat_Get15CToJson(DonSanXuat_Get15C data) => json.encode(data.toJson());

class DonSanXuat_Get15C {
String SCD;
String? MaDonHang;
String? MaSanPham;
String? PhienBan;
String? TenKhachHang;
String? LoaiSanPham;
String? TenSanPham;
String? KichThuoc;
String? BoPhan;
DateTime? NgayXuongDon;
DateTime? NgayGiaoHang;
int SoLuong;
String? Kho;
String? MaVatLieu1;
String? VatLieu;
String? VatLieu2;
String? VatLieu3;
String? GhiChu;

DonSanXuat_Get15C({
required this.SCD,
required this.MaDonHang,
required this.MaSanPham,
required this.PhienBan,
required this.TenKhachHang,
required this.LoaiSanPham,
required this.TenSanPham,
required this.KichThuoc,
required this.BoPhan,
required this.NgayXuongDon,
required this.NgayGiaoHang,
required this.SoLuong,
required this.Kho,
required this.MaVatLieu1,
required this.VatLieu,
required this.VatLieu2,
required this.VatLieu3,
required this.GhiChu,
});

Map<String, dynamic> toJson() => {
'SCD': SCD,
'MaDonHang': MaDonHang,
'MaSanPham': MaSanPham,
'PhienBan': PhienBan,
'TenKhachHang': TenKhachHang,
'LoaiSanPham': LoaiSanPham,
'TenSanPham': TenSanPham,
'KichThuoc': KichThuoc,
'BoPhan': BoPhan,
'NgayXuongDon': NgayXuongDon,
'NgayGiaoHang': NgayGiaoHang,
'SoLuong': SoLuong,
'Kho': Kho,
'MaVatLieu1': MaVatLieu1,
'VatLieu': VatLieu,
'VatLieu2': VatLieu2,
'VatLieu3': VatLieu3,
'GhiChu': GhiChu,
};

factory DonSanXuat_Get15C.fromJson(Map<String, dynamic> json) => DonSanXuat_Get15C(
SCD: json['SCD']?.toString() ?? '',
MaDonHang: json['MaDonHang']?.toString() ?? '',
MaSanPham: json['MaSanPham']?.toString() ?? '',
PhienBan: json['PhienBan']?.toString() ?? '',
TenKhachHang: json['TenKhachHang']?.toString() ?? '',
LoaiSanPham: json['LoaiSanPham']?.toString() ?? '',
TenSanPham: json['TenSanPham']?.toString() ?? '',
KichThuoc: json['KichThuoc']?.toString() ?? '',
BoPhan: json['BoPhan']?.toString() ?? '',
NgayXuongDon: DateTime.tryParse(json['NgayXuongDon'] ?? '') ?? DateTime.now(),
NgayGiaoHang: DateTime.tryParse(json['NgayGiaoHang'] ?? '') ?? DateTime.now(),
  SoLuong: int.tryParse(json['SoLuong']?.toString() ?? '0') ?? 0,
Kho: json['Kho']?.toString() ?? '',
MaVatLieu1: json['MaVatLieu1']?.toString() ?? '',
VatLieu: json['VatLieu']?.toString() ?? '',
VatLieu2: json['VatLieu2']?.toString() ?? '',
VatLieu3: json['VatLieu3']?.toString() ?? '',
GhiChu: json['GhiChu']?.toString() ?? '',
);
}
