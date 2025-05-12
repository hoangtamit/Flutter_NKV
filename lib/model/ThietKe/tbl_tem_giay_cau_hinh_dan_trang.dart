import 'dart:convert';

tbl_TemGiay_CauHinhDanTrang tbl_TemGiay_CauHinhDanTrangFromJson(String str) => tbl_TemGiay_CauHinhDanTrang.fromJson(json.decode(str));

String tbl_TemGiay_CauHinhDanTrangToJson(tbl_TemGiay_CauHinhDanTrang data) => json.encode(data.toJson());

class tbl_TemGiay_CauHinhDanTrang {
  //final int ID;
  //final String OrderItem;
  //final String GeneralItem;
  final int ArtboardWidth;
  final int ArtboardHeight;
  // final String Units;
  // final bool MultiDocument;
  final int ArtboardSpace;
  final int ArtboardNumber;
  // final int ArtboardColumns;
  // final String ArtboardDirection;
  //final double KGISpace;
  final double MarginLeft;
  final double MarginRight;
  final double MarginBottom;
  final double MarginTop;
  // final double BleedLeft;
  // final double BleedRight;
  // final double BleedBottom;
  // final double BleedTop;
  double Width;
  double Height;
  final double WidthPlace;
  final double HeightPlace;
  final int RK;
  //final String PlaceStyle;
  final double WidthSpace;
  final double HeightSpace;
  final double PaddingLeft;
  final double PaddingRight;
  final double PaddingBottom;
  final double PaddingTop;
  final String ColumnPosition;
  final String ColumnSpace;
  final String RowPosition;
  final String RowSpace;
  final double TrimMark_Length;
  final double TrimMark_Space;
  final double TrimMark_Thickness;
  final String TrimMark_Color;
  // final int ColorBar_Length;
  // final int ColorBar_Space;
  // final String ColorBar_Type;
  // final String Information_Style;
  // final String Information_Color;
  // final double Information_X;
  // final double Information_Y;
  // final int Information_Rotate;
  final bool Symmetry;
  final bool SelfReturn;
  final bool Rotate;
  final bool ActiveDocument;
  final String LayoutDirection;
  //final int Book;
  // final String Created_By;
  // final DateTime? Created_Date;
  // final String Modify_By;
  // final DateTime? Modify_Date;
  // final String Deleted_By;
  // final DateTime? Deleted_Date;
  String GhiChu;
  // final String IDKhuVuc;

  tbl_TemGiay_CauHinhDanTrang({
    // required this.ID,
    // required this.OrderItem,
    // required this.GeneralItem,
    required this.ArtboardWidth,
    required this.ArtboardHeight,
    // required this.Units,
    // required this.MultiDocument,
    required this.ArtboardSpace,
    required this.ArtboardNumber,
    // required this.ArtboardColumns,
    // required this.ArtboardDirection,
    // required this.KGISpace,
    required this.MarginLeft,
    required this.MarginRight,
    required this.MarginBottom,
    required this.MarginTop,
    // required this.BleedLeft,
    // required this.BleedRight,
    // required this.BleedBottom,
    // required this.BleedTop,
    required this.Width,
    required this.Height,
    required this.WidthPlace,
    required this.HeightPlace,
    required this.RK,
    // required this.PlaceStyle,
    required this.WidthSpace,
    required this.HeightSpace,
    required this.PaddingLeft,
    required this.PaddingRight,
    required this.PaddingBottom,
    required this.PaddingTop,
    required this.ColumnPosition,
    required this.ColumnSpace,
    required this.RowPosition,
    required this.RowSpace,
    required this.TrimMark_Length,
    required this.TrimMark_Space,
    required this.TrimMark_Thickness,
    required this.TrimMark_Color,
    // required this.ColorBar_Length,
    // required this.ColorBar_Space,
    // required this.ColorBar_Type,
    // required this.Information_Style,
    // required this.Information_Color,
    // required this.Information_X,
    // required this.Information_Y,
    // required this.Information_Rotate,
    required this.Symmetry,
    required this.SelfReturn,
    required this.Rotate,
    required this.ActiveDocument,
    required this.LayoutDirection,
    //required this.Book,
    // required this.Created_By,
    // required this.Created_Date,
    // required this.Modify_By,
    // required this.Modify_Date,
    // required this.Deleted_By,
    // required this.Deleted_Date,
    required this.GhiChu,
    // required this.IDKhuVuc,
  });

  Map<String, dynamic> toJson() => {
    //'ID': ID,
    //'OrderItem': OrderItem,
    //'GeneralItem': GeneralItem,
    'ArtboardWidth': ArtboardWidth,
    'ArtboardHeight': ArtboardHeight,
    //'Units': Units,
    //'MultiDocument': MultiDocument,
    'ArtboardSpace': ArtboardSpace,
    'ArtboardNumber': ArtboardNumber,
    //'ArtboardColumns': ArtboardColumns,
    //'ArtboardDirection': ArtboardDirection,
    // 'KGISpace': KGISpace,
    'MarginLeft': MarginLeft,
    'MarginRight': MarginRight,
    'MarginBottom': MarginBottom,
    'MarginTop': MarginTop,
    // 'BleedLeft': BleedLeft,
    // 'BleedRight': BleedRight,
    // 'BleedBottom': BleedBottom,
    // 'BleedTop': BleedTop,
    'Width': Width,
    'Height': Height,
    'WidthPlace': WidthPlace,
    'HeightPlace': HeightPlace,
    'RK': RK,
    // 'PlaceStyle': PlaceStyle,
    'WidthSpace': WidthSpace,
    'HeightSpace': HeightSpace,
    'PaddingLeft': PaddingLeft,
    'PaddingRight': PaddingRight,
    'PaddingBottom': PaddingBottom,
    'PaddingTop': PaddingTop,
    'ColumnPosition': ColumnPosition,
    'ColumnSpace': ColumnSpace,
    'RowPosition': RowPosition,
    'RowSpace': RowSpace,
    'TrimMark_Length': TrimMark_Length,
    'TrimMark_Space': TrimMark_Space,
    'TrimMark_Thickness': TrimMark_Thickness,
    'TrimMark_Color': TrimMark_Color,
    // 'ColorBar_Length': ColorBar_Length,
    // 'ColorBar_Space': ColorBar_Space,
    // 'ColorBar_Type': ColorBar_Type,
    // 'Information_Style': Information_Style,
    // 'Information_Color': Information_Color,
    // 'Information_X': Information_X,
    // 'Information_Y': Information_Y,
    // 'Information_Rotate': Information_Rotate,
    'Symmetry': Symmetry,
    'SelfReturn': SelfReturn,
    'Rotate': Rotate,
    'ActiveDocument': ActiveDocument,
    'LayoutDirection': LayoutDirection,
    //'Book': Book,
    // 'Created_By': Created_By,
    // 'Created_Date': Created_Date?.toIso8601String(),
    // 'Modify_By': Modify_By,
    // 'Modify_Date': Modify_Date?.toIso8601String(),
    // 'Deleted_By': Deleted_By,
    // 'Deleted_Date': Deleted_Date?.toIso8601String(),
     'GhiChu': GhiChu,
    // 'IDKhuVuc': IDKhuVuc,
  };
  factory tbl_TemGiay_CauHinhDanTrang.fromJson(Map<String, dynamic> json) => tbl_TemGiay_CauHinhDanTrang(
    // ID: json['ID'],
    // OrderItem: json['OrderItem'],
    // GeneralItem: json['GeneralItem'],
    ArtboardWidth: json['ArtboardWidth'],
    ArtboardHeight: json['ArtboardHeight'],
    // Units: json['Units'],
    // MultiDocument: json['MultiDocument'],
    ArtboardSpace: json['ArtboardSpace'],
    ArtboardNumber: json['ArtboardNumber'],
    // ArtboardColumns: json['ArtboardColumns'],
    // ArtboardDirection: json['ArtboardDirection'],
    // KGISpace: json['KGISpace'],
    MarginLeft: json['MarginLeft'],
    MarginRight: json['MarginRight'],
    MarginBottom: json['MarginBottom'],
    MarginTop: json['MarginTop'],
    // BleedLeft: json['BleedLeft'],
    // BleedRight: json['BleedRight'],
    // BleedBottom: json['BleedBottom'],
    // BleedTop: json['BleedTop'],
    Width: json['Width'],
    Height: json['Height'],
    WidthPlace: json['WidthPlace'],
    HeightPlace: json['HeightPlace'],
    RK: json['RK'],
    // PlaceStyle: json['PlaceStyle'],
    WidthSpace: json['WidthSpace'],
    HeightSpace: json['HeightSpace'],
    PaddingLeft: json['PaddingLeft'],
    PaddingRight: json['PaddingRight'],
    PaddingBottom: json['PaddingBottom'],
    PaddingTop: json['PaddingTop'],
    ColumnPosition: json['ColumnPosition'],
    ColumnSpace: json['ColumnSpace'],
    RowPosition: json['RowPosition'],
    RowSpace: json['RowSpace'],
    TrimMark_Length: json['TrimMark_Length'],
    TrimMark_Space: json['TrimMark_Space'],
    TrimMark_Thickness: json['TrimMark_Thickness'],
    TrimMark_Color: json['TrimMark_Color'],
    // ColorBar_Length: json['ColorBar_Length'],
    // ColorBar_Space: json['ColorBar_Space'],
    // ColorBar_Type: json['ColorBar_Type'],
    // Information_Style: json['Information_Style'],
    // Information_Color: json['Information_Color'],
    // Information_X: json['Information_X'],
    // Information_Y: json['Information_Y'],
    // Information_Rotate: json['Information_Rotate'],
    Symmetry: json['Symmetry'],
    SelfReturn: json['SelfReturn'],
    Rotate: json['Rotate'],
    ActiveDocument: json['ActiveDocument'],
    LayoutDirection: json['LayoutDirection'],
    //Book: json['Book'],
    // Created_By: json['Created_By'],
    // Created_Date: json['Created_Date'] != null ? DateTime.parse(json['Created_Date']) : null,
    // Modify_By: json['Modify_By'],
    // Modify_Date: json['Modify_Date'] != null ? DateTime.parse(json['Modify_Date']) : null,
    // Deleted_By: json['Deleted_By'],
    // Deleted_Date: json['Deleted_Date'] != null ? DateTime.parse(json['Deleted_Date']) : null,
    GhiChu: json['GhiChu'],
    // IDKhuVuc: json['IDKhuVuc'],
  );
}

late final tbl_TemGiay_CauHinhDanTrang CauHinh_Default = tbl_TemGiay_CauHinhDanTrang(
  ArtboardWidth: 0,  ArtboardHeight: 0,  ArtboardSpace: 20,  ArtboardNumber: 1,MarginLeft: 0,MarginRight: 0,MarginBottom: 15,MarginTop: 0,
  Width: 0,  Height: 0,  WidthPlace: 0,  HeightPlace: 0,  RK: 0,
  WidthSpace:3,HeightSpace: 3,  PaddingLeft: 1.5,  PaddingRight: 1.5,  PaddingBottom: 1.5,  PaddingTop: 1.5
  ,  ColumnPosition: "", ColumnSpace: "",  RowPosition: "",  RowSpace: "",  TrimMark_Length: 3,  TrimMark_Space: 3,  TrimMark_Thickness: 0
  ,  TrimMark_Color: "",  Symmetry: true,  SelfReturn: false,  Rotate: false,  ActiveDocument: false,  LayoutDirection: "Bottom,Left",GhiChu: ''
);
