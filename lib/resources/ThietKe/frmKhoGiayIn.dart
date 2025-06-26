import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nkv/utilities/CenterScreen.dart';
import '../../api/ThietKe/khogiayin_api.dart';
import '../../api/NghiepVu/donsanxuat_api.dart';
import 'package:searchable_listview/searchable_listview.dart';
import '../../model/ThietKe/tbKhoGiayIn.dart';
import '../../utilities/values/colors.dart';
import '../../utilities/values/screen.dart';
import '../../widgets/wAppBar.dart';
import '../../widgets/wdatatable.dart';

const double cardMargin = 8.0;
const double cardPadding = 0.0;
const double cardElevation = 4.0;
const double borderRadius = 12.0;
List<tbKhoGiayIn> dsKhoGiayIn = [];

class frmKhoGiayIn extends StatefulWidget {
  const frmKhoGiayIn({Key? key}) : super(key: key);
  @override
  frmKhoGiayIn_State createState() => frmKhoGiayIn_State();
}

class frmKhoGiayIn_State extends State<frmKhoGiayIn> {
  List<tbKhoGiayIn> filteredUsers = [];
  TextEditingController searchController = TextEditingController();
  bool _isLoading = false;

  Future<void> getdsKhoGiayIn() async {
    try {
      setState(() {
        _isLoading = true;
      });
      var _dsKhoGiayIn = await KhoGiayInApi.LoadData();
      setState(() {
        print('---------------------------------dsKhoGiayIn: ${_dsKhoGiayIn.length}');
        dsKhoGiayIn = _dsKhoGiayIn;
        if (searchController.text.isEmpty) {
          filteredUsers = dsKhoGiayIn;
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
    getdsKhoGiayIn();
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
        filteredUsers = dsKhoGiayIn;
      } else {
        filteredUsers = dsKhoGiayIn.where((item) {
          return item.giayLon.toLowerCase().contains(query) ||
              item.catGiay.toLowerCase().contains(query) ||
              item.khoGiayIn.toLowerCase().contains(query) ||
              (item.xoGiay ?? '').toLowerCase().contains(query) ||
              item.ID.toString().contains(query);
        }).toList();
      }
      print('---------------------------------filteredUsers: ${filteredUsers.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final columns = [
      wDatatable.buildDataColumn('ID', width: screen.width(context, 1)),
      wDatatable.buildDataColumn('Giấy Lớn', width: screen.width(context, 2.5)),
      wDatatable.buildDataColumn('Cắt Giấy', width: screen.width(context, 2)),
      wDatatable.buildDataColumn('KGI', width: screen.width(context, 2.5)),
      wDatatable.buildDataColumn('Xớ', width: screen.width(context, 1.5)),
    ];

    return Scaffold(
      appBar: wAppBar.buildAppBar('Khổ Giấy In', onRefresh: () {
        getdsKhoGiayIn();
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
                                  wDatatable.buildDataCell(filteredUsers[index].ID.toString(), width: screen.width(context, 1)),
                                  wDatatable.buildDataCell(filteredUsers[index].giayLon.toString(), width: screen.width(context, 2.5)),
                                  wDatatable.buildDataCell(filteredUsers[index].catGiay.toString(), width: screen.width(context, 2)),
                                  wDatatable.buildDataCell(filteredUsers[index].khoGiayIn.toString(), width: screen.width(context, 2.5)),
                                  wDatatable.buildDataCell_Check(context,filteredUsers[index].xoGiay.toString()),
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