import 'dart:convert';

CheckData_NghiepVuNotNull_HoanThanhNull CheckData_NghiepVuNotNull_HoanThanhNullFromJson(String str) => CheckData_NghiepVuNotNull_HoanThanhNull.fromJson(json.decode(str));

String CheckData_NghiepVuNotNull_HoanThanhNullToJson(CheckData_NghiepVuNotNull_HoanThanhNull data) => json.encode(data.toJson());

class CheckData_NghiepVuNotNull_HoanThanhNull {
String? SCD;
String? NhomDonHang;
String? MaDonHang;
String? PhienBan;
String? TenKhachHang;
String? MaSanPham;
String? TenSanPham;
String? KichThuoc;
String? BoPhan;
DateTime? NgayXuongDon;
DateTime? NgayGiaoHang;
int? SoLuong;
// String? LoaiSanPham;
// String? VatLieu;
// String? VatLieu2;
// String? VatLieu3;
// String? SKU;
// String? MauMatPhai;
// String? MauMatTrai;
// String? PhuongPhapIn;
// String? GiaCongMatPhai;
// String? GiaCongMatTrai;
// String? PhuongPhapCat;
// String? BoGoc;
// String? DucLo;
// String? NhanVienNghiepVu;
// String? ChuY;
// String? ChamCatDapHop;
// String? Khac;
// String? LoaiChi;
// String? DoDai;
// String? GiaCongSau;
// String? GiaCongSauInMatTrai;
// String? Kho;
// String? InChu_MaVach;
// String? CongDoanSanXuat;
// String? DanhSach;
// String? SOGop;
// String? RBO;
String? NghiepVu_XuongDon;
String? ThietKeNhan;
String? ThietKeHoanThanh;
String? GiaCongNhan;
String? GiaCongHoanThanh;
String? KeHoachNhan;
String? KeHoachHoanThanh;
String? CtpNhan;
String? CtpHoanThanh;
String? CtfNhan;
String? CtfHoanThanh;
String? OffsetNhan;
String? OffsetHoanThanh;
String? UvNhan;
String? UvHoanThanh;
String? SauInNhan;
String? SauInHoanThanh;
String? DanhThiepNhan;
String? DanhThiepHoanThanh;
String? KyThuatSoNhan;
String? KyThuatSoHoanThanh;
String? InChuNhan;
String? InChuHoanThanh;
String? StickerNhan;
String? StickerHoanThanh;
String? TemVaiNhan;
String? TemVaiHoanThanh;
String? InNhan;
String? InHoanThanh;
String? CatNhan;
String? CatHoanThanh;
String? KiemNhan;
String? KiemHoanThanh;
String? KhoBTPNhan;
String? KhoBTPHoanThanh;
String? KiemPhamNhan;
String? KiemPhamHoanThanh;
String? KeToanNhan;
String? KeToanHoanThanh;
String? HoanThanh;
String? GhiChu;
String? DonSuCo;
String? IDKhuVuc;
String? Layout_MT;
String? Layout_MS;
dynamic? Image_Layout_MT;
dynamic? Image_Layout_MS;

CheckData_NghiepVuNotNull_HoanThanhNull({
required this.SCD,
required this.NhomDonHang,
required this.MaDonHang,
required this.PhienBan,
required this.TenKhachHang,
required this.MaSanPham,
required this.TenSanPham,
required this.KichThuoc,
required this.BoPhan,
required this.NgayXuongDon,
required this.NgayGiaoHang,
required this.SoLuong,
// required this.LoaiSanPham,
// required this.VatLieu,
// required this.VatLieu2,
// required this.VatLieu3,
// required this.SKU,
// required this.MauMatPhai,
// required this.MauMatTrai,
// required this.PhuongPhapIn,
// required this.GiaCongMatPhai,
// required this.GiaCongMatTrai,
// required this.PhuongPhapCat,
// required this.BoGoc,
// required this.DucLo,
// required this.NhanVienNghiepVu,
// required this.ChuY,
// required this.ChamCatDapHop,
// required this.Khac,
// required this.LoaiChi,
// required this.DoDai,
// required this.GiaCongSau,
// required this.GiaCongSauInMatTrai,
// required this.Kho,
// required this.InChu_MaVach,
// required this.CongDoanSanXuat,
// required this.DanhSach,
// required this.SOGop,
// required this.RBO,
required this.NghiepVu_XuongDon,
required this.ThietKeNhan,
required this.ThietKeHoanThanh,
required this.GiaCongNhan,
required this.GiaCongHoanThanh,
required this.KeHoachNhan,
required this.KeHoachHoanThanh,
required this.CtpNhan,
required this.CtpHoanThanh,
required this.CtfNhan,
required this.CtfHoanThanh,
required this.OffsetNhan,
required this.OffsetHoanThanh,
required this.UvNhan,
required this.UvHoanThanh,
required this.SauInNhan,
required this.SauInHoanThanh,
required this.DanhThiepNhan,
required this.DanhThiepHoanThanh,
required this.KyThuatSoNhan,
required this.KyThuatSoHoanThanh,
required this.InChuNhan,
required this.InChuHoanThanh,
required this.StickerNhan,
required this.StickerHoanThanh,
required this.TemVaiNhan,
required this.TemVaiHoanThanh,
required this.InNhan,
required this.InHoanThanh,
required this.CatNhan,
required this.CatHoanThanh,
required this.KiemNhan,
required this.KiemHoanThanh,
required this.KhoBTPNhan,
required this.KhoBTPHoanThanh,
required this.KiemPhamNhan,
required this.KiemPhamHoanThanh,
required this.KeToanNhan,
required this.KeToanHoanThanh,
required this.HoanThanh,
required this.GhiChu,
required this.DonSuCo,
required this.IDKhuVuc,
required this.Layout_MT,
required this.Layout_MS,
required this.Image_Layout_MT,
required this.Image_Layout_MS,
});

Map<String, dynamic> toJson() => {
'SCD': SCD,
'NhomDonHang': NhomDonHang,
'MaDonHang': MaDonHang,
'PhienBan': PhienBan,
'TenKhachHang': TenKhachHang,
'MaSanPham': MaSanPham,
'TenSanPham': TenSanPham,
'KichThuoc': KichThuoc,
'BoPhan': BoPhan,
'NgayXuongDon': NgayXuongDon,
'NgayGiaoHang': NgayGiaoHang,
'SoLuong': SoLuong,
// 'LoaiSanPham': LoaiSanPham,
// 'VatLieu': VatLieu,
// 'VatLieu2': VatLieu2,
// 'VatLieu3': VatLieu3,
// 'SKU': SKU,
// 'MauMatPhai': MauMatPhai,
// 'MauMatTrai': MauMatTrai,
// 'PhuongPhapIn': PhuongPhapIn,
// 'GiaCongMatPhai': GiaCongMatPhai,
// 'GiaCongMatTrai': GiaCongMatTrai,
// 'PhuongPhapCat': PhuongPhapCat,
// 'BoGoc': BoGoc,
// 'DucLo': DucLo,
// 'NhanVienNghiepVu': NhanVienNghiepVu,
// 'ChuY': ChuY,
// 'ChamCatDapHop': ChamCatDapHop,
// 'Khac': Khac,
// 'LoaiChi': LoaiChi,
// 'DoDai': DoDai,
// 'GiaCongSau': GiaCongSau,
// 'GiaCongSauInMatTrai': GiaCongSauInMatTrai,
// 'Kho': Kho,
// 'InChu_MaVach': InChu_MaVach,
// 'CongDoanSanXuat': CongDoanSanXuat,
// 'DanhSach': DanhSach,
// 'SOGop': SOGop,
// 'RBO': RBO,
'NghiepVu_XuongDon': NghiepVu_XuongDon,
'ThietKeNhan': ThietKeNhan,
'ThietKeHoanThanh': ThietKeHoanThanh,
'GiaCongNhan': GiaCongNhan,
'GiaCongHoanThanh': GiaCongHoanThanh,
'KeHoachNhan': KeHoachNhan,
'KeHoachHoanThanh': KeHoachHoanThanh,
'CtpNhan': CtpNhan,
'CtpHoanThanh': CtpHoanThanh,
'CtfNhan': CtfNhan,
'CtfHoanThanh': CtfHoanThanh,
'OffsetNhan': OffsetNhan,
'OffsetHoanThanh': OffsetHoanThanh,
'UvNhan': UvNhan,
'UvHoanThanh': UvHoanThanh,
'SauInNhan': SauInNhan,
'SauInHoanThanh': SauInHoanThanh,
'DanhThiepNhan': DanhThiepNhan,
'DanhThiepHoanThanh': DanhThiepHoanThanh,
'KyThuatSoNhan': KyThuatSoNhan,
'KyThuatSoHoanThanh': KyThuatSoHoanThanh,
'InChuNhan': InChuNhan,
'InChuHoanThanh': InChuHoanThanh,
'StickerNhan': StickerNhan,
'StickerHoanThanh': StickerHoanThanh,
'TemVaiNhan': TemVaiNhan,
'TemVaiHoanThanh': TemVaiHoanThanh,
'InNhan': InNhan,
'InHoanThanh': InHoanThanh,
'CatNhan': CatNhan,
'CatHoanThanh': CatHoanThanh,
'KiemNhan': KiemNhan,
'KiemHoanThanh': KiemHoanThanh,
'KhoBTPNhan': KhoBTPNhan,
'KhoBTPHoanThanh': KhoBTPHoanThanh,
'KiemPhamNhan': KiemPhamNhan,
'KiemPhamHoanThanh': KiemPhamHoanThanh,
'KeToanNhan': KeToanNhan,
'KeToanHoanThanh': KeToanHoanThanh,
'HoanThanh': HoanThanh,
'GhiChu': GhiChu,
'DonSuCo': DonSuCo,
'IDKhuVuc': IDKhuVuc,
'Layout_MT': Layout_MT,
'Layout_MS': Layout_MS,
'Image_Layout_MT': Image_Layout_MT,
'Image_Layout_MS': Image_Layout_MS,
};

factory CheckData_NghiepVuNotNull_HoanThanhNull.fromJson(Map<String, dynamic> json) => CheckData_NghiepVuNotNull_HoanThanhNull(
SCD: json['SCD']?.toString() ?? '',
NhomDonHang: json['NhomDonHang']?.toString() ?? '',
MaDonHang: json['MaDonHang']?.toString() ?? '',
PhienBan: json['PhienBan']?.toString() ?? '',
TenKhachHang: json['TenKhachHang']?.toString() ?? '',
MaSanPham: json['MaSanPham']?.toString() ?? '',
TenSanPham: json['TenSanPham']?.toString() ?? '',
KichThuoc: json['KichThuoc']?.toString() ?? '',
BoPhan: json['BoPhan']?.toString() ?? '',
NgayXuongDon: DateTime.tryParse(json['NgayXuongDon'] ?? '') ?? DateTime.now(),
NgayGiaoHang: DateTime.tryParse(json['NgayGiaoHang'] ?? '') ?? DateTime.now(),
SoLuong: int.tryParse(json['SoLuong']?.toString() ?? '0') ?? 0,
// LoaiSanPham: json['LoaiSanPham']?.toString() ?? '',
// VatLieu: json['VatLieu']?.toString() ?? '',
// VatLieu2: json['VatLieu2']?.toString() ?? '',
// VatLieu3: json['VatLieu3']?.toString() ?? '',
// SKU: json['SKU']?.toString() ?? '',
// MauMatPhai: json['MauMatPhai']?.toString() ?? '',
// MauMatTrai: json['MauMatTrai']?.toString() ?? '',
// PhuongPhapIn: json['PhuongPhapIn']?.toString() ?? '',
// GiaCongMatPhai: json['GiaCongMatPhai']?.toString() ?? '',
// GiaCongMatTrai: json['GiaCongMatTrai']?.toString() ?? '',
// PhuongPhapCat: json['PhuongPhapCat']?.toString() ?? '',
// BoGoc: json['BoGoc']?.toString() ?? '',
// DucLo: json['DucLo']?.toString() ?? '',
// NhanVienNghiepVu: json['NhanVienNghiepVu']?.toString() ?? '',
// ChuY: json['ChuY']?.toString() ?? '',
// ChamCatDapHop: json['ChamCatDapHop']?.toString() ?? '',
// Khac: json['Khac']?.toString() ?? '',
// LoaiChi: json['LoaiChi']?.toString() ?? '',
// DoDai: json['DoDai']?.toString() ?? '',
// GiaCongSau: json['GiaCongSau']?.toString() ?? '',
// GiaCongSauInMatTrai: json['GiaCongSauInMatTrai']?.toString() ?? '',
// Kho: json['Kho']?.toString() ?? '',
// InChu_MaVach: json['InChu_MaVach']?.toString() ?? '',
// CongDoanSanXuat: json['CongDoanSanXuat']?.toString() ?? '',
// DanhSach: json['DanhSach']?.toString() ?? '',
// SOGop: json['SOGop']?.toString() ?? '',
// RBO: json['RBO']?.toString() ?? '',
NghiepVu_XuongDon: json['NghiepVu_XuongDon']?.toString() ?? '',
ThietKeNhan: json['ThietKeNhan']?.toString() ?? '',
ThietKeHoanThanh: json['ThietKeHoanThanh']?.toString() ?? '',
GiaCongNhan: json['GiaCongNhan']?.toString() ?? '',
GiaCongHoanThanh: json['GiaCongHoanThanh']?.toString() ?? '',
KeHoachNhan: json['KeHoachNhan']?.toString() ?? '',
KeHoachHoanThanh: json['KeHoachHoanThanh']?.toString() ?? '',
CtpNhan: json['CtpNhan']?.toString() ?? '',
CtpHoanThanh: json['CtpHoanThanh']?.toString() ?? '',
CtfNhan: json['CtfNhan']?.toString() ?? '',
CtfHoanThanh: json['CtfHoanThanh']?.toString() ?? '',
OffsetNhan: json['OffsetNhan']?.toString() ?? '',
OffsetHoanThanh: json['OffsetHoanThanh']?.toString() ?? '',
UvNhan: json['UvNhan']?.toString() ?? '',
UvHoanThanh: json['UvHoanThanh']?.toString() ?? '',
SauInNhan: json['SauInNhan']?.toString() ?? '',
SauInHoanThanh: json['SauInHoanThanh']?.toString() ?? '',
DanhThiepNhan: json['DanhThiepNhan']?.toString() ?? '',
DanhThiepHoanThanh: json['DanhThiepHoanThanh']?.toString() ?? '',
KyThuatSoNhan: json['KyThuatSoNhan']?.toString() ?? '',
KyThuatSoHoanThanh: json['KyThuatSoHoanThanh']?.toString() ?? '',
InChuNhan: json['InChuNhan']?.toString() ?? '',
InChuHoanThanh: json['InChuHoanThanh']?.toString() ?? '',
StickerNhan: json['StickerNhan']?.toString() ?? '',
StickerHoanThanh: json['StickerHoanThanh']?.toString() ?? '',
TemVaiNhan: json['TemVaiNhan']?.toString() ?? '',
TemVaiHoanThanh: json['TemVaiHoanThanh']?.toString() ?? '',
InNhan: json['InNhan']?.toString() ?? '',
InHoanThanh: json['InHoanThanh']?.toString() ?? '',
CatNhan: json['CatNhan']?.toString() ?? '',
CatHoanThanh: json['CatHoanThanh']?.toString() ?? '',
KiemNhan: json['KiemNhan']?.toString() ?? '',
KiemHoanThanh: json['KiemHoanThanh']?.toString() ?? '',
KhoBTPNhan: json['KhoBTPNhan']?.toString() ?? '',
KhoBTPHoanThanh: json['KhoBTPHoanThanh']?.toString() ?? '',
KiemPhamNhan: json['KiemPhamNhan']?.toString() ?? '',
KiemPhamHoanThanh: json['KiemPhamHoanThanh']?.toString() ?? '',
KeToanNhan: json['KeToanNhan']?.toString() ?? '',
KeToanHoanThanh: json['KeToanHoanThanh']?.toString() ?? '',
HoanThanh: json['HoanThanh']?.toString() ?? '',
GhiChu: json['GhiChu']?.toString() ?? '',
DonSuCo: json['DonSuCo']?.toString() ?? '',
IDKhuVuc: json['IDKhuVuc']?.toString() ?? '',
Layout_MT: json['Layout_MT']?.toString() ?? '',
Layout_MS: json['Layout_MS']?.toString() ?? '',
Image_Layout_MT: json['Image_Layout_MT']?.toString() ?? '',
Image_Layout_MS: json['Image_Layout_MS']?.toString() ?? '',
);
}
