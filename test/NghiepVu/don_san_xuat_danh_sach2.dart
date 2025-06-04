import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:nkv/widgets/wdatatable.dart';
import '../../widgets/wAppBar.dart';
import 'package:searchable_listview/searchable_listview.dart';
import '../../api/NghiepVu/donsanxuat_api.dart';
import '../../model/NghiepVu/DonSanXuat_Get15C.dart';
import '../../pdf/openpdf.dart';
import '../../utilities/fDateTime.dart';
import 'package:open_file/open_file.dart';
import 'package:intl/intl.dart';
// Hằng số cho màu sắc, kích thước, và khoảng cách
const Color primaryColor = Colors.blue;
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

class DonSanXuat_DanhSach extends StatefulWidget {
  const DonSanXuat_DanhSach({super.key});
  @override
  _DonSanXuat_DanhSachState createState() => _DonSanXuat_DanhSachState();
}

class _DonSanXuat_DanhSachState extends State<DonSanXuat_DanhSach> {
  String _searchQuery = '';
  List<DonSanXuat_Get15C> _filteredList = [];
  final NumberFormat _numberFormat = NumberFormat('#,###'); // Định dạng số lượng
  @override
  void initState() {
    super.initState();
    _filteredList = dsDonSanXuat;
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
      body: FutureBuilder<List<DonSanXuat_Get15C>>(
        future: DonSanXuatApi.DonSanXuat_LikeNgayXuongDon(),
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
          dsDonSanXuat = snapshot.data!;
          _filteredList = dsDonSanXuat.where((element) => element.SCD.contains(_searchQuery)).toList();
          return Padding(
            padding: const EdgeInsets.all(cardMargin),
            child: kIsWeb ? _buildDataTable(context) : _buildSearchableList(context),
          );
        },
      ),
    );
  }

  Widget _buildSearchableList(BuildContext context) {
    return SearchableList<DonSanXuat_Get15C>(
      itemBuilder: (item) => ActorItem(actor: item),
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
    );
  }

  Widget _buildDataTable(BuildContext context) {
    final filteredList = dsDonSanXuat.where((element) => element.SCD.contains(_searchQuery)).toList();
    final int totalQuantity = _filteredList.fold(0, (sum, item) => sum + (item.SoLuong ?? 0));
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: cardMargin, vertical: cardMargin),
          child: TextField(
            decoration: InputDecoration(
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
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  wDatatable.buildDataColumn('STT', 30),
                  wDatatable.buildDataColumn('SCD', 120),
                  wDatatable.buildDataColumn('Mã Sản Phẩm', 120),
                  DataColumn(label: Text('Khách Hàng', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Tên Sản Phẩm', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Bộ Phận', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Số Lượng', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Xuống Đơn', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Giao Hàng', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Vật Liệu', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: [
                  ...filteredList.asMap().entries.map((entry) {
                    final int index = entry.key + 1; // STT bắt đầu từ 1
                    final actor = entry.value;
                  return DataRow(
                    cells: [
                      wDatatable.buildDataCell(index.toString(),30),
                      wDatatable.buildDataCell(actor.SCD,120,onTap: () => _openPdf(context, actor)),
                      wDatatable.buildDataCell(actor.MaSanPham.toString(),100,),
                      DataCell(Text(actor.TenKhachHang.toString())),
                      DataCell(
                        Container(
                          constraints: const BoxConstraints(maxWidth: 300), // Giới hạn chiều rộng tối đa
                          child: Text(
                            actor.TenSanPham.toString(),
                            softWrap: true, // Cho phép xuống dòng
                            overflow: TextOverflow.visible, // Hiển thị toàn bộ text
                            style: const TextStyle(fontSize: fontSize),
                          ),
                        ),
                      ),
                      DataCell(Text(actor.BoPhan.toString())),
                      DataCell(Text(_numberFormat.format(actor.SoLuong ?? 0))), // Định dạng số lượng
                      DataCell(Text(fDateTime.DD_MM_YYYY(actor.NgayXuongDon.toString()))),
                      DataCell(Text(fDateTime.DD_MM_YYYY(actor.NgayGiaoHang.toString()))),
                      DataCell(Text(actor.VatLieu.toString())),
                    ],
                  );
                }).toList(),
                  DataRow(
                    cells: [
                      const DataCell(Text('Tổng', style: TextStyle(fontWeight: FontWeight.bold))),
                      const DataCell(Text('')),
                      const DataCell(Text('')),
                      const DataCell(Text('')),
                      const DataCell(Text('')),
                      const DataCell(Text('')),
                      DataCell(Text(_numberFormat.format(totalQuantity), style: const TextStyle(fontWeight: FontWeight.bold))),
                      const DataCell(Text('')),
                      const DataCell(Text('')),
                      const DataCell(Text('')),
                    ],
                  ),
                ]
              ),
            ),
          ),
        ),
        if (filteredList.isEmpty)
          const Padding(
            padding: EdgeInsets.all(cardMargin),
            child: EmptyView(),
          ),
      ],
    );
  }

  Future<void> _openPdf(BuildContext context, DonSanXuat_Get15C actor) async {
    try {
      final result = await DonSanXuatApi.OpenPdf(actor.SCD.toString());
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
  final DonSanXuat_Get15C actor;
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
          'SCD: ${actor.SCD}',
          style: const TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
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
    );
  }

  Future<void> _openPdf(BuildContext context, DonSanXuat_Get15C actor) async {
    try {
      final result = await DonSanXuatApi.OpenPdf(actor.SCD.toString());
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

