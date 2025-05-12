import 'dart:convert';

tbl_ViTri tbl_ViTriFromJson(String str) => tbl_ViTri.fromJson(json.decode(str));

String tbl_ViTriToJson(tbl_ViTri data) => json.encode(data.toJson());

class tbl_ViTri {
  // final String LoaiHang;
  // final String Ke;
  // final String Tang;
  // final String STT;
  final String ViTri;
  // final String DienGiai;
  // final String IDKhuVuc;
  // final String ViTri_Backup;
  // final String GhiChu;
  // final String CreateBy;
  // final DateTime? CreateDate;
  // final String ModifyBy;
  // final DateTime? ModifyDate;
  // final String IDViTri;

  tbl_ViTri({
    // required this.LoaiHang,
    // required this.Ke,
    // required this.Tang,
    // required this.STT,
    required this.ViTri,
    // required this.DienGiai,
    // required this.IDKhuVuc,
    // required this.ViTri_Backup,
    // required this.GhiChu,
    // required this.CreateBy,
    // required this.CreateDate,
    // required this.ModifyBy,
    // required this.ModifyDate,
    // required this.IDViTri,
  });

  Map<String, dynamic> toJson() => {
    // 'LoaiHang': LoaiHang,
    // 'Ke': Ke,
    // 'Tang': Tang,
    // 'STT': STT,
     'ViTri': ViTri,
    // 'DienGiai': DienGiai,
    // 'IDKhuVuc': IDKhuVuc,
    // 'ViTri_Backup': ViTri_Backup,
    // 'GhiChu': GhiChu,
    // 'CreateBy': CreateBy,
    // 'CreateDate': CreateDate?.toIso8601String(),
    // 'ModifyBy': ModifyBy,
    // 'ModifyDate': ModifyDate?.toIso8601String(),
    // 'IDViTri': IDViTri,
  };

  factory tbl_ViTri.fromJson(Map<String, dynamic> json) => tbl_ViTri(
    // LoaiHang: json['LoaiHang']?.toString() ?? '',
    // Ke: json['Ke']?.toString() ?? '',
    // Tang: json['Tang']?.toString() ?? '',
    // STT: json['STT']?.toString() ?? '',
    ViTri: json['ViTri']?.toString() ?? '',
    // DienGiai: json['DienGiai']?.toString() ?? '',
    // IDKhuVuc: json['IDKhuVuc']?.toString() ?? '',
    // ViTri_Backup: json['ViTri_Backup']?.toString() ?? '',
    // GhiChu: json['GhiChu']?.toString() ?? '',
    // CreateBy: json['CreateBy']?.toString() ?? '',
    // CreateDate: json['CreateDate'] != null ? DateTime.parse(json['CreateDate']) : null,
    // ModifyBy: json['ModifyBy']?.toString() ?? '',
    // ModifyDate: json['ModifyDate'] != null ? DateTime.parse(json['ModifyDate']) : null,
    // IDViTri: json['IDViTri']?.toString() ?? '',
  );
}
