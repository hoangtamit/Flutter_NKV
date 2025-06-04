import 'dart:convert';

SanPham_Get4C SanPham_Get4CFromJson(String str) => SanPham_Get4C.fromJson(json.decode(str));

String SanPham_Get4CToJson(SanPham_Get4C data) => json.encode(data.toJson());

class SanPham_Get4C {
String? MaSanPham;
String? TenSanPham;
String? TenKhachHang;
String? KichThuoc;

SanPham_Get4C({
required this.MaSanPham,
required this.TenSanPham,
required this.TenKhachHang,
required this.KichThuoc,
});

Map<String, dynamic> toJson() => {
'MaSanPham': MaSanPham,
'TenSanPham': TenSanPham,
'TenKhachHang': TenKhachHang,
'KichThuoc': KichThuoc,
};

factory SanPham_Get4C.fromJson(Map<String, dynamic> json) => SanPham_Get4C(
MaSanPham: json['MaSanPham']?.toString() ?? '',
TenSanPham: json['TenSanPham']?.toString() ?? '',
TenKhachHang: json['TenKhachHang']?.toString() ?? '',
KichThuoc: json['KichThuoc']?.toString() ?? '',
);
}
