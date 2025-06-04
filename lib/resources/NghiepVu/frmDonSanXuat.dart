import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../../api/NghiepVu/donsanxuat_api.dart';
import '../../model/NghiepVu/DonSanXuat_Get15C.dart';
import '../../model/NghiepVu/tbdonsanxuat.dart';
import '../../pdf/openpdf.dart';
import '../../utilities/fDateTime.dart';
import '../../utilities/values/colors.dart';
import '../../widgets/wAppBar.dart';
import '../KhoNVL/avery_giaohang.dart';
import 'package:intl/intl.dart'; // Thêm package intl để định dạng số
import 'package:sticky_headers/sticky_headers.dart'; // Thêm package sticky_headers để cố định dòng tổng
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
List<DonSanXuat_Get15C> dsDonSanXuat = [];

class frmDonSanXuat extends StatefulWidget {
  const frmDonSanXuat({super.key});
  @override
  _frmDonSanXuatState createState() => _frmDonSanXuatState();
}
class _frmDonSanXuatState extends State<frmDonSanXuat> {
  DateTime? _fromDate;
  DateTime? _toDate;
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  bool _isLoading = false; // Biến trạng thái loading
  @override
  void initState() {
    super.initState();
    _toDate = DateTime.now();
    _fromDate = _toDate?.subtract(const Duration(days: 0));
    _fromDateController.text = fDateTime.YYYY_MM_DD(_fromDate.toString());
    _toDateController.text = fDateTime.YYYY_MM_DD(_toDate.toString());
    _getDonSanXuat();
  }
  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }
  Future<void> _getDonSanXuat() async {
    try {
      dsDonSanXuat = [];
      final KhachHangData = await DonSanXuatApi.DonSanXuat_NgayXuongDon_Between(_fromDateController.text, _toDateController.text,);
       setState(() {
         dsDonSanXuat = KhachHangData;
      });
    } catch (e) {
      //_showErrorSnackBar(context, 'Lỗi khi tải danh sách khách hàng: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar.buildAppBar('Danh Sách Đơn Sản Xuất', onRefresh: () {setState(() {});},),
      body: Container(
        padding: EdgeInsets.fromLTRB(16,8,16,0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: cardMargin),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _fromDateController,
                      decoration: InputDecoration(
                        labelText: "Từ ngày",
                        prefixIcon: const Icon(Icons.calendar_today, color: primaryColor),
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
                      readOnly: true,
                      onTap: () => _selectDate(context, true),
                    ),
                  ),
                  const SizedBox(width: cardMargin),
                  Expanded(
                    child: TextField(
                      controller: _toDateController,
                      decoration: InputDecoration(
                        labelText: "Đến ngày",
                        prefixIcon: const Icon(Icons.calendar_today, color: primaryColor),
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
                      readOnly: true,
                      onTap: () => _selectDate(context, false),
                    ),
                  ),
                ],
              ),
            ),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (dsDonSanXuat.isNotEmpty)
              Expanded(
                child: SearchableList<DonSanXuat_Get15C>(
                  itemBuilder: (item) => _SearchableList(actor: item,),
                  initialList: dsDonSanXuat,
                  filter: (query) => dsDonSanXuat.where((element) => element.SCD.contains(query)).toList(),
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
  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? _fromDate ?? DateTime.now() : _toDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = picked;
          _fromDateController.text = fDateTime.YYYY_MM_DD(picked.toString());
        } else {
          _toDate = picked;
          _toDateController.text = fDateTime.YYYY_MM_DD(picked.toString());
        }
      });
    }
    _getDonSanXuat();
  }

  Widget _buildSearchableList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: SearchableList<DonSanXuat_Get15C>(
        itemBuilder: (item) => _SearchableList(actor: item),
        initialList: dsDonSanXuat,
        filter: (query) => dsDonSanXuat.where((element) => element.SCD.contains(query)).toList(),
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
    );
  }
}
class _SearchableList extends StatelessWidget {
  final DonSanXuat_Get15C actor;
  const _SearchableList({super.key, required this.actor});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black38, // Màu viền
            width: 0.5,           // Độ dày viền
          ),
          borderRadius: BorderRadius.circular(8), // Bo góc nếu cần
        ),
        //elevation: cardElevation,
        //margin: const EdgeInsets.symmetric(vertical: cardMargin),
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        //color: cardColor,
        child: ListTile(
          //contentPadding: const EdgeInsets.all(cardPadding),
          leading: Image.asset('assets/images/checklist-64.png', width: iconSize, height: iconSize,),
          title: Text('SCD: ${actor.SCD}', style: const TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold,),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  const SizedBox(
                    width: 100,
                    child: Text(
                      'Khách Hàng:',
                      style: TextStyle(fontWeight: FontWeight.bold, color: color),
                    ),
                  ),
                  Text(
                    actor.TenKhachHang.toString(),
                    style: const TextStyle(color: color, fontSize: fontSize),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 100,
                    child: Text(
                      'Bộ Phận:',
                      style: TextStyle(fontWeight: FontWeight.bold, color: color),
                    ),
                  ),
                  Text(
                    actor.BoPhan.toString(),
                    style: const TextStyle(color: color, fontSize: fontSize),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 100,
                    child: Text(
                      'Số Lượng:',
                      style: TextStyle(fontWeight: FontWeight.bold, color: color),
                    ),
                  ),
                  Text(
                    actor.SoLuong.toString(),
                    style: const TextStyle(color: color, fontSize: fontSize),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 100,
                    child: Text(
                      'Giao Hàng:',
                      style: TextStyle(fontWeight: FontWeight.bold, color: color),
                    ),
                  ),
                  Text(
                    fDateTime.DD_MM_YYYY(actor.NgayGiaoHang.toString()),
                    style: const TextStyle(color: color, fontSize: fontSize),
                  ),
                ],
              ),
            ],
          ),
          onTap: () => _openPdf(context, actor),
        ),
      ),
    );
  }

  Future<void> _openPdf(BuildContext context, DonSanXuat_Get15C actor) async {
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