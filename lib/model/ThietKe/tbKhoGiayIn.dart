// To parse this JSON data, do
//
//     final tblKhoGiayIn = tblKhoGiayInFromJson(jsonString);

import 'dart:convert';

tbKhoGiayIn tblKhoGiayInFromJson(String str) => tbKhoGiayIn.fromJson(json.decode(str));

String tblKhoGiayInToJson(tbKhoGiayIn data) => json.encode(data.toJson());

class tbKhoGiayIn {
  dynamic giayLon;
  dynamic catGiay;
  dynamic khoGiayIn;
  dynamic xoGiay;
  dynamic chiTietGiay;

  tbKhoGiayIn({
    this.giayLon,
    this.catGiay,
    this.khoGiayIn,
    this.xoGiay,
    this.chiTietGiay,
  });

  tbKhoGiayIn copyWith({
    dynamic giayLon,
    dynamic catGiay,
    dynamic khoGiayIn,
    dynamic xoGiay,
    dynamic chiTietGiay,
  }) =>
      tbKhoGiayIn(
        giayLon: giayLon ?? this.giayLon,
        catGiay: catGiay ?? this.catGiay,
        khoGiayIn: khoGiayIn ?? this.khoGiayIn,
        xoGiay: xoGiay ?? this.xoGiay,
        chiTietGiay: chiTietGiay ?? this.chiTietGiay,
      );

  factory tbKhoGiayIn.fromJson(Map<String, dynamic> json) => tbKhoGiayIn(
    giayLon: json["GiayLon"],
    catGiay: json["CatGiay"],
    khoGiayIn: json["KhoIn"],
    xoGiay: json["XoGiay"],
    chiTietGiay: json["ChiTietGiay"],
  );

  Map<String, dynamic> toJson() => {
    "GiayLon": giayLon,
    "CatGiay": catGiay,
    "KhoIn": khoGiayIn,
    "XoGiay": xoGiay,
    "ChiTietGiay": chiTietGiay,
  };
}
