import 'dart:convert';

VatLieu_Get4C VatLieu_Get4CFromJson(String str) => VatLieu_Get4C.fromJson(json.decode(str));

String VatLieu_Get4CToJson(VatLieu_Get4C data) => json.encode(data.toJson());

class VatLieu_Get4C {
  String? IDVatLieu;
  String? TenHangHoa;
  String? DonViTinh;
  String? QuyCach;
  String? Image;

  VatLieu_Get4C({
    required this.IDVatLieu,
    required this.TenHangHoa,
    required this.DonViTinh,
    required this.QuyCach,
    required this.Image,
  });

  Map<String, dynamic> toJson() => {
    'IDVatLieu': IDVatLieu,
    'TenHangHoa': TenHangHoa,
    'DonViTinh': DonViTinh,
    'QuyCach': QuyCach,
    'Image': Image,
  };

  factory VatLieu_Get4C.fromJson(Map<String, dynamic> json) => VatLieu_Get4C(
    IDVatLieu: json['IDVatLieu']?.toString() ?? '',
    TenHangHoa: json['TenHangHoa']?.toString() ?? '',
    DonViTinh: json['DonViTinh']?.toString() ?? '',
    QuyCach: json['QuyCach']?.toString() ?? '',
    Image: json['Image']?.toString() ?? '',
  );
}
