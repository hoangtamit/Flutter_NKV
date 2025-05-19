import 'package:flutter/material.dart';
import 'package:nkv/widgets/wdatatable.dart';
import 'package:nkv/utilities/values/format.dart';
import '../../api/KhoNVL/KhoNVL_api.dart';
import '../../model/KhoNVL/tbKhoNVL.dart';
import '../../utilities/values/screen.dart';
import '../../utilities/values/theme.dart';
import '../../widgets/widget_text.dart';

class KhoNVL_ChiTietNhapXuat extends StatefulWidget {
  final String maVatLieu;
  final String viTri;
  final String kho;

  const KhoNVL_ChiTietNhapXuat({
    super.key,
    required this.maVatLieu,
    required this.viTri,
    required this.kho,
  });

  @override
  _KhoNVL_ChiTietNhapXuatState createState() => _KhoNVL_ChiTietNhapXuatState();
}

class _KhoNVL_ChiTietNhapXuatState extends State<KhoNVL_ChiTietNhapXuat> {
  late String _maVatLieu;
  late String _viTri;
  late String _kho;

  @override
  void initState() {
    super.initState();
    _maVatLieu = widget.maVatLieu;
    _viTri = widget.viTri;
    _kho = widget.kho;
  }

  Future<void> _refreshData() async {
    setState(() {}); // Trigger rebuild to fetch new data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi Tiết Nhập Xuất'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with material info
              Text(
                'Mã Vật Liệu: $_maVatLieu',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('Vị Trí: $_viTri | Kho: $_kho'),
              const SizedBox(height: 16),
              // DataTable with themed header
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dataTableTheme: DataTableThemeData(
                      headingRowColor: WidgetStateProperty.all(Colors.blue[300]), //
                      // Màu nền xanh cho header
                      headingTextStyle: const TextStyle(
                        color: Colors.white, // Chữ trắng để nổi bật trên nền xanh
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  child: FutureBuilder(
                    future: KhoNVLApi.KhoNVL_GetMaVatLieu_GetViTri_GetKho(
                      _maVatLieu,
                      _viTri,
                      _kho,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Lỗi: ${snapshot.error}'),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: _refreshData,
                                child: const Text('Thử lại'),
                              ),
                            ],
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('Không có dữ liệu'));
                      }

                      final data = snapshot.data!;
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing: 8,
                            headingRowHeight: 48,
                            dataRowHeight: 48,
                            border: TableBorder.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            columns: [
                              wDatatable.buildDataColumn('Nhập Xuất', screen.width(context,3)),
                              wDatatable.buildDataColumn('Ngày', screen.width(context,3)),
                              wDatatable.buildDataColumn('Số Lượng', screen.width(context,3)),
                            ],
                            rows: List<DataRow>.generate(
                              data.length,
                                  (index) => DataRow(
                                color: WidgetStateProperty.resolveWith<Color?>(
                                      (states) {
                                    if (states.contains(MaterialState.selected)) {
                                      return Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.08);
                                    }
                                    return index.isEven
                                        ? Colors.grey.withOpacity(0.1)
                                        : null;
                                  },
                                ),
                                cells: [
                                  wDatatable.buildDataCell(data[index].nhapXuat.toString(),  screen.width(context,3),),
                                  wDatatable.buildDataCell(fDateTime.DD_MM_YYYY(data[index].ngay.toString()), screen.width(context,3),),
                                  wDatatable.buildDataCell(data[index].soLuong.toString(),  screen.width(context,3),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}