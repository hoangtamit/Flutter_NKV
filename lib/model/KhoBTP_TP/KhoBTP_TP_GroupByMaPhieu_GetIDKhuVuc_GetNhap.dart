import 'dart:convert';

KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetNhap KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetNhapFromJson(String str) => KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetNhap.fromJson(json.decode(str));

String KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetNhapToJson(KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetNhap data) => json.encode(data.toJson());

class KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetNhap {
String? MaPhieu;
String? Lo;
String? Nguon;
String? Kho;
String? ThaoTac;
DateTime? Ngay;
int? TongSoLuong;
int? SoLuongSanPham;
String? NhanVien;
bool? isEnable;
String? TrangThai;

KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetNhap({
required this.MaPhieu,
required this.Lo,
required this.Nguon,
required this.Kho,
required this.ThaoTac,
required this.Ngay,
required this.TongSoLuong,
required this.SoLuongSanPham,
required this.NhanVien,
required this.isEnable,
required this.TrangThai,
});

Map<String, dynamic> toJson() => {
'MaPhieu': MaPhieu,
'Lo': Lo,
'Nguon': Nguon,
'Kho': Kho,
'ThaoTac': ThaoTac,
'Ngay': Ngay,
'TongSoLuong': TongSoLuong,
'SoLuongSanPham': SoLuongSanPham,
'NhanVien': NhanVien,
'isEnable': isEnable,
'TrangThai': TrangThai,
};

factory KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetNhap.fromJson(Map<String, dynamic> json) => KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetNhap(
MaPhieu: json['MaPhieu']?.toString() ?? '',
Lo: json['Lo']?.toString() ?? '',
Nguon: json['Nguon']?.toString() ?? '',
Kho: json['Kho']?.toString() ?? '',
ThaoTac: json['ThaoTac']?.toString() ?? '',
Ngay: DateTime.tryParse(json['Ngay'] ?? '') ?? DateTime.now(),
TongSoLuong: int.tryParse(json['TongSoLuong']?.toString() ?? '0') ?? 0,
SoLuongSanPham: int.tryParse(json['SoLuongSanPham']?.toString() ?? '0') ?? 0,
NhanVien: json['NhanVien']?.toString() ?? '',
isEnable: json['isEnable']?.toString() == 'true' ? true : false,
TrangThai: json['TrangThai']?.toString() ?? '',
);
}
