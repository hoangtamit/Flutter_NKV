import 'dart:convert';

tbDonSanXuat tbDonSanXuatFromJson(String str) => tbDonSanXuat.fromJson(json.decode(str));

String tbDonSanXuatToJson(tbDonSanXuat data) => json.encode(data.toJson());

class tbDonSanXuat {
  String SCD;
  String? NhomDonHang;
  String? MaDonHang;
  String? PhienBan;
  String? IDKhachHang;
  String? TenKhachHang;
  String? MaSanPham;
  String? TenSanPham;
  String? KichThuoc;
  String? BoPhan;
  DateTime? NgayXuongDon;
  DateTime? NgayGiaoHang;
  int? SoLuong;
  String? LoaiSanPham;
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
  String? BoGoc;
  String? DucLo;
  String? NhanVienNghiepVu;
  String? ChuY;
  String? ChamCatDapHop;
  String? Khac;
  String? LoaiChi;
  String? DoDai;
  String? GiaCongSau;
  String? GiaCongSauInMatTrai;
  String? Kho;
  String? InChu_MaVach;
  DateTime? ThoiGianXuongDon;
  String? ChinhSua;
  int? SKU;
  int? STT;
  String? CongDoanSanXuat;
  String? CongDoanKiemPham;
  bool? DongBoDuLieu;
  String? IDKhuVuc;
  String? WaterMark;
  bool? isUpdate;
  bool? isDeleted;

  tbDonSanXuat({
    required this.SCD,
    required this.NhomDonHang,
    required this.MaDonHang,
    required this.PhienBan,
    required this.IDKhachHang,
    required this.TenKhachHang,
    required this.MaSanPham,
    required this.TenSanPham,
    required this.KichThuoc,
    required this.BoPhan,
    required this.NgayXuongDon,
    required this.NgayGiaoHang,
    required this.SoLuong,
    required this.LoaiSanPham,
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
    required this.BoGoc,
    required this.DucLo,
    required this.NhanVienNghiepVu,
    required this.ChuY,
    required this.ChamCatDapHop,
    required this.Khac,
    required this.LoaiChi,
    required this.DoDai,
    required this.GiaCongSau,
    required this.GiaCongSauInMatTrai,
    required this.Kho,
    required this.InChu_MaVach,
    required this.ThoiGianXuongDon,
    required this.ChinhSua,
    required this.SKU,
    required this.STT,
    required this.CongDoanSanXuat,
    required this.CongDoanKiemPham,
    required this.DongBoDuLieu,
    required this.IDKhuVuc,
    required this.WaterMark,
    required this.isUpdate,
    required this.isDeleted,
  });

  Map<String, dynamic> toJson() => {
    'SCD': SCD,
    'NhomDonHang': NhomDonHang,
    'MaDonHang': MaDonHang,
    'PhienBan': PhienBan,
    'IDKhachHang': IDKhachHang,
    'TenKhachHang': TenKhachHang,
    'MaSanPham': MaSanPham,
    'TenSanPham': TenSanPham,
    'KichThuoc': KichThuoc,
    'BoPhan': BoPhan,
    'NgayXuongDon': NgayXuongDon?.toIso8601String(),
    'NgayGiaoHang': NgayGiaoHang?.toIso8601String(),
    'SoLuong': SoLuong,
    'LoaiSanPham': LoaiSanPham,
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
    'BoGoc': BoGoc,
    'DucLo': DucLo,
    'NhanVienNghiepVu': NhanVienNghiepVu,
    'ChuY': ChuY,
    'ChamCatDapHop': ChamCatDapHop,
    'Khac': Khac,
    'LoaiChi': LoaiChi,
    'DoDai': DoDai,
    'GiaCongSau': GiaCongSau,
    'GiaCongSauInMatTrai': GiaCongSauInMatTrai,
    'Kho': Kho,
    'InChu_MaVach': InChu_MaVach,
    'ThoiGianXuongDon': ThoiGianXuongDon?.toIso8601String(),
    'ChinhSua': ChinhSua,
    'SKU': SKU,
    'STT': STT,
    'CongDoanSanXuat': CongDoanSanXuat,
    'CongDoanKiemPham': CongDoanKiemPham,
    'DongBoDuLieu': DongBoDuLieu,
    'IDKhuVuc': IDKhuVuc,
    'WaterMark': WaterMark,
    'isUpdate': isUpdate,
    'isDeleted': isDeleted,
  };

  factory tbDonSanXuat.fromJson(Map<String, dynamic> json) => tbDonSanXuat(
    SCD: json['SCD']?.toString() ?? '',
    NhomDonHang: json['NhomDonHang']?.toString() ?? '',
    MaDonHang: json['MaDonHang']?.toString() ?? '',
    PhienBan: json['PhienBan']?.toString() ?? '',
    IDKhachHang: json['IDKhachHang']?.toString() ?? '',
    TenKhachHang: json['TenKhachHang']?.toString() ?? '',
    MaSanPham: json['MaSanPham']?.toString() ?? '',
    TenSanPham: json['TenSanPham']?.toString() ?? '',
    KichThuoc: json['KichThuoc']?.toString() ?? '',
    BoPhan: json['BoPhan']?.toString() ?? '',
    NgayXuongDon: DateTime.tryParse(json['NgayXuongDon'] ?? '') ?? DateTime.now(),
    NgayGiaoHang: DateTime.tryParse(json['NgayGiaoHang'] ?? '') ?? DateTime.now(),
    SoLuong: int.tryParse(json['SoLuong']?.toString() ?? '0') ?? 0,
    LoaiSanPham: json['LoaiSanPham']?.toString() ?? '',
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
    BoGoc: json['BoGoc']?.toString() ?? '',
    DucLo: json['DucLo']?.toString() ?? '',
    NhanVienNghiepVu: json['NhanVienNghiepVu']?.toString() ?? '',
    ChuY: json['ChuY']?.toString() ?? '',
    ChamCatDapHop: json['ChamCatDapHop']?.toString() ?? '',
    Khac: json['Khac']?.toString() ?? '',
    LoaiChi: json['LoaiChi']?.toString() ?? '',
    DoDai: json['DoDai']?.toString() ?? '',
    GiaCongSau: json['GiaCongSau']?.toString() ?? '',
    GiaCongSauInMatTrai: json['GiaCongSauInMatTrai']?.toString() ?? '',
    Kho: json['Kho']?.toString() ?? '',
    InChu_MaVach: json['InChu_MaVach']?.toString() ?? '',
    ThoiGianXuongDon: DateTime.tryParse(json['ThoiGianXuongDon'] ?? '') ?? DateTime.now(),
    ChinhSua: json['ChinhSua']?.toString() ?? '',
    SKU: int.tryParse(json['SKU']?.toString() ?? '0') ?? 0,
    STT: int.tryParse(json['STT']?.toString() ?? '0') ?? 0,
    CongDoanSanXuat: json['CongDoanSanXuat']?.toString() ?? '',
    CongDoanKiemPham: json['CongDoanKiemPham']?.toString() ?? '',
    DongBoDuLieu: json['bit'] is bool ? json['bit'] : false,
    IDKhuVuc: json['IDKhuVuc']?.toString() ?? '',
    WaterMark: json['WaterMark']?.toString() ?? '',
    isUpdate: json['bit'] is bool ? json['bit'] : false,
    isDeleted: json['bit'] is bool ? json['bit'] : false,
  );
}
