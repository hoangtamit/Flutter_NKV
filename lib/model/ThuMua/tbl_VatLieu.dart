import 'dart:convert';

tbl_VatLieu tbl_VatLieuFromJson(String str) => tbl_VatLieu.fromJson(json.decode(str));

String tbl_VatLieuToJson(tbl_VatLieu data) => json.encode(data.toJson());

class tbl_VatLieu {
  String? ID;
  int? STT_VatLieu;
  String? IDVatLieu;
  String? MaVatLieuGop;
  String? MaVatLieu2;
  String? LoaiHang;
  String? MaKhachHang;
  String? MaAvery;
  String? TenHangHoa;
  String? TenHangHoa2;
  String? TenPhanLoai;
  String? PhanLoai;
  String? ThuongHieu;
  String? DonViTinh;
  String? QuyCach;
  int? ChieuDai;
  int? ChieuRong;
  int? ChieuCao;
  String? ViTri;
  int? HanSuDung;
  int? VAT;
  String? Image;
  String? Barcode;
  String? Url;
  String? DienGiai;
  String? GhiChu_VatLieu;
  String? MauSac;
  int? SoLanChinhSua;
  String? NhanVien;
  DateTime? ThoiGian;
  String? NhanVienChinhSua;
  DateTime? ThoiGianChinhSua;
  String? IDKhuVuc;
  int? DinhMucToiThieu;
  int? DinhMucToiDa;
  int? DinhLuong;
  int? TrongLuong;
  String? Price;
  bool? Priority;
  bool? isKiemTraDauVao;
  int? ThoiGianGiaoHang;

  tbl_VatLieu({
    required this.ID,
    required this.STT_VatLieu,
    required this.IDVatLieu,
    required this.MaVatLieuGop,
    required this.MaVatLieu2,
    required this.LoaiHang,
    required this.MaKhachHang,
    required this.MaAvery,
    required this.TenHangHoa,
    required this.TenHangHoa2,
    required this.TenPhanLoai,
    required this.PhanLoai,
    required this.ThuongHieu,
    required this.DonViTinh,
    required this.QuyCach,
    required this.ChieuDai,
    required this.ChieuRong,
    required this.ChieuCao,
    required this.ViTri,
    required this.HanSuDung,
    required this.VAT,
    required this.Image,
    required this.Barcode,
    required this.Url,
    required this.DienGiai,
    required this.GhiChu_VatLieu,
    required this.MauSac,
    required this.SoLanChinhSua,
    required this.NhanVien,
    required this.ThoiGian,
    required this.NhanVienChinhSua,
    required this.ThoiGianChinhSua,
    required this.IDKhuVuc,
    required this.DinhMucToiThieu,
    required this.DinhMucToiDa,
    required this.DinhLuong,
    required this.TrongLuong,
    required this.Price,
    required this.Priority,
    required this.isKiemTraDauVao,
    required this.ThoiGianGiaoHang,
  });

  Map<String, dynamic> toJson() => {
    'ID': ID,
    'STT_VatLieu': STT_VatLieu,
    'IDVatLieu': IDVatLieu,
    'MaVatLieuGop': MaVatLieuGop,
    'MaVatLieu2': MaVatLieu2,
    'LoaiHang': LoaiHang,
    'MaKhachHang': MaKhachHang,
    'MaAvery': MaAvery,
    'TenHangHoa': TenHangHoa,
    'TenHangHoa2': TenHangHoa2,
    'TenPhanLoai': TenPhanLoai,
    'PhanLoai': PhanLoai,
    'ThuongHieu': ThuongHieu,
    'DonViTinh': DonViTinh,
    'QuyCach': QuyCach,
    'ChieuDai': ChieuDai,
    'ChieuRong': ChieuRong,
    'ChieuCao': ChieuCao,
    'ViTri': ViTri,
    'HanSuDung': HanSuDung,
    'VAT': VAT,
    'Image': Image,
    'Barcode': Barcode,
    'Url': Url,
    'DienGiai': DienGiai,
    'GhiChu_VatLieu': GhiChu_VatLieu,
    'MauSac': MauSac,
    'SoLanChinhSua': SoLanChinhSua,
    'NhanVien': NhanVien,
    'ThoiGian': ThoiGian?.toIso8601String(),
    'NhanVienChinhSua': NhanVienChinhSua,
    'ThoiGianChinhSua': ThoiGianChinhSua?.toIso8601String(),
    'IDKhuVuc': IDKhuVuc,
    'DinhMucToiThieu': DinhMucToiThieu,
    'DinhMucToiDa': DinhMucToiDa,
    'DinhLuong': DinhLuong,
    'TrongLuong': TrongLuong,
    'Price': Price,
    'Priority': Priority,
    'isKiemTraDauVao': isKiemTraDauVao,
    'ThoiGianGiaoHang': ThoiGianGiaoHang,
  };

  factory tbl_VatLieu.fromJson(Map<String, dynamic> json) => tbl_VatLieu(
    ID: json['ID']?.toString() ?? '',
    STT_VatLieu: int.tryParse(json['STT_VatLieu']?.toString() ?? '0') ?? 0,
    IDVatLieu: json['IDVatLieu']?.toString() ?? '',
    MaVatLieuGop: json['MaVatLieuGop']?.toString() ?? '',
    MaVatLieu2: json['MaVatLieu2']?.toString() ?? '',
    LoaiHang: json['LoaiHang']?.toString() ?? '',
    MaKhachHang: json['MaKhachHang']?.toString() ?? '',
    MaAvery: json['MaAvery']?.toString() ?? '',
    TenHangHoa: json['TenHangHoa']?.toString() ?? '',
    TenHangHoa2: json['TenHangHoa2']?.toString() ?? '',
    TenPhanLoai: json['TenPhanLoai']?.toString() ?? '',
    PhanLoai: json['PhanLoai']?.toString() ?? '',
    ThuongHieu: json['ThuongHieu']?.toString() ?? '',
    DonViTinh: json['DonViTinh']?.toString() ?? '',
    QuyCach: json['QuyCach']?.toString() ?? '',
    ChieuDai: int.tryParse(json['ChieuDai']?.toString() ?? '0') ?? 0,
    ChieuRong: int.tryParse(json['ChieuRong']?.toString() ?? '0') ?? 0,
    ChieuCao: int.tryParse(json['ChieuCao']?.toString() ?? '0') ?? 0,
    ViTri: json['ViTri']?.toString() ?? '',
    HanSuDung: int.tryParse(json['HanSuDung']?.toString() ?? '0') ?? 0,
    VAT: int.tryParse(json['VAT']?.toString() ?? '0') ?? 0,
    Image: json['Image']?.toString() ?? '',
    Barcode: json['Barcode']?.toString() ?? '',
    Url: json['Url']?.toString() ?? '',
    DienGiai: json['DienGiai']?.toString() ?? '',
    GhiChu_VatLieu: json['GhiChu_VatLieu']?.toString() ?? '',
    MauSac: json['MauSac']?.toString() ?? '',
    SoLanChinhSua: int.tryParse(json['SoLanChinhSua']?.toString() ?? '0') ?? 0,
    NhanVien: json['NhanVien']?.toString() ?? '',
    ThoiGian: DateTime.tryParse(json['ThoiGian'] ?? '') ?? DateTime.now(),
    NhanVienChinhSua: json['NhanVienChinhSua']?.toString() ?? '',
    ThoiGianChinhSua: DateTime.tryParse(json['ThoiGianChinhSua'] ?? '') ?? DateTime.now(),
    IDKhuVuc: json['IDKhuVuc']?.toString() ?? '',
    DinhMucToiThieu: int.tryParse(json['DinhMucToiThieu']?.toString() ?? '0') ?? 0,
    DinhMucToiDa: int.tryParse(json['DinhMucToiDa']?.toString() ?? '0') ?? 0,
    DinhLuong: int.tryParse(json['DinhLuong']?.toString() ?? '0') ?? 0,
    TrongLuong: int.tryParse(json['TrongLuong']?.toString() ?? '0') ?? 0,
    Price: json['Price']?.toString() ?? '',
    Priority: json['Priority'] is bool ? json['Priority'] : false,
    isKiemTraDauVao: json['isKiemTraDauVao'] is bool ? json['isKiemTraDauVao'] : false,
    ThoiGianGiaoHang: int.tryParse(json['ThoiGianGiaoHang']?.toString() ?? '0') ?? 0,
  );
}
