import 'package:flutter/material.dart';
import 'package:qlsx/widgets/wdatatable.dart';
import 'package:qlsx/utilities/values/format.dart';
import '../../api/SanXuat/sanxuat_api.dart';
import '../../utilities/fDateTime.dart';
import '../../utilities/values/screen.dart';
import '../../utilities/values/theme.dart';
import '../../widgets/wAppBar.dart';
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
      appBar: wAppBar.buildAppBar('BÁO CÁO CHI TIẾT',onRefresh: () {setState(() {});},),
      body: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
// Header với thông tin vật liệu được cải thiện
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50, // Nền nhạt hơn
                  borderRadius: BorderRadius.circular(10.0), // Bo góc
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // Đổ bóng nhẹ
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Mã SCD: $_scd',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800, // Màu đậm hơn
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: Text(
                        'Công Đoạn: $_congdoan',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600, // Độ đậm vừa phải
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ],
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
                      int tongDat = data.fold(0, (sum, item) => sum + (item.SoLuongDat ?? 0));
                      int tongLoi = data.fold(0, (sum, item) => sum + (item.SoLuongLoi ?? 0));
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: // Tính tổng Đạt và Lỗi
                      DataTable(
                        columnSpacing: 8,
                        headingRowHeight: 48,
                        dataRowHeight: 48,
                        border: TableBorder.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                        columns: [
                          wDatatable.buildDataColumn('Bắt Đầu', screen.width(context, 3.5)),
                          wDatatable.buildDataColumn('Kết Thúc', screen.width(context, 3.5)),
                          wDatatable.buildDataColumn('Đạt', screen.width(context, 1.5)),
                          wDatatable.buildDataColumn('Lỗi', screen.width(context, 1.5)),
                          wDatatable.buildDataColumn('', screen.width(context, 1.5)), // Cột trống
                        ],
                        rows: [
                          ...List<DataRow>.generate(
                            data.length,
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
                                wDatatable.buildDataCell(
                                  fDateTime.DD_MM_YYYY_HH_MM(data[index].ThoiGian_BatDau.toString()),
                                  screen.width(context, 3.5),
                                ),
                                wDatatable.buildDataCell(
                                  fDateTime.DD_MM_YYYY_HH_MM(data[index].ThoiGian_KetThuc.toString()),
                                  screen.width(context, 3.5),
                                ),
                                wDatatable.buildDataCell(
                                  data[index].SoLuongDat.toString(),
                                  screen.width(context, 1.5),
                                ),
                                wDatatable.buildDataCell(
                                  (data[index].SoLuongLoi ?? '0').toString(),
                                  screen.width(context, 1.5),
                                ),
                                wDatatable.buildDataCell('', screen.width(context, 1.5)),
                              ],
                            ),
                          ),

                          // 🔽 DÒNG TỔNG CUỐI BẢNG
                          DataRow(
                            color: WidgetStateProperty.all(Colors.yellow.shade100),
                            cells: [
                              wDatatable.buildDataCell('Tổng', screen.width(context, 3.5)),
                              wDatatable.buildDataCell('', screen.width(context, 3.5)),
                              wDatatable.buildDataCell('$tongDat', screen.width(context, 1.5)),
                              wDatatable.buildDataCell('$tongLoi', screen.width(context, 1.5)),
                              wDatatable.buildDataCell('', screen.width(context, 1.5)),
                            ],
                          ),
                        ],
                      )
                      ,
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