import 'dart:convert';

tbl_Avery_GiaoHang tbl_Avery_GiaoHangFromJson(String str) => tbl_Avery_GiaoHang.fromJson(json.decode(str));

String tbl_Avery_GiaoHangToJson(tbl_Avery_GiaoHang data) => json.encode(data.toJson());

class tbl_Avery_GiaoHang {
  final String ID_Avery_GiaoHang;
  final String No;
  final String MaPhieuGiaoHang;
  final String Item;
  final String Description;
  final String UOM;
  final String RequestedQuantity;
  final String MaterialCategory;
  final String ApprovalStatus;
  final String Remark;
  final String SOLine;
  final String RequestTime;
  final String IDKhuVuc;
  final bool isNhapKho;
  final String IDVatLieu;
  final String TenHangHoa;
  final String DonViTinh;
  final String QuyCach;

  tbl_Avery_GiaoHang({
    required this.ID_Avery_GiaoHang,
    required this.No,
    required this.MaPhieuGiaoHang,
    required this.Item,
    required this.Description,
    required this.UOM,
    required this.RequestedQuantity,
    required this.MaterialCategory,
    required this.ApprovalStatus,
    required this.Remark,
    required this.SOLine,
    required this.RequestTime,
    required this.IDKhuVuc,
    required this.isNhapKho,
    required this.IDVatLieu,
    required this.TenHangHoa,
    required this.DonViTinh,
    required this.QuyCach,
  });

  Map<String, dynamic> toJson() => {
    'ID_Avery_GiaoHang': ID_Avery_GiaoHang,
    'No': No,
    'MaPhieuGiaoHang': MaPhieuGiaoHang,
    'Item': Item,
    'Description': Description,
    'UOM': UOM,
    'RequestedQuantity': RequestedQuantity,
    'MaterialCategory': MaterialCategory,
    'ApprovalStatus': ApprovalStatus,
    'Remark': Remark,
    'SOLine': SOLine,
    'RequestTime': RequestTime,
    'IDKhuVuc': IDKhuVuc,
    'isNhapKho': isNhapKho,
    'IDVatLieu': IDVatLieu,
    'TenHangHoa': TenHangHoa,
    'DonViTinh': DonViTinh,
    'QuyCach': QuyCach,
  };

  factory tbl_Avery_GiaoHang.fromJson(Map<String, dynamic> json) => tbl_Avery_GiaoHang(
    ID_Avery_GiaoHang: json['ID_Avery_GiaoHang']?.toString() ?? '',
    No: json['No']?.toString() ?? '',
    MaPhieuGiaoHang: json['MaPhieuGiaoHang']?.toString() ?? '',
    Item: json['Item']?.toString() ?? '',
    Description: json['Description']?.toString() ?? '',
    UOM: json['UOM']?.toString() ?? '',
    RequestedQuantity: json['RequestedQuantity']?.toString() ?? '',
    MaterialCategory: json['MaterialCategory']?.toString() ?? '',
    ApprovalStatus: json['ApprovalStatus']?.toString() ?? '',
    Remark: json['Remark']?.toString() ?? '',
    SOLine: json['SOLine']?.toString() ?? '',
    RequestTime: json['RequestTime']?.toString() ?? '',
    IDKhuVuc: json['IDKhuVuc']?.toString() ?? '',
    isNhapKho: json['isNhapKho'] is bool ? json['isNhapKho'] : false, // Xử lý trường bool
    IDVatLieu: json['IDVatLieu']?.toString() ?? '',
    TenHangHoa: json['TenHangHoa']?.toString() ?? '',
    DonViTinh: json['DonViTinh']?.toString() ?? '',
    QuyCach: json['QuyCach']?.toString() ?? '',
  );
}
