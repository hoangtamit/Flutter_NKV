import 'dart:convert';

ThongTinDanTrang_V2 thongTinDanTrangV2FromJson(String str) => ThongTinDanTrang_V2.fromJson(json.decode(str));

String thongTinDanTrangV2ToJson(ThongTinDanTrang_V2 data) => json.encode(data.toJson());

class ThongTinDanTrang_V2 {
  dynamic kichThuoc;
  dynamic kgi;
  dynamic dt;
  dynamic giayLon;
  //bool? xoGiay;
  dynamic catGiay;
  int? rk;
  int kgITong;

  ThongTinDanTrang_V2({
    this.kichThuoc,
    this.kgi,this.dt,
    this.giayLon,
    //this.xoGiay,
    this.catGiay,
    this.rk,
    required this.kgITong,
  });

  ThongTinDanTrang_V2 copyWith({
    dynamic kichThuoc,
    dynamic kgi,dynamic dt,
    dynamic giayLon,
    //bool? xoGiay,
    dynamic catGiay,
    int? rk,
    int? kgITong,
  }) =>
      ThongTinDanTrang_V2(
        kichThuoc: kichThuoc ?? this.kichThuoc,
        kgi: kgi ?? this.kgi,
        giayLon: giayLon ?? this.giayLon,
        //xoGiay: xoGiay ?? this.xoGiay,
        catGiay: catGiay ?? this.catGiay,
        rk: rk ?? this.rk,
        kgITong: kgITong ?? this.kgITong,
      );

  factory ThongTinDanTrang_V2.fromJson(Map<String, dynamic> json) => ThongTinDanTrang_V2(
    kichThuoc: json["KichThuoc"],
    kgi: json["KGI"],
    dt: json["DT"],
    giayLon: json["GiayLon"],
    //xoGiay: json["XoGiay"],
    catGiay: json["CatGiay"],
    rk: json["RK"],
    kgITong: json["KGI_TONG"],
  );

  Map<String, dynamic> toJson() => {
    "KichThuoc": kichThuoc,
    "KGI": kgi,
    "DT": dt,
    "GiayLon": giayLon,
    //"XoGiay": xoGiay,
    "CatGiay": catGiay,
    "RK": rk,
    "KGI_TONG": kgITong,
  };
}
