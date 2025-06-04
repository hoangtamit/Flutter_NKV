import 'dart:convert';

tbl_PhanQuyen_V2 tbl_PhanQuyen_V2FromJson(String str) => tbl_PhanQuyen_V2.fromJson(json.decode(str));

String tbl_PhanQuyen_V2ToJson(tbl_PhanQuyen_V2 data) => json.encode(data.toJson());

class tbl_PhanQuyen_V2 {
  String? IDPhanQuyen;
  int? STT;
  String? IDGroup;
  String? IDUser;
  String? MaNhanVien;
  String? ID;
  String? ParentID;
  String? Caption;
  int? isPage;
  int? isGrouppage;
  //dynamic? Image;
  //int? ImageIndex;
  bool? View;
  bool? Add;
  bool? Edit;
  bool? Delete;
  bool? Print;
  bool? Import;
  bool? Export;
  bool? Accept;
  bool? Extra;
  String? IDKhuVuc;

  tbl_PhanQuyen_V2({
    required this.IDPhanQuyen,
    required this.STT,
    required this.IDGroup,
    required this.IDUser,
    required this.MaNhanVien,
    required this.ID,
    required this.ParentID,
    required this.Caption,
    required this.isPage,
    required this.isGrouppage,
    //required this.Image,
    //required this.ImageIndex,
    required this.View,
    required this.Add,
    required this.Edit,
    required this.Delete,
    required this.Print,
    required this.Import,
    required this.Export,
    required this.Accept,
    required this.Extra,
    required this.IDKhuVuc,
  });

  Map<String, dynamic> toJson() => {
    'IDPhanQuyen': IDPhanQuyen,
    'STT': STT,
    'IDGroup': IDGroup,
    'IDUser': IDUser,
    'MaNhanVien': MaNhanVien,
    'ID': ID,
    'ParentID': ParentID,
    'Caption': Caption,
    'isPage': isPage,
    'isGrouppage': isGrouppage,
    //'Image': Image,
    //ImageIndex': ImageIndex,
    'View': View,
    'Add': Add,
    'Edit': Edit,
    'Delete': Delete,
    'Print': Print,
    'Import': Import,
    'Export': Export,
    'Accept': Accept,
    'Extra': Extra,
    'IDKhuVuc': IDKhuVuc,
  };

  factory tbl_PhanQuyen_V2.fromJson(Map<String, dynamic> json) => tbl_PhanQuyen_V2(
    IDPhanQuyen: json['IDPhanQuyen']?.toString() ?? '',
    STT: int.tryParse(json['STT']?.toString() ?? '0') ?? 0,
    IDGroup: json['IDGroup']?.toString() ?? '',
    IDUser: json['IDUser']?.toString() ?? '',
    MaNhanVien: json['MaNhanVien']?.toString() ?? '',
    ID: json['ID']?.toString() ?? '',
    ParentID: json['ParentID']?.toString() ?? '',
    Caption: json['Caption']?.toString() ?? '',
    isPage: int.tryParse(json['isPage']?.toString() ?? '0') ?? 0,
    isGrouppage: int.tryParse(json['isGrouppage']?.toString() ?? '0') ?? 0,
    //Image: json['Image']?.toString() ?? '',
    //ImageIndex: int.tryParse(json['ImageIndex']?.toString() ?? '0') ?? 0,,
    View: json['View'] is bool ? json['View'] : false,
    Add: json['Add'] is bool ? json['Add'] : false,
    Edit: json['Edit'] is bool ? json['Edit'] : false,
    Delete: json['Delete'] is bool ? json['Delete'] : false,
    Print: json['Print'] is bool ? json['Print'] : false,
    Import: json['Import'] is bool ? json['Import'] : false,
    Export: json['Export'] is bool ? json['Export'] : false,
    Accept: json['Accept'] is bool ? json['Accept'] : false,
    Extra: json['Extra'] is bool ? json['Extra'] : false,
    IDKhuVuc: json['IDKhuVuc']?.toString() ?? '',
  );
}
