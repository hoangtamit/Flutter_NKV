import 'dart:convert';

KhoBTP_TP_TonKho KhoBTP_TP_TonKhoFromJson(String str) => KhoBTP_TP_TonKho.fromJson(json.decode(str));

String KhoBTP_TP_TonKhoToJson(KhoBTP_TP_TonKho data) => json.encode(data.toJson());

class KhoBTP_TP_TonKho {
dynamic? IDKhoBTP_TP;
String? SCD;
String? Kho;
String? MaSanPham;
dynamic? string;
String? TenSanPham;
String? Size;
String? TenKhachHang;
String? LoaiHang;
String? DonViTinh;
String? QuyCach;
String? ViTri;
String? Lo;
dynamic? tondauky;
dynamic? tongnhap;
dynamic? tongxuat;
dynamic? toncuoiky;
String? IDKhuVuc;

KhoBTP_TP_TonKho({
required this.IDKhoBTP_TP,
required this.SCD,
required this.Kho,
required this.MaSanPham,
required this.string,
required this.TenSanPham,
required this.Size,
required this.TenKhachHang,
required this.LoaiHang,
required this.DonViTinh,
required this.QuyCach,
required this.ViTri,
required this.Lo,
required this.tondauky,
required this.tongnhap,
required this.tongxuat,
required this.toncuoiky,
required this.IDKhuVuc,
});

Map<String, dynamic> toJson() => {
'IDKhoBTP_TP': IDKhoBTP_TP,
'SCD': SCD,
'Kho': Kho,
'MaSanPham': MaSanPham,
'string': string,
'TenSanPham': TenSanPham,
'Size': Size,
'TenKhachHang': TenKhachHang,
'LoaiHang': LoaiHang,
'DonViTinh': DonViTinh,
'QuyCach': QuyCach,
'ViTri': ViTri,
'Lo': Lo,
'tondauky': tondauky,
'tongnhap': tongnhap,
'tongxuat': tongxuat,
'toncuoiky': toncuoiky,
'IDKhuVuc': IDKhuVuc,
};

factory KhoBTP_TP_TonKho.fromJson(Map<String, dynamic> json) => KhoBTP_TP_TonKho(
IDKhoBTP_TP: json['IDKhoBTP_TP']?.toString() ?? '',
SCD: json['SCD']?.toString() ?? '',
Kho: json['Kho']?.toString() ?? '',
MaSanPham: json['MaSanPham']?.toString() ?? '',
string: json['string']?.toString() ?? '',
TenSanPham: json['TenSanPham']?.toString() ?? '',
Size: json['Size']?.toString() ?? '',
TenKhachHang: json['TenKhachHang']?.toString() ?? '',
LoaiHang: json['LoaiHang']?.toString() ?? '',
DonViTinh: json['DonViTinh']?.toString() ?? '',
QuyCach: json['QuyCach']?.toString() ?? '',
ViTri: json['ViTri']?.toString() ?? '',
Lo: json['Lo']?.toString() ?? '',
tondauky: double.tryParse(json['tondauky']?.toString() ?? '0') ?? 0,
tongnhap: double.tryParse(json['tongnhap']?.toString() ?? '0') ?? 0,
tongxuat: double.tryParse(json['tongxuat']?.toString() ?? '0') ?? 0,
toncuoiky: double.tryParse(json['toncuoiky']?.toString() ?? '0') ?? 0,
IDKhuVuc: json['IDKhuVuc']?.toString() ?? '',
);
}
