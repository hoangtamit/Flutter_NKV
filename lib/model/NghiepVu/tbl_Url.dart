import 'dart:convert';

tbl_Url tbl_UrlFromJson(String str) => tbl_Url.fromJson(json.decode(str));

String tbl_UrlToJson(tbl_Url data) => json.encode(data.toJson());

class tbl_Url {
  final int id;
  final String name;
  final String Url;

  tbl_Url({
    required this.id,
    required this.name,
    required this.Url,
  });

  factory tbl_Url.fromJson(Map<String, dynamic> json) => tbl_Url(
    id: json["ID"],
    name: json["Name"],
    Url: json["Url"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Name": name,
    "Url": Url,
  };
}
