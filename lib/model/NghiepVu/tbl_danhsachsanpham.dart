// To parse this JSON data, do
//
//     final tbl_DanhSachSanPham = tbl_DanhSachSanPhamFromJson(jsonString);

import 'dart:convert';

tbl_DanhSachSanPham tbl_DanhSachSanPhamFromJson(String str) => tbl_DanhSachSanPham.fromJson(json.decode(str));

String tbl_DanhSachSanPhamToJson(tbl_DanhSachSanPham data) => json.encode(data.toJson());

class tbl_DanhSachSanPham {
  final int id;
  final String name;
  final String url;

  tbl_DanhSachSanPham({
    required this.id,
    required this.name,
    required this.url,
  });

  factory tbl_DanhSachSanPham.fromJson(Map<String, dynamic> json) => tbl_DanhSachSanPham(
    id: json["ID"],
    name: json["Name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Name": name,
    "url": url,
  };
}
