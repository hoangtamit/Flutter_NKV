import 'dart:convert';

tbl_NhanVien tbl_NhanVienFromJson(String str) => tbl_NhanVien.fromJson(json.decode(str));

String tbl_NhanVienToJson(tbl_NhanVien data) => json.encode(data.toJson());

class tbl_NhanVien {
  String ID;
  int IDNhanVien;
  String MaNhanVien;
  String? TenNhanVien;
  //DateTime? NgaySinh;
  String? NoiSinh;
  //String? MaThe;
  String? TaiKhoan;
  String? MatKhau;
  String? IDUser;
  int? IDTaiKhoan;
  //int? IDQuocTich;
  //int? IDDanToc;
  //int? IDTonGiao;
  String? IDKhuVuc;
  //int? IDKhoi;
  //int? IDPhongBan;
  int? IDBoPhan;
  int? IDChucVu;
  int? IDTrinhDo;
  int? IDTinhTrang;
  int? IDTo;
  int? IDCongDoan;
  //String? IDCaLamViec;
  //String? CaLamViec;
  // DateTime? NgayVaoLam;
  // DateTime? NgayKyHopDong;
  // DateTime? NgayKyHopDong2;
  // DateTime? NgayKyHopDong3;
  // DateTime? NgayHetHanHopDong;
  // DateTime? NgayHetHanHopDong2;
  // DateTime? NgayHetHanHopDong3;
  // DateTime? NgayNghiViec;
  String DienThoai;
  // String? DiaChiTamTru;
  // String? DiaChiThuongTru;
  // String? NguyenQuan;
  // String? SoCMND;
  // DateTime? NgayCapCMND;
  // String? NoiCapCMND;
  // String? SoTheCanCuoc;
  // DateTime? NgayCapTCC;
  // String? NoiCapTCC;
  // String? GioiTinh;
  // String? HinhNhanVien;
  // String? GiaoDien;
  // String? TinhTrangHonNhan;
  String Email;
  //String? NgoaiNgu;
  //String? GhiChu;
  String BoPhan;
  //String? Token;
  //String? HinhAnh;
  //int? IDParent;

  tbl_NhanVien({
    required this.ID,
    required this.IDNhanVien,
    required this.MaNhanVien,
    required this.TenNhanVien,
    //required this.NgaySinh,
    required this.NoiSinh,
    //required this.MaThe,
    required this.TaiKhoan,
    required this.MatKhau,
    required this.IDUser,
    required this.IDTaiKhoan,
    //required this.IDQuocTich,
    //required this.IDDanToc,
    //required this.IDTonGiao,
    required this.IDKhuVuc,
    //required this.IDKhoi,
    //required this.IDPhongBan,
    required this.IDBoPhan,
    required this.IDChucVu,
    //required this.IDTrinhDo,
    required this.IDTinhTrang,
    required this.IDTo,
    //required this.IDCongDoan,
    //required this.IDCaLamViec,
    //required this.CaLamViec,
    // required this.NgayVaoLam,
    // required this.NgayKyHopDong,
    // required this.NgayKyHopDong2,
    // required this.NgayKyHopDong3,
    // required this.NgayHetHanHopDong,
    // required this.NgayHetHanHopDong2,
    // required this.NgayHetHanHopDong3,
    // required this.NgayNghiViec,
    required this.DienThoai,
    // required this.DiaChiTamTru,
    // required this.DiaChiThuongTru,
    // required this.NguyenQuan,
    // required this.SoCMND,
    // required this.NgayCapCMND,
    // required this.NoiCapCMND,
    // required this.SoTheCanCuoc,
    // required this.NgayCapTCC,
    // required this.NoiCapTCC,
    // required this.GioiTinh,
    // required this.HinhNhanVien,
    // required this.GiaoDien,
    // required this.TinhTrangHonNhan,
    required this.Email,
    //required this.NgoaiNgu,
    //required this.GhiChu,
    required this.BoPhan,
    //required this.Token,
    //required this.HinhAnh,
    //required this.IDParent,
  });

  Map<String, dynamic> toJson() => {
    'ID': ID,
    'IDNhanVien': IDNhanVien,
    'MaNhanVien': MaNhanVien,
    'TenNhanVien': TenNhanVien,
    //'NgaySinh': NgaySinh,
    'NoiSinh': NoiSinh,
    //'MaThe': MaThe,
    'TaiKhoan': TaiKhoan,
    'MatKhau': MatKhau,
    'IDUser': IDUser,
    'IDTaiKhoan': IDTaiKhoan,
    //'IDQuocTich': IDQuocTich,
    //'IDDanToc': IDDanToc,
    //'IDTonGiao': IDTonGiao,
    'IDKhuVuc': IDKhuVuc,
    //'IDKhoi': IDKhoi,
    //'IDPhongBan': IDPhongBan,
    'IDBoPhan': IDBoPhan,
    'IDChucVu': IDChucVu,
    'IDTrinhDo': IDTrinhDo,
    'IDTinhTrang': IDTinhTrang,
    'IDTo': IDTo,
    'IDCongDoan': IDCongDoan,
    //'IDCaLamViec': IDCaLamViec,
    //'CaLamViec': CaLamViec,
    // 'NgayVaoLam': NgayVaoLam,
    // 'NgayKyHopDong': NgayKyHopDong,
    // 'NgayKyHopDong2': NgayKyHopDong2,
    // 'NgayKyHopDong3': NgayKyHopDong3,
    // 'NgayHetHanHopDong': NgayHetHanHopDong,
    // 'NgayHetHanHopDong2': NgayHetHanHopDong2,
    // 'NgayHetHanHopDong3': NgayHetHanHopDong3,
    // 'NgayNghiViec': NgayNghiViec,
    'DienThoai': DienThoai,
    // 'DiaChiTamTru': DiaChiTamTru,
    // 'DiaChiThuongTru': DiaChiThuongTru,
    // 'NguyenQuan': NguyenQuan,
    // 'SoCMND': SoCMND,
    // 'NgayCapCMND': NgayCapCMND,
    // 'NoiCapCMND': NoiCapCMND,
    // 'SoTheCanCuoc': SoTheCanCuoc,
    // 'NgayCapTCC': NgayCapTCC,
    // 'NoiCapTCC': NoiCapTCC,
    // 'GioiTinh': GioiTinh,
    // 'HinhNhanVien': HinhNhanVien,
    // 'GiaoDien': GiaoDien,
    // 'TinhTrangHonNhan': TinhTrangHonNhan,
    'Email': Email,
    //'NgoaiNgu': NgoaiNgu,
    //'GhiChu': GhiChu,
    'BoPhan': BoPhan,
    //'Token': Token,
    //'HinhAnh': HinhAnh,
    //'IDParent': IDParent,
  };

  factory tbl_NhanVien.fromJson(Map<String, dynamic> json) => tbl_NhanVien(
    ID: json['ID']?.toString() ?? '',
    IDNhanVien: int.tryParse(json['IDNhanVien']?.toString() ?? '0') ?? 0,
    MaNhanVien: json['MaNhanVien']?.toString() ?? '',
    TenNhanVien: json['TenNhanVien']?.toString() ?? '',
    //NgaySinh: DateTime.tryParse(json['NgaySinh'] ?? '') ?? DateTime.now(),
    NoiSinh: json['NoiSinh']?.toString() ?? '',
    //MaThe: json['MaThe']?.toString() ?? '',
    TaiKhoan: json['TaiKhoan']?.toString() ?? '',
    MatKhau: json['MatKhau']?.toString() ?? '',
    IDUser: json['IDUser']?.toString() ?? '',
    IDTaiKhoan: int.tryParse(json['IDTaiKhoan']?.toString() ?? '0') ?? 0,
    //IDQuocTich: int.tryParse(json['IDQuocTich']?.toString() ?? '0') ?? 0,
    //IDDanToc: int.tryParse(json['IDDanToc']?.toString() ?? '0') ?? 0,
   //IDTonGiao: int.tryParse(json['IDTonGiao']?.toString() ?? '0') ?? 0,
    IDKhuVuc: json['IDKhuVuc']?.toString() ?? '',
    //IDKhoi: int.tryParse(json['IDKhoi']?.toString() ?? '0') ?? 0,
    //IDPhongBan: int.tryParse(json['IDPhongBan']?.toString() ?? '0') ?? 0,
    IDBoPhan: int.tryParse(json['IDBoPhan']?.toString() ?? '0') ?? 0,
    IDChucVu: int.tryParse(json['IDChucVu']?.toString() ?? '0') ?? 0,
    //IDTrinhDo: int.tryParse(json['IDTrinhDo']?.toString() ?? '0') ?? 0,
    IDTinhTrang: int.tryParse(json['IDTinhTrang']?.toString() ?? '0') ?? 0,
    IDTo: int.tryParse(json['IDTo']?.toString() ?? '0') ?? 0,
    //IDCongDoan: int.tryParse(json['IDCongDoan']?.toString() ?? '0') ?? 0,
    //IDCaLamViec: json['IDCaLamViec']?.toString() ?? '',
    //CaLamViec: json['CaLamViec']?.toString() ?? '',
    // NgayVaoLam: DateTime.tryParse(json['NgayVaoLam'] ?? '') ?? DateTime.now(),
    // NgayKyHopDong: DateTime.tryParse(json['NgayKyHopDong'] ?? '') ?? DateTime.now(),
    // NgayKyHopDong2: DateTime.tryParse(json['NgayKyHopDong2'] ?? '') ?? DateTime.now(),
    // NgayKyHopDong3: DateTime.tryParse(json['NgayKyHopDong3'] ?? '') ?? DateTime.now(),
    // NgayHetHanHopDong: DateTime.tryParse(json['NgayHetHanHopDong'] ?? '') ?? DateTime.now(),
    // NgayHetHanHopDong2: DateTime.tryParse(json['NgayHetHanHopDong2'] ?? '') ?? DateTime.now(),
    // NgayHetHanHopDong3: DateTime.tryParse(json['NgayHetHanHopDong3'] ?? '') ?? DateTime.now(),
    // NgayNghiViec: DateTime.tryParse(json['NgayNghiViec'] ?? '') ?? DateTime.now(),
    DienThoai: json['DienThoai']?.toString() ?? '',
    // DiaChiTamTru: json['DiaChiTamTru']?.toString() ?? '',
    // DiaChiThuongTru: json['DiaChiThuongTru']?.toString() ?? '',
    // NguyenQuan: json['NguyenQuan']?.toString() ?? '',
    // SoCMND: json['SoCMND']?.toString() ?? '',
    // NgayCapCMND: DateTime.tryParse(json['NgayCapCMND'] ?? '') ?? DateTime.now(),
    // NoiCapCMND: json['NoiCapCMND']?.toString() ?? '',
    // SoTheCanCuoc: json['SoTheCanCuoc']?.toString() ?? '',
    // NgayCapTCC: DateTime.tryParse(json['NgayCapTCC'] ?? '') ?? DateTime.now(),
    // NoiCapTCC: json['NoiCapTCC']?.toString() ?? '',
    // GioiTinh: json['GioiTinh']?.toString() ?? '',
    // HinhNhanVien: json['HinhNhanVien']?.toString() ?? '',
    // GiaoDien: json['GiaoDien']?.toString() ?? '',
    // TinhTrangHonNhan: json['TinhTrangHonNhan']?.toString() ?? '',
    Email: json['Email']?.toString() ?? '',
    //NgoaiNgu: json['NgoaiNgu']?.toString() ?? '',
    //GhiChu: json['GhiChu']?.toString() ?? '',
    BoPhan: json['BoPhan']?.toString() ?? '',
    //Token: json['Token']?.toString() ?? '',
    //HinhAnh: json['HinhAnh']?.toString() ?? '',
    //IDParent: int.tryParse(json['IDParent']?.toString() ?? '0') ?? 0,
  );
}
