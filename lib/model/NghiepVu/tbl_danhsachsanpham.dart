import 'dart:convert';

tbl_DanhSachSanPham tbl_DanhSachSanPhamFromJson(String str) => tbl_DanhSachSanPham.fromJson(json.decode(str));

String tbl_DanhSachSanPhamToJson(tbl_DanhSachSanPham data) => json.encode(data.toJson());

class tbl_DanhSachSanPham {
  String? IDSanPham;
  String MaSanPham;
  String? TenKhachHang;
  String? TenSanPham;
  String? Alias;
  String? KichThuoc;
  String? BoPhan;
  String? LoaiSanPham;
  String? Kho;
  String? VatLieu;
  String? VatLieu2;
  String? VatLieu3;
  String? MaVatLieu1;
  String? MaVatLieu2;
  String? MaVatLieu3;
  String? MauMatPhai;
  String? MauMatTrai;
  String? PhuongPhapIn;
  String? GiaCongMatPhai;
  String? GiaCongMatTrai;
  String? PhuongPhapCat;
  String? GiaCongSauInMatPhai;
  String? GiaCongSauInMatTrai;
  String? BoGoc;
  String? DucLo;
  String? ChamCatDapHop;
  String? LoaiChi;
  String? DoDai;
  String? InChu_MaVach;
  String? Khac;
  String? CongDoanSanXuat;
  String? CongDoanKiemPham;
  String? ChuY;
  String? Layout_MT;
  String? Layout_MS;
  String? Khuon_MT;
  String? Khuon_MS;
  String? IDKhuVuc;
  String? CreateBy;
  DateTime? CreateDate;
  String? ModifyBy;
  DateTime? ModifyDate;
  String? Note;

  tbl_DanhSachSanPham({
    required this.IDSanPham,
    required this.MaSanPham,
    required this.TenKhachHang,
    required this.TenSanPham,
    required this.Alias,
    required this.KichThuoc,
    required this.BoPhan,
    required this.LoaiSanPham,
    required this.Kho,
    required this.VatLieu,
    required this.VatLieu2,
    required this.VatLieu3,
    required this.MaVatLieu1,
    required this.MaVatLieu2,
    required this.MaVatLieu3,
    required this.MauMatPhai,
    required this.MauMatTrai,
    required this.PhuongPhapIn,
    required this.GiaCongMatPhai,
    required this.GiaCongMatTrai,
    required this.PhuongPhapCat,
    required this.GiaCongSauInMatPhai,
    required this.GiaCongSauInMatTrai,
    required this.BoGoc,
    required this.DucLo,
    required this.ChamCatDapHop,
    required this.LoaiChi,
    required this.DoDai,
    required this.InChu_MaVach,
    required this.Khac,
    required this.CongDoanSanXuat,
    required this.CongDoanKiemPham,
    required this.ChuY,
    required this.Layout_MT,
    required this.Layout_MS,
    required this.Khuon_MT,
    required this.Khuon_MS,
    required this.IDKhuVuc,
    required this.CreateBy,
    required this.CreateDate,
    required this.ModifyBy,
    required this.ModifyDate,
    required this.Note,
  });

  Map<String, dynamic> toJson() => {
    'IDSanPham': IDSanPham,
    'MaSanPham': MaSanPham,
    'TenKhachHang': TenKhachHang,
    'TenSanPham': TenSanPham,
    'Alias': Alias,
    'KichThuoc': KichThuoc,
    'BoPhan': BoPhan,
    'LoaiSanPham': LoaiSanPham,
    'Kho': Kho,
    'VatLieu': VatLieu,
    'VatLieu2': VatLieu2,
    'VatLieu3': VatLieu3,
    'MaVatLieu1': MaVatLieu1,
    'MaVatLieu2': MaVatLieu2,
    'MaVatLieu3': MaVatLieu3,
    'MauMatPhai': MauMatPhai,
    'MauMatTrai': MauMatTrai,
    'PhuongPhapIn': PhuongPhapIn,
    'GiaCongMatPhai': GiaCongMatPhai,
    'GiaCongMatTrai': GiaCongMatTrai,
    'PhuongPhapCat': PhuongPhapCat,
    'GiaCongSauInMatPhai': GiaCongSauInMatPhai,
    'GiaCongSauInMatTrai': GiaCongSauInMatTrai,
    'BoGoc': BoGoc,
    'DucLo': DucLo,
    'ChamCatDapHop': ChamCatDapHop,
    'LoaiChi': LoaiChi,
    'DoDai': DoDai,
    'InChu_MaVach': InChu_MaVach,
    'Khac': Khac,
    'CongDoanSanXuat': CongDoanSanXuat,
    'CongDoanKiemPham': CongDoanKiemPham,
    'ChuY': ChuY,
    'Layout_MT': Layout_MT,
    'Layout_MS': Layout_MS,
    'Khuon_MT': Khuon_MT,
    'Khuon_MS': Khuon_MS,
    'IDKhuVuc': IDKhuVuc,
    'CreateBy': CreateBy,
    'CreateDate': CreateDate?.toIso8601String(),
    'ModifyBy': ModifyBy,
    'ModifyDate': ModifyDate?.toIso8601String(),
    'Note': Note,
  };

  factory tbl_DanhSachSanPham.fromJson(Map<String, dynamic> json) => tbl_DanhSachSanPham(
    IDSanPham: json['IDSanPham']?.toString() ?? '',
    MaSanPham: json['MaSanPham']?.toString() ?? '',
    TenKhachHang: json['TenKhachHang']?.toString() ?? '',
    TenSanPham: json['TenSanPham']?.toString() ?? '',
    Alias: json['Alias']?.toString() ?? '',
    KichThuoc: json['KichThuoc']?.toString() ?? '',
    BoPhan: json['BoPhan']?.toString() ?? '',
    LoaiSanPham: json['LoaiSanPham']?.toString() ?? '',
    Kho: json['Kho']?.toString() ?? '',
    VatLieu: json['VatLieu']?.toString() ?? '',
    VatLieu2: json['VatLieu2']?.toString() ?? '',
    VatLieu3: json['VatLieu3']?.toString() ?? '',
    MaVatLieu1: json['MaVatLieu1']?.toString() ?? '',
    MaVatLieu2: json['MaVatLieu2']?.toString() ?? '',
    MaVatLieu3: json['MaVatLieu3']?.toString() ?? '',
    MauMatPhai: json['MauMatPhai']?.toString() ?? '',
    MauMatTrai: json['MauMatTrai']?.toString() ?? '',
    PhuongPhapIn: json['PhuongPhapIn']?.toString() ?? '',
    GiaCongMatPhai: json['GiaCongMatPhai']?.toString() ?? '',
    GiaCongMatTrai: json['GiaCongMatTrai']?.toString() ?? '',
    PhuongPhapCat: json['PhuongPhapCat']?.toString() ?? '',
    GiaCongSauInMatPhai: json['GiaCongSauInMatPhai']?.toString() ?? '',
    GiaCongSauInMatTrai: json['GiaCongSauInMatTrai']?.toString() ?? '',
    BoGoc: json['BoGoc']?.toString() ?? '',
    DucLo: json['DucLo']?.toString() ?? '',
    ChamCatDapHop: json['ChamCatDapHop']?.toString() ?? '',
    LoaiChi: json['LoaiChi']?.toString() ?? '',
    DoDai: json['DoDai']?.toString() ?? '',
    InChu_MaVach: json['InChu_MaVach']?.toString() ?? '',
    Khac: json['Khac']?.toString() ?? '',
    CongDoanSanXuat: json['CongDoanSanXuat']?.toString() ?? '',
    CongDoanKiemPham: json['CongDoanKiemPham']?.toString() ?? '',
    ChuY: json['ChuY']?.toString() ?? '',
    Layout_MT: json['Layout_MT']?.toString() ?? '',
    Layout_MS: json['Layout_MS']?.toString() ?? '',
    Khuon_MT: json['Khuon_MT']?.toString() ?? '',
    Khuon_MS: json['Khuon_MS']?.toString() ?? '',
    IDKhuVuc: json['IDKhuVuc']?.toString() ?? '',
    CreateBy: json['CreateBy']?.toString() ?? '',
    CreateDate: DateTime.tryParse(json['CreateDate'] ?? '') ?? DateTime.now(),
    ModifyBy: json['ModifyBy']?.toString() ?? '',
    ModifyDate: DateTime.tryParse(json['ModifyDate'] ?? '') ?? DateTime.now(),
    Note: json['Note']?.toString() ?? '',
  );
}
