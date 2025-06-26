import 'package:flutter/material.dart';
import '../../model/KhoBTP_TP/KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetNhap.dart';
import '../../model/KhoBTP_TP/tbl_KhoBTP_TP.dart';
import '../../model/KhoBTP_TP/tbl_KhoBTP_TP.dart';
import '../../utilities/values/screen.dart';
import '../../widgets/wdatatable.dart';
import '../../utilities/values/format.dart';
import '../../api/KhoBTP_TP/KhoBTP_TP_api.dart';
import '../../utilities/fDateTime.dart';
import '../../utilities/values/theme.dart';
import '../../widgets/widget_text.dart';
import '../../utilities/values/colors.dart';
class KhoBTP_TP_ChiTietNhap extends StatefulWidget {
  final KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetNhap tb;
  const KhoBTP_TP_ChiTietNhap({
    super.key,
    required this.tb,
  });
  @override
  _KhoBTP_TP_ChiTietNhapState createState() => _KhoBTP_TP_ChiTietNhapState();
}

class _KhoBTP_TP_ChiTietNhapState extends State<KhoBTP_TP_ChiTietNhap> {
  late KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetNhap chitiet;
  List<tbl_KhoBTP_TP> dsNhapKho = [];
  @override
  void initState() {
    super.initState();
    chitiet = widget.tb;

  }
  Future<List<tbl_KhoBTP_TP>> getdsNhapKho() async {
    dsNhapKho = await KhoBTP_TPApi.KhoBTP_TP_GetIDKhuVuc_GetMaPhieu(chitiet.MaPhieu!);
    return dsNhapKho;
  }
  Future<void> _refreshData() async {
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi Tiết Nhập Kho'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with material info
              const SizedBox(height: 8),
              Center(child: Text('Phiếu Nhập Kho: ${chitiet.MaPhieu}', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold,),)),
              const SizedBox(height: 8),
              Center(child: Text('Ngày Nhập: ' + fDateTime.DD_MM_YYYY(chitiet.Ngay.toString()), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold,),)),
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
                    future: getdsNhapKho(),
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
                      } else if (!snapshot.hasData) {
                        return const Center(child: Text('Không có dữ liệu'));
                      }
                      final data = snapshot.data!;
                      int TongSoLuong = data.fold(0, (sum, item) => sum + (item.SoLuongNhap ?? 0));
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing: wDatatable.columnSpacing,
                            //headingRowHeight: 45,
                            //dataRowHeight: 45,
                            border: TableBorder.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            columns: [
                              wDatatable.buildDataColumn('Mã Sản Phẩm',width: screen.width(context,3.5)),
                              wDatatable.buildDataColumn('DVT',width: screen.width(context,2)),
                              wDatatable.buildDataColumn('QC', width:screen.width(context,2)),
                              wDatatable.buildDataColumn('Số Lượng', width:screen.width(context,2)),
                            ],
                            rows: [
                            ...List<DataRow>.generate(data.length, (index) => DataRow(color: WidgetStateProperty.resolveWith<Color?>(
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
                              ), cells: [
                                wDatatable.buildDataCell(data[index].MaSanPham.toString(),width:screen.width(context,3.5)),
                                wDatatable.buildDataCell(data[index].DonViTinh.toString(),width:screen.width(context,2)),
                                wDatatable.buildDataCell(data[index].QuyCach.toString(),width:screen.width(context,2)),
                                wDatatable.buildDataCell(data[index].SoLuongNhap.toString(),width:screen.width(context,2)),
                              ],),),
                              // 🔽 DÒNG TỔNG CUỐI BẢNG
                              DataRow(
                                color: WidgetStateProperty.all(Colors.yellow.shade100),
                                cells: [
                                  wDatatable.buildDataCell('Tổng',width: screen.width(context, 3.5)),
                                  wDatatable.buildDataCell('', width:screen.width(context, 2)),
                                  wDatatable.buildDataCell('',width: screen.width(context, 2)),
                                  wDatatable.buildDataCell('$TongSoLuong',width: screen.width(context, 2)),
                                ],
                              ),
                            ],
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