import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nkv/utilities/CenterScreen.dart';
import '../../api/NghiepVu/donsanxuat_api.dart';
import 'package:searchable_listview/searchable_listview.dart';
import '../../api/ThietKe/thietke_api.dart';
import '../../model/ThietKe/tbl_TemVai_TiLeTruc.dart';
import '../../utilities/values/colors.dart';
import '../../utilities/values/screen.dart';
import '../../widgets/wAppBar.dart';
import '../../widgets/wdatatable.dart';

const double cardMargin = 8.0;
const double cardPadding = 0.0;
const double cardElevation = 4.0;
const double borderRadius = 12.0;
List<tbl_TemVai_TiLeTruc> dsThietKe_TemVai_TiLeTruc = [];

class frmThietKe_TemVai_TiLeTruc extends StatefulWidget {
  const frmThietKe_TemVai_TiLeTruc({Key? key}) : super(key: key);
  @override
  frmThietKe_TemVai_TiLeTruc_State createState() => frmThietKe_TemVai_TiLeTruc_State();
}

class frmThietKe_TemVai_TiLeTruc_State extends State<frmThietKe_TemVai_TiLeTruc> {
  List<tbl_TemVai_TiLeTruc> filteredUsers = [];
  TextEditingController searchController = TextEditingController();
  bool _isLoading = false;

  Future<void> getdsThietKe_TemVai_TiLeTruc() async {
    try {
      setState(() {
        _isLoading = true;
      });
      var _dsThietKe_TemVai_TiLeTruc = await TiLeTrucApi.TemVai_TiLeTruc_LoadData();
      setState(() {
        print('---------------------------------dsThietKe_TemVai_TiLeTruc: ${_dsThietKe_TemVai_TiLeTruc.length}');
        dsThietKe_TemVai_TiLeTruc = _dsThietKe_TemVai_TiLeTruc;
        if (searchController.text.isEmpty) {
          filteredUsers = dsThietKe_TemVai_TiLeTruc;
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      //_showErrorSnackBar(context, 'Lỗi khi tải danh sách khách hàng: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getdsThietKe_TemVai_TiLeTruc();
    searchController.addListener(() {
      filterData();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterData() {
    final query = searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredUsers = dsThietKe_TemVai_TiLeTruc;
      } else {
        filteredUsers = dsThietKe_TemVai_TiLeTruc.where((item) {
          return item.KichThuocBangIn.toString().contains(query) || item.SoTruc.toString().contains(query) ||
              item.KichThuocThanhPham.toString().contains(query) || item.KichThuocDonHang.toString().contains(query);
        }).toList();
      }
      print('---------------------------------filteredUsers: ${filteredUsers.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final columns = [
      wDatatable.buildDataColumn('ID', width: screen.width(context, 1)),
      wDatatable.buildDataColumn('Số Trục', width: screen.width(context, 1.5)),
      wDatatable.buildDataColumn('B.In', width: screen.width(context, 1.5)),
      wDatatable.buildDataColumn('T.Phẩm', width: screen.width(context, 2)),
      wDatatable.buildDataColumn('Đ.Hàng', width: screen.width(context, 1.5)),
      wDatatable.buildDataColumn('SL', width: screen.width(context, 1)),
    ];

    return Scaffold(
      appBar: wAppBar.buildAppBar('Khổ Giấy In', onRefresh: () {
        getdsThietKe_TemVai_TiLeTruc();
      }),
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          children: [
            // TextField tìm kiếm
            Padding(
              padding: const EdgeInsets.symmetric(vertical: cardMargin),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Tìm kiếm',
                  prefixIcon: const Icon(Icons.search),
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: primaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                //onChanged: (value) => filterData(),
              ),
            ),
            // Nội dung chính
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : filteredUsers.isEmpty
                  ? Center(child: Text('Không tìm thấy dữ liệu'))
                  : Column(
                children: [
                  // Header cố định
                  Container(
                    color: Colors.grey.shade200,
                    child: DataTable(
                      columnSpacing: 8,
                      headingRowHeight: 48,
                      dataRowHeight: 0,
                      border: TableBorder.all(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                      columns: columns,
                      rows: const [],
                    ),
                  ),
                  // Nội dung cuộn
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 8,
                          headingRowHeight: 0,
                          dataRowHeight: 48,
                          border: TableBorder.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          columns: columns,
                          rows: [
                            ...List<DataRow>.generate(
                              filteredUsers.length,
                                  (index) => DataRow(
                                color: WidgetStateProperty.resolveWith<Color?>(
                                      (states) {
                                    if (states.contains(MaterialState.selected)) {
                                      return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                                    }
                                    return index.isEven ? Colors.grey.withOpacity(0.1) : null;
                                  },
                                ),
                                cells: [
                                  wDatatable.buildDataCell(filteredUsers[index].IDTiLeTruc.toString(), width: screen.width(context, 1)),
                                  wDatatable.buildDataCell(filteredUsers[index].SoTruc.toString(), width: screen.width(context, 1.5)),
                                  wDatatable.buildDataCell(filteredUsers[index].KichThuocBangIn.toString(), width: screen.width(context, 1.5)),
                                  wDatatable.buildDataCell(filteredUsers[index].KichThuocThanhPham.toString(), width: screen.width(context, 2)),
                                  wDatatable.buildDataCell(filteredUsers[index].KichThuocDonHang.toString(), width: screen.width(context, 1.5)),
                                  wDatatable.buildDataCell(filteredUsers[index].SoLuongTruc.toString(), width: screen.width(context, 1)),
                                ],
                              ),
                            ),
                          ],
                        ),
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