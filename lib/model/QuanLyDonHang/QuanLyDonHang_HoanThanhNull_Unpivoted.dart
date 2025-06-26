import 'dart:convert';

QuanLyDonHang_HoanThanhNull_Unpivoted QuanLyDonHang_HoanThanhNull_UnpivotedFromJson(String str) => QuanLyDonHang_HoanThanhNull_Unpivoted.fromJson(json.decode(str));

String QuanLyDonHang_HoanThanhNull_UnpivotedToJson(QuanLyDonHang_HoanThanhNull_Unpivoted data) => json.encode(data.toJson());

class QuanLyDonHang_HoanThanhNull_Unpivoted {
String? SCD;
String? TenKhachHang;
String? BoPhan;
String? CongDoan;
int? IDTo;
DateTime? NgayXuongDon;
DateTime? NgayGiaoHang;
int? SoLuong;
bool? Nhan;
bool? HoanThanh;

QuanLyDonHang_HoanThanhNull_Unpivoted({
required this.SCD,
required this.TenKhachHang,
required this.BoPhan,
required this.CongDoan,
  required this.IDTo,
required this.NgayXuongDon,
required this.NgayGiaoHang,
required this.SoLuong,
required this.Nhan,
required this.HoanThanh,
});

Map<String, dynamic> toJson() => {
'SCD': SCD,
'TenKhachHang': TenKhachHang,
'BoPhan': BoPhan,
'CongDoan': CongDoan,
  'IDTo': IDTo,
'NgayXuongDon': NgayXuongDon?.toIso8601String(),
'NgayGiaoHang': NgayGiaoHang?.toIso8601String(),
'SoLuong': SoLuong,
'Nhan': Nhan,
'HoanThanh': HoanThanh,
};

factory QuanLyDonHang_HoanThanhNull_Unpivoted.fromJson(Map<String, dynamic> json) => QuanLyDonHang_HoanThanhNull_Unpivoted(
SCD: json['SCD']?.toString() ?? '',
TenKhachHang: json['TenKhachHang']?.toString() ?? '',
BoPhan: json['BoPhan']?.toString() ?? '',
CongDoan: json['CongDoan']?.toString() ?? ''
  ,IDTo: int.tryParse(json['IDTo']?.toString() ?? '0') ?? 0,
NgayXuongDon: DateTime.tryParse(json['NgayXuongDon'] ?? '') ?? DateTime.now(),
NgayGiaoHang: DateTime.tryParse(json['NgayGiaoHang'] ?? '') ?? DateTime.now(),
SoLuong: int.tryParse(json['SoLuong']?.toString() ?? '0') ?? 0,
Nhan:  json['Nhan'] as bool,
HoanThanh: json['HoanThanh'] as bool,
);
}
