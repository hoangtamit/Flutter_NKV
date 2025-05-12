import 'dart:convert';

KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetXuat   KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetXuatFromJson(String str) =>   KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetXuat.fromJson(json.decode(str));
String   KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetXuatToJson(  KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetXuat data) => json.encode(data.toJson());

class   KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetXuat {
final String MaPhieu;
final String BoPhan;
final String Kho;
final String ThaoTac;
final DateTime Ngay;
final String NguoiQuanKho;
final int TongSoLuong;
final int SoLuongVatLieu;
final bool isActive;
final bool isEnable;

 KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetXuat({
required this.MaPhieu,
required this.BoPhan,
required this.Kho,
required this.ThaoTac,
required this.Ngay,
required this.NguoiQuanKho,
required this.TongSoLuong,
required this.SoLuongVatLieu,
required this.isActive,
required this.isEnable,
});

Map<String, dynamic> toJson() => {
'MaPhieu': MaPhieu,
'BoPhan': BoPhan,
'Kho': Kho,
'ThaoTac': ThaoTac,
'Ngay': Ngay,
'NguoiQuanKho': NguoiQuanKho,
'TongSoLuong': TongSoLuong,
'SoLuongVatLieu': SoLuongVatLieu,
'isActive': isActive,
'isEnable': isEnable,
};

factory   KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetXuat.fromJson(Map<String, dynamic> json) =>   KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetXuat(
MaPhieu: json['MaPhieu']?.toString() ?? '',
BoPhan: json['BoPhan']?.toString() ?? '',
Kho: json['Kho']?.toString() ?? '',
ThaoTac: json['ThaoTac']?.toString() ?? '',
Ngay: DateTime.tryParse(json['Ngay'] ?? '') ?? DateTime.now(),
NguoiQuanKho: json['NguoiQuanKho']?.toString() ?? '',
TongSoLuong: json['TongSoLuong'],
SoLuongVatLieu: json['SoLuongVatLieu'],
isActive: json['isActive'] ?? false,
isEnable: json['isEnable'] ?? false,
);
}
