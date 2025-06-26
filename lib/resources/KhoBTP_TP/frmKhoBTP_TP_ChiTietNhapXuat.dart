import 'package:flutter/material.dart';
import '../../widgets/wdatatable.dart';
import '../../utilities/values/format.dart';
import '../../api/KhoBTP_TP/KhoBTP_TP_api.dart';
import '../../utilities/fDateTime.dart';
import '../../utilities/values/screen.dart';
import '../../utilities/values/theme.dart';
import '../../widgets/widget_text.dart';
import '../../utilities/values/colors.dart';

class frmKhoBTP_TP_ChiTietNhapXuat extends StatefulWidget {
  final String maSanPham;
  final String viTri;
  final String kho;
  final String lo;
  const frmKhoBTP_TP_ChiTietNhapXuat({
    super.key,
    required this.maSanPham,
    required this.viTri,
    required this.kho,
    required this.lo,
  });

  @override
  _frmKhoBTP_TP_ChiTietNhapXuatState createState() => _frmKhoBTP_TP_ChiTietNhapXuatState();
}

class _frmKhoBTP_TP_ChiTietNhapXuatState extends State<frmKhoBTP_TP_ChiTietNhapXuat> {
  late String _maSanPham;
  late String _viTri;
  late String _kho;
  late String _lo;
  @override
  void initState() {
    super.initState();
    _maSanPham = widget.maSanPham;
    _viTri = widget.viTri;
    _kho = widget.kho;
    _lo = widget.lo;
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
                'Mã Vật Liệu: $_maSanPham',
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
                    future: KhoBTP_TPApi.KhoBTP_TP_GetMaVatLieu_GetViTri_GetKho_GetLo(_maSanPham, _viTri, _kho,_lo),
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
                      int TongNhap = data.fold(0, (sum, item) => sum + (item.SoLuongNhap ?? 0));
                      int TongXuat = data.fold(0, (sum, item) => sum + (item.SoLuongXuat ?? 0));
                      int Tong = TongNhap - TongXuat;
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
                              wDatatable.buildDataColumn('Nhập Xuất',width: screen.width(context,3)),
                              wDatatable.buildDataColumn('Ngày',width: screen.width(context,3)),
                              wDatatable.buildDataColumn('Số Lượng',width: screen.width(context,3)),
                            ],
                            rows: [
                            ...List<DataRow>.generate(
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
                                  wDatatable.buildDataCell(data[index].NhapXuat.toString(),width:  screen.width(context,3),),
                                  wDatatable.buildDataCell(fDateTime.DD_MM_YYYY(data[index].Ngay.toString()),width: screen.width(context,3),),
                                  wDatatable.buildDataCell(data[index].SoLuong.toString(), width: screen.width(context,3),),
                                ],
                              ),
                            ),
                              // 🔽 DÒNG TỔNG CUỐI BẢNG
                              DataRow(
                                color: WidgetStateProperty.all(Colors.yellow.shade100),
                                cells: [
                                  wDatatable.buildDataCell('Tổng',width: screen.width(context, 3)),
                                  wDatatable.buildDataCell('', width:screen.width(context, 3)),
                                  wDatatable.buildDataCell('$Tong',width: screen.width(context, 3)),
                                ],
                              ),
                          ]
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