// To parse this JSON data, do
//
//     final tblGiayLon = tblGiayLonFromJson(jsonString);

import 'dart:convert';

tbl_GiayLon tblGiayLonFromJson(String str) => tbl_GiayLon.fromJson(json.decode(str));

String tblGiayLonToJson(tbl_GiayLon data) => json.encode(data.toJson());

class tbl_GiayLon {
    dynamic idGiayLon;

    tbl_GiayLon({
        this.idGiayLon,
    });

    tbl_GiayLon copyWith({
        dynamic idGiayLon,
    }) => 
        tbl_GiayLon(
            idGiayLon: idGiayLon ?? this.idGiayLon,
        );

    factory tbl_GiayLon.fromJson(Map<String, dynamic> json) => tbl_GiayLon(
        idGiayLon: json["IDGiayLon"],
    );

    Map<String, dynamic> toJson() => {
        "IDGiayLon": idGiayLon,
    };
}
