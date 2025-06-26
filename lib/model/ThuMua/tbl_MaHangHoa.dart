import 'dart:convert';

tbl_MaHangHoa tbl_MaHangHoaFromJson(String str) => tbl_MaHangHoa.fromJson(json.decode(str));

String tbl_MaHangHoaToJson(tbl_MaHangHoa data) => json.encode(data.toJson());

class tbl_MaHangHoa {
  String IDMaHang;
  String DIENGIAI;
  String? TINHTRANG;
  String? GHICHU;

  tbl_MaHangHoa({
    required this.IDMaHang,
    required this.DIENGIAI,
    required this.TINHTRANG,
    required this.GHICHU,
  });

  Map<String, dynamic> toJson() => {
    'IDMaHang': IDMaHang,
    'DIENGIAI': DIENGIAI,
    'TINHTRANG': TINHTRANG,
    'GHICHU': GHICHU,
  };

  factory tbl_MaHangHoa.fromJson(Map<String, dynamic> json) => tbl_MaHangHoa(
    IDMaHang: json['IDMaHang']?.toString() ?? '',
    DIENGIAI: json['DIENGIAI']?.toString() ?? '',
    TINHTRANG: json['TINHTRANG']?.toString() ?? '',
    GHICHU: json['GHICHU']?.toString() ?? '',
  );
}
