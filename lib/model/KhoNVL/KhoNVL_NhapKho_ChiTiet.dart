import 'dart:convert';

KhoNVL_NhapKho_ChiTiet KhoNVL_NhapKho_ChiTietFromJson(String str) => KhoNVL_NhapKho_ChiTiet.fromJson(json.decode(str));

String KhoNVL_NhapKho_ChiTietToJson(KhoNVL_NhapKho_ChiTiet data) => json.encode(data.toJson());

class KhoNVL_NhapKho_ChiTiet {
  final dynamic IDPO;
  final dynamic ID_Avery_GiaoHang;
  final dynamic ID_Avery_TemVai_TamUng;
  final dynamic IDKhoNVL;
  final String MaPO;
  final String MaPhieu;
  final String MaKhoNVL;
  final String SCD;
  final String ThaoTac;
  final String Kho;
  final String Lo;
  final String IDVatLieu;
  final String MaVatLieu;
  final String MaSanPham;
  final dynamic SoLuongNhap;
  final String ViTri;
  final String LoaiHang;
  final String MaAvery;
  final String TenHangHoa;
  final String TenSanPham;
  final String DonViTinh;
  final String QuyCach;
  final String KhoGiayIn;
  final int IDNhaCungCap;
  final String NhaCungCap;
  final String BoPhan;
  final DateTime HanSuDung;
  final String GhiChu;
  final DateTime Ngay;
  final String NguoiQuanKho;
  final int SoLuongTamUng;

  KhoNVL_NhapKho_ChiTiet({
    required this.IDPO,
    required this.ID_Avery_GiaoHang,
    required this.ID_Avery_TemVai_TamUng,
    required this.IDKhoNVL,
    required this.MaPO,
    required this.MaPhieu,
    required this.MaKhoNVL,
    required this.SCD,
    required this.ThaoTac,
    required this.Kho,
    required this.Lo,
    required this.IDVatLieu,
    required this.MaVatLieu,
    required this.MaSanPham,
    required this.SoLuongNhap,
    required this.ViTri,
    required this.LoaiHang,
    required this.MaAvery,
    required this.TenHangHoa,
    required this.TenSanPham,
    required this.DonViTinh,
    required this.QuyCach,
    required this.KhoGiayIn,
    required this.IDNhaCungCap,
    required this.NhaCungCap,
    required this.BoPhan,
    required this.HanSuDung,
    required this.GhiChu,
    required this.Ngay,
    required this.NguoiQuanKho,
    required this.SoLuongTamUng,
  });

  Map<String, dynamic> toJson() => {
    'IDPO': IDPO,
    'ID_Avery_GiaoHang': ID_Avery_GiaoHang,
    'ID_Avery_TemVai_TamUng': ID_Avery_TemVai_TamUng,
    'IDKhoNVL': IDKhoNVL,
    'MaPO': MaPO,
    'MaPhieu': MaPhieu,
    'MaKhoNVL': MaKhoNVL,
    'SCD': SCD,
    'ThaoTac': ThaoTac,
    'Kho': Kho,
    'Lo': Lo,
    'IDVatLieu': IDVatLieu,
    'MaVatLieu': MaVatLieu,
    'MaSanPham': MaSanPham,
    'SoLuongNhap': SoLuongNhap,
    'ViTri': ViTri,
    'LoaiHang': LoaiHang,
    'MaAvery': MaAvery,
    'TenHangHoa': TenHangHoa,
    'TenSanPham': TenSanPham,
    'DonViTinh': DonViTinh,
    'QuyCach': QuyCach,
    'KhoGiayIn': KhoGiayIn,
    'IDNhaCungCap': IDNhaCungCap,
    'NhaCungCap': NhaCungCap,
    'BoPhan': BoPhan,
    'HanSuDung': HanSuDung,
    'GhiChu': GhiChu,
    'Ngay': Ngay,
    'NguoiQuanKho': NguoiQuanKho,
    'SoLuongTamUng': SoLuongTamUng,
  };

  factory KhoNVL_NhapKho_ChiTiet.fromJson(Map<String, dynamic> json) => KhoNVL_NhapKho_ChiTiet(
    IDPO: json['IDPO']?.toString() ?? '',
    ID_Avery_GiaoHang: json['ID_Avery_GiaoHang']?.toString() ?? '',
    ID_Avery_TemVai_TamUng: json['ID_Avery_TemVai_TamUng']?.toString() ?? '',
    IDKhoNVL: json['IDKhoNVL']?.toString() ?? '',
    MaPO: json['MaPO']?.toString() ?? '',
    MaPhieu: json['MaPhieu']?.toString() ?? '',
    MaKhoNVL: json['MaKhoNVL']?.toString() ?? '',
    SCD: json['SCD']?.toString() ?? '',
    ThaoTac: json['ThaoTac']?.toString() ?? '',
    Kho: json['Kho']?.toString() ?? '',
    Lo: json['Lo']?.toString() ?? '',
    IDVatLieu: json['IDVatLieu']?.toString() ?? '',
    MaVatLieu: json['MaVatLieu']?.toString() ?? '',
    MaSanPham: json['MaSanPham']?.toString() ?? '',
    SoLuongNhap: json['SoLuongNhap'],
    ViTri: json['ViTri']?.toString() ?? '',
    LoaiHang: json['LoaiHang']?.toString() ?? '',
    MaAvery: json['MaAvery']?.toString() ?? '',
    TenHangHoa: json['TenHangHoa']?.toString() ?? '',
    TenSanPham: json['TenSanPham']?.toString() ?? '',
    DonViTinh: json['DonViTinh']?.toString() ?? '',
    QuyCach: json['QuyCach']?.toString() ?? '',
    KhoGiayIn: json['KhoGiayIn']?.toString() ?? '',
    IDNhaCungCap: json['IDNhaCungCap'],
    NhaCungCap: json['NhaCungCap']?.toString() ?? '',
    BoPhan: json['BoPhan']?.toString() ?? '',
    //HanSuDung: DateTime.tryParse(json['HanSuDung']) ?? '') ?? DateTime.now(),
      HanSuDung: DateTime.tryParse(json['HanSuDung'] ?? '') ?? DateTime.now(),

    GhiChu: json['GhiChu']?.toString() ?? '',
    Ngay: DateTime.tryParse(json['Ngay'] ?? '') ?? DateTime.now(),
    NguoiQuanKho: json['NguoiQuanKho']?.toString() ?? '',
    SoLuongTamUng: json['SoLuongTamUng'],
  );
}
