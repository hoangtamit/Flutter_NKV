import 'package:flutter/material.dart';
import 'package:nkv/widgets/wdatatable.dart';
import 'package:nkv/utilities/values/format.dart';
import '../../api/SanXuat/sanxuat_api.dart';
import '../../utilities/fDateTime.dart';
import '../../utilities/values/screen.dart';
import '../../utilities/values/theme.dart';
import '../../widgets/widget_text.dart';

class BaoCao_SanXuat_ChiTiet extends StatefulWidget {
  final String SCD;
  final String CongDoan;
  const BaoCao_SanXuat_ChiTiet({super.key, required this.SCD, required this.CongDoan,});
  @override
  _BaoCao_SanXuat_ChiTietState createState() => _BaoCao_SanXuat_ChiTietState();
}

class _BaoCao_SanXuat_ChiTietState extends State<BaoCao_SanXuat_ChiTiet> {
  late String _scd;
  late String _congdoan;

  @override
  void initState() {
    super.initState();
    _scd = widget.SCD;
    _congdoan = widget.CongDoan;
  }

  Future<void> _refreshData() async {
    setState(() {}); // Trigger rebuild to fetch new data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi Tiết Báo Cáo'),
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
              Center(
                child: Text(
                  'SCD: $_scd',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Công Đoạn: $_congdoan',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
                    future: SanXuatApi.BaoCaoSanXuat_V2_GetSCD_GetCongDoan(_scd, _congdoan),
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
                              wDatatable.buildDataColumn('Bắt Đầu', screen.width(context,3.5)),
                              wDatatable.buildDataColumn('Kết Thúc', screen.width(context,3.5)),
                              wDatatable.buildDataColumn('Đạt', screen.width(context,1.5)),
                              wDatatable.buildDataColumn('Lỗi', screen.width(context,1.5)),
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
                                  wDatatable.buildDataCell(fDateTime.DD_MM_YYYY_HH_MM(data[index].ThoiGian_BatDau.toString()),  screen.width(context,3.5),),
                                  wDatatable.buildDataCell(fDateTime.DD_MM_YYYY_HH_MM(data[index].ThoiGian_KetThuc.toString()), screen.width(context,3.5),),
                                  wDatatable.buildDataCell(data[index].SoLuongDat.toString(),  screen.width(context,1.5),),
                                  wDatatable.buildDataCell((data[index].SoLuongLoi ?? '0').toString(),  screen.width(context,1.5),),
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