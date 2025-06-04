import 'dart:convert';

tbl_Url tbl_UrlFromJson(String str) => tbl_Url.fromJson(json.decode(str));

String tbl_UrlToJson(tbl_Url data) => json.encode(data.toJson());

class tbl_Url {
  final int id;
  final String name;
  final String url;

  tbl_Url({
    required this.id,
    required this.name,
    required this.url,
  });

  factory tbl_Url.fromJson(Map<String, dynamic> json) => tbl_Url(
    id: json["ID"],
    name: json["Name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Name": name,
    "url": url,
  };
}
