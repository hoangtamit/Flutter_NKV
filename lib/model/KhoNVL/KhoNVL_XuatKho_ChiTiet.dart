import 'dart:convert';

KhoNVL_XuatKho_ChiTiet KhoNVL_XuatKho_ChiTietFromJson(String str) => KhoNVL_XuatKho_ChiTiet.fromJson(json.decode(str));

String KhoNVL_XuatKho_ChiTietToJson(KhoNVL_XuatKho_ChiTiet data) => json.encode(data.toJson());

class KhoNVL_XuatKho_ChiTiet {
  final dynamic IDPhieuLanhLieu;
  final dynamic IDTheoDoiCapPhatLieu_ChiTiet;
  final dynamic IDTheoDoiCapPhatLieu;
  final dynamic ID_Avery_TemVai_TamUng;
  final dynamic IDPO;
  final dynamic IDKhoNVL;
  final String SCD;
  final String MaPhieu;
  final String MaKhoNVL;
  final String IDVatLieu;
  final String MaVatLieu;
  final String MaAvery;
  final String TenHangHoa;
  final double SoLuongTinhLieu;
  final double SoLuongXuat;
  final double SoLuongCuon;
  final String MaPO;
  final String ViTri;
  final String Lo;
  final String DonViTinh;
  final String QuyCach;
  final DateTime HanSuDung;
  final String GhiChu;
  final int SttTinhLieu;
  final String IDKhuVuc;
  final String LoaiHang;
  final String BoPhan;
  final String Kho;
  final DateTime Ngay;
  final bool isEnable;
  final bool isTinh;
  final bool isXuatKho;

  KhoNVL_XuatKho_ChiTiet({
    required this.IDPhieuLanhLieu,
    required this.IDTheoDoiCapPhatLieu_ChiTiet,
    required this.IDTheoDoiCapPhatLieu,
    required this.ID_Avery_TemVai_TamUng,
    required this.IDPO,
    required this.IDKhoNVL,
    required this.SCD,
    required this.MaPhieu,
    required this.MaKhoNVL,
    required this.IDVatLieu,
    required this.MaVatLieu,
    required this.MaAvery,
    required this.TenHangHoa,
    required this.SoLuongTinhLieu,
    required this.SoLuongXuat,
    required this.SoLuongCuon,
    required this.MaPO,
    required this.ViTri,
    required this.Lo,
    required this.DonViTinh,
    required this.QuyCach,
    required this.HanSuDung,
    required this.GhiChu,
    required this.SttTinhLieu,
    required this.IDKhuVuc,
    required this.LoaiHang,
    required this.BoPhan,
    required this.Kho,
    required this.Ngay,
    required this.isEnable,
    required this.isTinh,
    required this.isXuatKho,
  });

  Map<String, dynamic> toJson() => {
    'IDPhieuLanhLieu': IDPhieuLanhLieu,
    'IDTheoDoiCapPhatLieu_ChiTiet': IDTheoDoiCapPhatLieu_ChiTiet,
    'IDTheoDoiCapPhatLieu': IDTheoDoiCapPhatLieu,
    'ID_Avery_TemVai_TamUng': ID_Avery_TemVai_TamUng,
    'IDPO': IDPO,
    'IDKhoNVL': IDKhoNVL,
    'SCD': SCD,
    'MaPhieu': MaPhieu,
    'MaKhoNVL': MaKhoNVL,
    'IDVatLieu': IDVatLieu,
    'MaVatLieu': MaVatLieu,
    'MaAvery': MaAvery,
    'TenHangHoa': TenHangHoa,
    'SoLuongTinhLieu': SoLuongTinhLieu,
    'SoLuongXuat': SoLuongXuat,
    'SoLuongCuon': SoLuongCuon,
    'MaPO': MaPO,
    'ViTri': ViTri,
    'Lo': Lo,
    'DonViTinh': DonViTinh,
    'QuyCach': QuyCach,
    'HanSuDung': HanSuDung,
    'GhiChu': GhiChu,
    'SttTinhLieu': SttTinhLieu,
    'IDKhuVuc': IDKhuVuc,
    'LoaiHang': LoaiHang,
    'BoPhan': BoPhan,
    'Kho': Kho,
    'Ngay': Ngay,
    'isEnable': isEnable,
    'isTinh': isTinh,
    'isXuatKho': isXuatKho,
  };

  factory KhoNVL_XuatKho_ChiTiet.fromJson(Map<String, dynamic> json) => KhoNVL_XuatKho_ChiTiet(
    IDPhieuLanhLieu: json['IDPhieuLanhLieu']?.toString() ?? '',
    IDTheoDoiCapPhatLieu_ChiTiet: json['IDTheoDoiCapPhatLieu_ChiTiet']?.toString() ?? '',
    IDTheoDoiCapPhatLieu: json['IDTheoDoiCapPhatLieu']?.toString() ?? '',
    ID_Avery_TemVai_TamUng: json['ID_Avery_TemVai_TamUng']?.toString() ?? '',
    IDPO: json['IDPO']?.toString() ?? '',
    IDKhoNVL: json['IDKhoNVL']?.toString() ?? '',
    SCD: json['SCD']?.toString() ?? '',
    MaPhieu: json['MaPhieu']?.toString() ?? '',
    MaKhoNVL: json['MaKhoNVL']?.toString() ?? '',
    IDVatLieu: json['IDVatLieu']?.toString() ?? '',
    MaVatLieu: json['MaVatLieu']?.toString() ?? '',
    MaAvery: json['MaAvery']?.toString() ?? '',
    TenHangHoa: json['TenHangHoa']?.toString() ?? '',
    SoLuongTinhLieu: json['SoLuongTinhLieu'],
    SoLuongXuat: json['SoLuongXuat'],
    SoLuongCuon: json['SoLuongCuon'],
    MaPO: json['MaPO']?.toString() ?? '',
    ViTri: json['ViTri']?.toString() ?? '',
    Lo: json['Lo']?.toString() ?? '',
    DonViTinh: json['DonViTinh']?.toString() ?? '',
    QuyCach: json['QuyCach']?.toString() ?? '',
    HanSuDung: DateTime.tryParse(json['HanSuDung'] ?? '') ?? DateTime.now(),
    GhiChu: json['GhiChu']?.toString() ?? '',
    SttTinhLieu: json['SttTinhLieu'],
    IDKhuVuc: json['IDKhuVuc']?.toString() ?? '',
    LoaiHang: json['LoaiHang']?.toString() ?? '',
    BoPhan: json['BoPhan']?.toString() ?? '',
    Kho: json['Kho']?.toString() ?? '',
    Ngay: DateTime.tryParse(json['Ngay'] ?? '') ?? DateTime.now(),
    isEnable: json['isEnable'] ?? false,
    isTinh: json['isTinh'] ?? false,
    isXuatKho: json['isXuatKho'] ?? false,
  );
}
