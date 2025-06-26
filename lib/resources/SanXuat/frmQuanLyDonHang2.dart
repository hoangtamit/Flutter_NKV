import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:nkv/api/QuanLyDonHangApi/QuanLyDonHangApi.dart';
import '../../api/NghiepVu/donsanxuat_api.dart';
import '../../model/QuanLyDonHang/QuanLyDonHang_HoanThanhNull_Unpivoted.dart';
import '../../utilities/fDateTime.dart';
import '../../utilities/globals.dart';
import '../../utilities/values/colors.dart';
import '../../widgets/wAppBar.dart';
import '../KhoNVL/avery_giaohang.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:open_file/open_file.dart';

// Hằng số cho màu sắc, kích thước, và khoảng cách
//const Color primaryColor = Colors.blue;
const Color cardColor = Colors.white;
const double cardMargin = 8.0;
const double cardPadding = 0.0;
const double cardElevation = 4.0;
const double borderRadius = 12.0;
const double iconSize = 50.0;
const double labelFontSize = 16.0;
const double titleFontSize = 16.0;
const color = Colors.black87;
const double fontSize = 14;
List<QuanLyDonHang_HoanThanhNull_Unpivoted> dsDonHang = [];

class frmQuanLyDonHang extends StatefulWidget {
  const frmQuanLyDonHang({super.key});
  @override
  _frmQuanLyDonHangState createState() => _frmQuanLyDonHangState();
}
class _frmQuanLyDonHangState extends State<frmQuanLyDonHang> {
  bool _isLoading = false; // Biến trạng thái loading
  @override
  void initState() {
    super.initState();
    _getDonSanXuat();
    // searchController.addListener(() {
    //   filterData();
    // });
  }
  @override
  void dispose() {
    super.dispose();
  }
  Future<void> _getDonSanXuat() async {
    try {
      dsDonHang = [];
      final KhachHangData = await QuanLyDonHangApi.QuanLyDonHang_HoanThanhNull_Unpivoted_GetCongDoan();
      setState(() {
        dsDonHang = KhachHangData;
        print('---------------------------------------------------${dsDonHang.length}');
      });
    } catch (e) {
      //_showErrorSnackBar(context, 'Lỗi khi tải danh sách khách hàng: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: wAppBar.buildAppBar('Danh Sách Đơn Hàng', onRefresh: () {setState(() {});},),
        body: Container(
          padding: EdgeInsets.fromLTRB(16,8,16,0),
          child: Column(
            children: [
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else if (dsDonHang.isNotEmpty)
                Expanded(
                  child: SearchableList<QuanLyDonHang_HoanThanhNull_Unpivoted>(
                    itemBuilder: (item) => _SearchableList(actor: item,),
                    initialList: dsDonHang,
                    filter: (query) => dsDonHang.where((element) => element.SCD!.contains(query)).toList(),
                    emptyWidget: const EmptyView(),
                    inputDecoration: InputDecoration(
                      labelText: "Tìm kiếm SCD",
                      prefixIcon: const Icon(Icons.search, color: primaryColor),
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: primaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                  ),
                )
            ],
          ),
        )
    );
  }
}
class _SearchableList extends StatelessWidget {
  final QuanLyDonHang_HoanThanhNull_Unpivoted actor;
  const _SearchableList({super.key, required this.actor});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: dsDonHang.length,
        itemBuilder: (context, index) {
          int stt = index + 1;
          if(dsDonHang.isNotEmpty) {
            final user = dsDonHang[index];
            return  Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  //color: Colors.white,
                  border: Border.all(
                    color: Colors.black38, // Màu viền
                    width: 0.5,           // Độ dày viền
                  ),
                  borderRadius: BorderRadius.circular(8), // Bo góc nếu cần
                ),
                child: Row(
                  children: [
                    SizedBox(width: 60, child: Image.asset('assets/images/checklist-64.png')),
                    const SizedBox(                width: 5,              ),
                    SizedBox(
                      width: 225,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              SizedBox(width:100,
                                child: Text(stt.toString() + user.CongDoan.toString() +': ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(user.SCD.toString()),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(width:100,
                                child: Text('Khách Hàng: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(user.TenKhachHang.toString()),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(width:100,
                                child: Text('Số Lượng: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(user.SoLuong.toString()),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(width:100,
                                child: Text('Ngày Giao : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(fDateTime.DD_MM_YYYY(user.NgayGiaoHang.toString())),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //const SizedBox(                width: 10,              ),
                    SizedBox(
                      child: Column(
                        children: [
                          Transform.scale(
                            scale: 1.5,
                            child: Checkbox(value:user.Nhan.toString() == 'True' ? true : false, onChanged: (bool) {},
                              activeColor: Colors.green, tristate: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          Transform.scale(
                            scale: 1.5,
                            child : SizedBox(
                              child: Checkbox(
                                value: user.HoanThanh.toString() == 'True' ? true : false,
                                onChanged: (bool) {}, activeColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return  const Text('ók');
        },
      ),
    );
  }

  Future<void> _openPdf(BuildContext context, QuanLyDonHang_HoanThanhNull_Unpivoted actor) async {
    try {
      final result;
      if(Platform.isAndroid) {
        result = await DonSanXuatApi.DownloadPdf(actor.SCD.toString());
      }
      else{
        result = await DonSanXuatApi.OpenPdf(actor.SCD.toString());
      }
      if (result.isNotEmpty) {
        final String pathfile = result[0].url;
        print('Đường dẫn file PDF: $pathfile');
        if (await File (pathfile).exists()) {
          final openResult;
          openResult = await OpenFile.open(pathfile);

          if (openResult.type != ResultType.done) {
            _showErrorSnackBar(context, 'Không thể mở file PDF: ${openResult.message}');
          }
        } else {
          _showErrorSnackBar(context, 'File PDF không tồn tại tại đường dẫn: $pathfile');
        }
      } else {
        _showErrorSnackBar(context, 'Không tìm thấy file PDF');
      }
    } catch (e) {
      _showErrorSnackBar(context, 'Lỗi khi mở file PDF: $e');
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}