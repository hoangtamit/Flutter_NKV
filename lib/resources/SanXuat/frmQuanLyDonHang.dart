import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb, developer;
import 'package:flutter/material.dart';
import 'package:nkv/pdf/openpdf.dart';
import 'package:nkv/utilities/loading_dialog.dart';
import 'package:nkv/utilities/values/format.dart';
import '../../api/NghiepVu/donsanxuat_api.dart';
import '../../api/QuanLyDonHangApi/QuanLyDonHangApi.dart';
import '../../model/QuanLyDonHang/QuanLyDonHang_HoanThanhNull_Unpivoted.dart';
import '../../utilities/fDateTime.dart';
import '../../utilities/globals.dart';
import '../../utilities/values/colors.dart';
import '../../widgets/wAppBar.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

// Hằng số
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
  bool _isLoading = false;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _getDonSanXuat();
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  Future<void> _getDonSanXuat() async {
    setState(() {
      _scrollController = ScrollController();
      _isLoading = true;
    });
    try {
      dsDonHang = [];
      final KhachHangData = await QuanLyDonHangApi.QuanLyDonHang_HoanThanhNull_Unpivoted_GetCongDoan();
      setState(() {
        dsDonHang = KhachHangData;
        _isLoading = false;
        developer.log('Loaded ${dsDonHang.length} items', name: 'QuanLyDonHang');
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackBar(context, 'Lỗi khi tải danh sách đơn hàng: $e');
    }
  }
  // Hàm quét mã QR
  Future<void> _scanQRCode() async {
    try {
      if (kIsWeb) {
        _showErrorSnackBar(context, 'Quét mã QR không được hỗ trợ trên web');
        return;
      }
      final result = await BarcodeScanner.scan();
      if (result.rawContent.isNotEmpty) {
        final barcode = result.rawContent;
        if (barcode != null && barcode.length == 15) {
          for(var tb in dsDonHang){
            if(tb.SCD == barcode){
              tb.IDTo = Globals.NhanVien.IDTo;
              QuanLyDonHangApi.QuanLyDonHang_XacNhan(tb).then((value) {
                setState(() {
                  tb.Nhan = value[0].Nhan;
                  tb.HoanThanh = value[0].HoanThanh;
                });
                
              });
            }
          }
        }
        //developer.log('Scanned SCD: $barcode', name: 'QRScan');
        _focusOnDonHang(barcode);
      } else {
        _showErrorSnackBar(context, 'Mã QR không hợp lệ');
      }
    } catch (e) {
      _showErrorSnackBar(context, 'Lỗi khi quét mã QR: $e');
    }
  }
  // Hàm tìm và focus đơn hàng
  void _focusOnDonHang(String scd) {
    final index = dsDonHang.indexWhere((donHang) => donHang.SCD == scd);
    if (index != -1) {
      // Tìm thấy đơn hàng
      final itemHeight = 128.0; // Chiều cao mỗi mục (120 + padding 8)
      final offset = index * itemHeight;
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      _showErrorSnackBar(context, 'Đã tìm thấy đơn hàng: $scd');
    } else {
      _showErrorSnackBar(context, 'Không tìm thấy đơn hàng với SCD: $scd');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar.buildAppBar(
        'Danh Sách Đơn Hàng',
        onRefresh: _getDonSanXuat,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scanQRCode(),
        tooltip: 'Take a Photo',
        child: const Icon(Icons.barcode_reader),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Column(
          children: [
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
            else if (dsDonHang.isNotEmpty)
              Expanded(child: SearchableList<QuanLyDonHang_HoanThanhNull_Unpivoted>(
                  scrollController: _scrollController, // Thêm ScrollController
                  itemBuilder: (item) => _SearchableList(actor: item),
                  initialList: dsDonHang,
                  filter: (query) => dsDonHang.where((element) => element.SCD != null &&
                      element.SCD!.toLowerCase().contains(query.toLowerCase())).toList(),
                  emptyWidget: const Center(child: Text('Không tìm thấy đơn hàng')),
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
                ),)
             else
               const Center(child: Text('Không có đơn hàng nào')),
          ],
        ),
      ),
    );
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

class _SearchableList extends StatelessWidget {
  final QuanLyDonHang_HoanThanhNull_Unpivoted actor;
  const _SearchableList({super.key, required this.actor});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black38,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            GestureDetector(
              child: SizedBox(
                  width: 60, child: Image.asset('assets/images/checklist-64.png'),

              ), onTap: () { OpenPdf(context, actor.SCD.toString()); },
            ),
            const SizedBox(width: 5),
            SizedBox(
              width: 225,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          '${dsDonHang.indexOf(actor) + 1}.SCD: ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(actor.SCD.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 100,
                        child: Text(
                          'Khách Hàng: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(actor.TenKhachHang.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 100,
                        child: Text(
                          'Số Lượng: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(formatNumber(actor.SoLuong)),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 100,
                        child: Text(
                          'Ngày Giao: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(fDateTime.DD_MM_YYYY(actor.NgayGiaoHang.toString())),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Column(
                children: [
                  Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      value: actor.Nhan,
                      onChanged: (bool) {},
                      activeColor: Colors.green,
                      tristate: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      value: actor.HoanThanh,
                      onChanged: (bool) {},
                      activeColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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
}