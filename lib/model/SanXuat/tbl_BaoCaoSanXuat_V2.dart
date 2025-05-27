import 'dart:convert';

tbl_BaoCaoSanXuat_V2 tbl_BaoCaoSanXuat_V2FromJson(String str) => tbl_BaoCaoSanXuat_V2.fromJson(json.decode(str));

String tbl_BaoCaoSanXuat_V2ToJson(tbl_BaoCaoSanXuat_V2 data) => json.encode(data.toJson());

class tbl_BaoCaoSanXuat_V2 {
   String? IDBaoCaoSanXuat;
   int? Nam;
   int? Thang;
   int? Tuan;
   String? Ngay;
   String? NgayTrongTuan;
   String? MSNV;
   String? CaLamViec;
   String? SCD;
   String? CongDoan;
   int? SoLuongDat;
   int? SoLuongLoi;
   String? ThaoTac;
   String? ThoiGian_BatDau;
   String? ThoiGian_KetThuc;
   int? ThoiGianChayMay;
   String? GhiChu;
   String? isHoanThanh;
   String? IDKhuVuc;
   String? TenNhanVien;
   String? BoPhan;
   String? TenKhachHang;
   String? TenSanPham;
   int? SoLuong;
   String CongDoanSanXuat;
   String CongDoanKiemPham;
   int? LanhLieu;
   String DonViTinh;
   String QuyCach;
   String KhoGiayIn;


  tbl_BaoCaoSanXuat_V2({
    required this.IDBaoCaoSanXuat,
    required this.Nam,
    required this.Thang,
    required this.Tuan,
    required this.Ngay,
    required this.NgayTrongTuan,
    required this.MSNV,
    required this.CaLamViec,
    required this.SCD,
    required this.CongDoan,
    required this.SoLuongDat,
    required this.SoLuongLoi,
    required this.ThaoTac,
    required this.ThoiGian_BatDau,
    required this.ThoiGian_KetThuc,
    required this.ThoiGianChayMay,
    required this.GhiChu,
    required this.IDKhuVuc,
    required this.isHoanThanh,
    required this.TenNhanVien,
    required this.BoPhan,
    required this.TenKhachHang,
    required this.TenSanPham,
    required this.SoLuong,
    required this.CongDoanSanXuat,
    required this.CongDoanKiemPham,
    required this.LanhLieu,
    required this.DonViTinh,
    required this.QuyCach,
    required this.KhoGiayIn,
  });

  Map<String, dynamic> toJson() => {
    'IDBaoCaoSanXuat': IDBaoCaoSanXuat,
    'Nam': Nam,
    'Thang': Thang,
    'Tuan': Tuan,
    'Ngay': Ngay,
    'NgayTrongTuan': NgayTrongTuan,
    'MSNV': MSNV,
    'CaLamViec': CaLamViec,
    'SCD': SCD,
    'CongDoan': CongDoan,
    'SoLuongDat': SoLuongDat,
    'SoLuongLoi': SoLuongLoi,
    'ThaoTac': ThaoTac,
    'ThoiGian_BatDau': ThoiGian_BatDau,
    'ThoiGian_KetThuc': ThoiGian_KetThuc,
    'ThoiGianChayMay': ThoiGianChayMay,
    'GhiChu': GhiChu,
    'isHoanThanh': isHoanThanh,
    'IDKhuVuc': IDKhuVuc,
    'TenNhanVien': TenNhanVien,
    'BoPhan': BoPhan,
    'TenKhachHang': TenKhachHang,
    'TenSanPham': TenSanPham,
    'SoLuong': SoLuong,
    'CongDoanSanXuat': CongDoanSanXuat,
    'CongDoanKiemPham': CongDoanKiemPham,
    'LanhLieu': LanhLieu,
    'DonViTinh': DonViTinh,
    'QuyCach': QuyCach,
    'KhoGiayIn': KhoGiayIn,
  };

  factory tbl_BaoCaoSanXuat_V2.fromJson(Map<String, dynamic> json) => tbl_BaoCaoSanXuat_V2(
    IDBaoCaoSanXuat: json['IDBaoCaoSanXuat']?.toString() ?? '',
    Nam: json['Nam'],
    Thang: json['Thang'],
    Tuan: json['Tuan'],
    Ngay: json['Ngay']  ?? DateTime.now(),
    NgayTrongTuan: json['NgayTrongTuan']?.toString() ?? '',
    MSNV: json['MSNV']?.toString() ?? '',
    CaLamViec: json['CaLamViec']?.toString() ?? '',
    SCD: json['SCD']?.toString() ?? '',
    CongDoan: json['CongDoan']?.toString() ?? '',
    SoLuongDat: json['SoLuongDat'],
    SoLuongLoi: json['SoLuongLoi'],
    ThaoTac: json['ThaoTac']?.toString() ?? '',
    ThoiGian_BatDau: json['ThoiGian_BatDau'],
    ThoiGian_KetThuc: json['ThoiGian_KetThuc'],
    ThoiGianChayMay: json['ThoiGianChayMay'],
    GhiChu: json['GhiChu']?.toString() ?? '',
    IDKhuVuc: json['IDKhuVuc']?.toString() ?? '',
    isHoanThanh: json['isHoanThanh'].toString() ?? 'false',
    TenNhanVien: json['TenNhanVien']?.toString() ?? '',
    BoPhan: json['BoPhan']?.toString() ?? '',
    TenKhachHang: json['TenKhachHang']?.toString() ?? '',
    TenSanPham: json['TenSanPham']?.toString() ?? '',
    SoLuong: json['SoLuong'],
    CongDoanSanXuat: json['CongDoanSanXuat']?.toString() ?? '',
    CongDoanKiemPham: json['CongDoanKiemPham']?.toString() ?? '',
    LanhLieu: json['LanhLieu'],
    DonViTinh: json['DonViTinh']?.toString() ?? '',
    QuyCach: json['QuyCach']?.toString() ?? '',
    KhoGiayIn: json['KhoGiayIn']?.toString() ?? '',
  );
}
