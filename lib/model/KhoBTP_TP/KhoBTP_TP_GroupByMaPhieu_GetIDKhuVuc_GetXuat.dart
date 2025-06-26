import 'dart:convert';

KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuatFromJson(String str) => KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat.fromJson(json.decode(str));

String KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuatToJson(KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat data) => json.encode(data.toJson());

class KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat {
String? MaPhieu;
String? Nguon;
String? Kho;
String? ThaoTac;
DateTime? Ngay;
String? NhanVien;
int? TongSoLuong;
int? SoLuongSanPham;
bool? isActive;
bool? isEnable;

KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat({
required this.MaPhieu,
required this.Nguon,
required this.Kho,
required this.ThaoTac,
required this.Ngay,
required this.NhanVien,
required this.TongSoLuong,
required this.SoLuongSanPham,
required this.isActive,
required this.isEnable,
});

Map<String, dynamic> toJson() => {
'MaPhieu': MaPhieu,
'Nguon': Nguon,
'Kho': Kho,
'ThaoTac': ThaoTac,
'Ngay': Ngay,
'NhanVien': NhanVien,
'TongSoLuong': TongSoLuong,
'SoLuongSanPham': SoLuongSanPham,
'isActive': isActive,
'isEnable': isEnable,
};

factory KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat.fromJson(Map<String, dynamic> json) => KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat(
MaPhieu: json['MaPhieu']?.toString() ?? '',
Nguon: json['Nguon']?.toString() ?? '',
Kho: json['Kho']?.toString() ?? '',
ThaoTac: json['ThaoTac']?.toString() ?? '',
Ngay: DateTime.tryParse(json['Ngay'] ?? '') ?? DateTime.now(),
NhanVien: json['NhanVien']?.toString() ?? '',
TongSoLuong: int.tryParse(json['TongSoLuong']?.toString() ?? '0') ?? 0,
SoLuongSanPham: int.tryParse(json['SoLuongSanPham']?.toString() ?? '0') ?? 0,
isActive: json['isActive']?.toString() == 'true' ? true : false,
  isEnable: json['isEnable']?.toString() == 'true' ? true : false,
);
}
