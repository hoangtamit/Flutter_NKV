import 'dart:convert';

tbl_BoPhan tbl_BoPhanFromJson(String str) => tbl_BoPhan.fromJson(json.decode(str));

String tbl_BoPhanToJson(tbl_BoPhan data) => json.encode(data.toJson());

class tbl_BoPhan {
  //final int IDBoPhan;
  final String ID;
  // final String TenBoPhan;
  // //final int IDKhoi;
  // final String DIENGIAI;
  // final bool TINHTRANG;
  // final String GHICHU;

  tbl_BoPhan({
    //required this.IDBoPhan,
    required this.ID,
    // required this.TenBoPhan,
    // //required this.IDKhoi,
    // required this.DIENGIAI,
    // required this.TINHTRANG,
    // required this.GHICHU,
  });

  Map<String, dynamic> toJson() => {
    //'IDBoPhan': IDBoPhan,
    'ID': ID,
    // 'TenBoPhan': TenBoPhan,
    // //'IDKhoi': IDKhoi,
    // 'DIENGIAI': DIENGIAI,
    // 'TINHTRANG': TINHTRANG,
    // 'GHICHU': GHICHU,
  };

  factory tbl_BoPhan.fromJson(Map<String, dynamic> json) => tbl_BoPhan(
    //IDBoPhan: json['IDBoPhan'],
    ID: json['ID']?.toString() ?? '',
    // TenBoPhan: json['TenBoPhan']?.toString() ?? '',
    // //IDKhoi: json['IDKhoi'],
    // DIENGIAI: json['DIENGIAI']?.toString() ?? '',
    // TINHTRANG: json['TINHTRANG'] is bool ? json['TINHTRANG'] : false,
    // GHICHU: json['GHICHU']?.toString() ?? '',
  );
}
