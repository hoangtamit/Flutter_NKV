import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:nkv/api/BoPhan/BoPhan_api.dart';
import 'package:nkv/api/NghiepVu/SanPhamApi.dart';
import 'package:nkv/widgets/wdatatable.dart';
import '../../api/NghiepVu/donsanxuat_api.dart';
import '../../model/NghiepVu/tbl_DanhSachSanPham.dart';
import '../../utilities/values/colors.dart';
import '../../widgets/wAppBar.dart';
import 'package:searchable_listview/searchable_listview.dart';
import '../../model/NghiepVu/tbl_Url.dart';
import '../../pdf/openpdf.dart';
import '../../utilities/fDateTime.dart';
import 'package:open_file/open_file.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

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
const double width = 90;
List<tbl_DanhSachSanPham> dsDanhSachSanPham = [];

class frmDanhSachSanPham extends StatefulWidget {
  const frmDanhSachSanPham({super.key});
  @override
  _frmDanhSachSanPhamState createState() => _frmDanhSachSanPhamState();
}
class _frmDanhSachSanPhamState extends State<frmDanhSachSanPham> {
  String _searchQuery = '';
  List<tbl_DanhSachSanPham> _filteredList = [];
  final TextEditingController _boPhanController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _filteredList = dsDanhSachSanPham;}
  @override
  void dispose() {
    _boPhanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar.buildAppBar(
        'Danh sách đơn sản xuất',
        onRefresh: () {
          setState(() {});
        },
      ),
      body: FutureBuilder<List<tbl_DanhSachSanPham>>(
        future: SanPhamApi.SanPham_Get4C(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Đã có lỗi xảy ra, vui lòng thử lại'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có dữ liệu đơn sản xuất'));
          }
          dsDanhSachSanPham = snapshot.data!;
          _filteredList = dsDanhSachSanPham.where((element) {
            return element.MaSanPham.contains(_searchQuery);
          }).toList();
          return Padding(
            padding: const EdgeInsets.all(cardMargin),
            child: _buildSearchableList(context),
          );
        },
      ),
    );
  }

  Widget _buildSearchableList(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: cardMargin),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _boPhanController,
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
                    //onTap: () => _selectDate(context, true),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SearchableList<tbl_DanhSachSanPham>(
              itemBuilder: (item) => ActorItem(actor: item),
              initialList: _filteredList,
              filter: (query) => _filteredList.where((element) => element.MaSanPham.contains(query)).toList(),
              emptyWidget: const EmptyView(),
              inputDecoration: InputDecoration(
                labelText: "Tìm kiếm MaSanPham",
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
          ),
        ],
      ),
    );
  }

  Future<void> _openPdf(BuildContext context, tbl_DanhSachSanPham actor) async {
    try {
      final result = await DonSanXuatApi.OpenPdf(actor.MaSanPham.toString());
      if (result.isNotEmpty) {
        final String pathfile = result[0].url;
        final openResult = await OpenFile.open(pathfile);
        if (openResult.type != ResultType.done) {
          _showErrorSnackBar(context, 'Không thể mở file PDF: ${openResult.message}');
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

class ActorItem extends StatelessWidget {
  final tbl_DanhSachSanPham actor;
  const ActorItem({super.key, required this.actor});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: cardElevation,
      margin: const EdgeInsets.symmetric(vertical: cardMargin),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      color: cardColor,
      child: ListTile(
        contentPadding: const EdgeInsets.all(cardPadding),
        leading: Image.asset(
          'assets/images/checklist-64.png',
          width: iconSize,
          height: iconSize,
        ),
        title: Text(
          '${actor.MaSanPham}',
          style: const TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Row(
              children: [
                const SizedBox(
                  width: width,
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
                  width: width,
                  child: Text(
                    'Sản Phẩm',
                    style: TextStyle(fontWeight: FontWeight.bold, color: color),
                  ),
                ),
                Text(
                  actor.TenSanPham.toString(),
                  style: const TextStyle(color: color, fontSize: fontSize),
                  textScaler: TextScaler.linear(0.6),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: width,
                  child: Text(
                    'Kích Thước:',
                    style: TextStyle(fontWeight: FontWeight.bold, color: color),
                  ),
                ),
                Text(
                  actor.KichThuoc.toString(),
                  style: const TextStyle(color: color, fontSize: fontSize),
                ),
              ],
            ),
          ],
        ),
        onTap: () => _openPdf(context, actor),
      ),
    );
  }

  Future<void> _openPdf(BuildContext context, tbl_DanhSachSanPham actor) async {
    try {
      final result;
      if(Platform.isAndroid) {
        result = await DonSanXuatApi.DownloadPdf(actor.MaSanPham.toString());
      }
      else{
        result = await DonSanXuatApi.OpenPdf(actor.MaSanPham.toString());
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

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error, color: Colors.red, size: 48),
        SizedBox(height: 8),
        Text('Không tìm thấy đơn sản xuất nào'),
      ],
    );
  }
}