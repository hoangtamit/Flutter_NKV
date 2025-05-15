import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nkv/api/NhanVien/authorize_api.dart';
import 'package:nkv/api/ThietKe/thietke_api.dart';
import 'package:nkv/model/ThietKe/ThongTinDanTrang_V2.dart';
import 'package:nkv/model/ThietKe/tbl_tem_giay_cau_hinh_dan_trang.dart';
import 'package:nkv/model/ThietKe/tbl_GiayLon.dart';
import 'package:nkv/services/show_Dialog.dart';
import '../../api/NghiepVu/donsanxuat_api.dart';
import '../../utilities/loading_dialog.dart';
import 'package:open_file/open_file.dart';
import '../../widgets/wdatatable.dart';
import 'cau-hinh-dan-trang.dart';

List<tbl_GiayLon> dsGiayLon = [];
List<ThongTinDanTrang_V2> dsTinhDanTrang = [];
bool showRender = false; // cờ để hiển thị render
String? dropdownValue;
tbl_TemGiay_CauHinhDanTrang _config = CauHinh_Default;

class frmKichThuocGiay extends StatelessWidget {
  final AuthorizeApi auth = AuthorizeApi();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GiayLonApi.LoadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Lỗi: ${snapshot.error}'));
        } else {
          return frmThongTin(dsGiayLon: snapshot.data as List<tbl_GiayLon>);
        }
      },
    );
  }
}

class frmThongTin extends StatefulWidget {
  final List<tbl_GiayLon> dsGiayLon;
  const frmThongTin({super.key, required this.dsGiayLon});
  @override
  State<frmThongTin> createState() => _frmThongTinState();
}
class _frmThongTinState extends State<frmThongTin> {
  final TextEditingController _maxController = TextEditingController();
  final TextEditingController _giaylonController = TextEditingController();
  final TextEditingController _kichthuocController = TextEditingController();
  String? dropdownValue;
  List<ThongTinDanTrang_V2> dsTinhDanTrang = [];
  bool showRender = false;
  void initState() {
    super.initState();
    _kichthuocController.text = '46x92';
    _giaylonController.text = '889-1194';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tính Dàn Trang Giấy'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  child: Column(
                    children: [
                      /// Dropdown + Cấu hình
                      Row(
                        children: [
                          Expanded(
                            child: DropdownMenu<String>(
                              controller: _giaylonController,
                              textStyle: const TextStyle(fontSize: 14),
                              initialSelection: widget.dsGiayLon.isNotEmpty
                                  ? widget.dsGiayLon[6].idGiayLon.toString()
                                  : null,
                              dropdownMenuEntries: widget.dsGiayLon.map(
                                    (item) => DropdownMenuEntry<String>(
                                  value: item.idGiayLon.toString(),
                                  label: item.idGiayLon.toString(),
                                ),
                              ).toList(),
                              inputDecorationTheme: InputDecorationTheme(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.indigo),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton.icon(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => CauHinhDanTrang(config: _config)),
                              );
                              if (result != null && result is tbl_TemGiay_CauHinhDanTrang) {
                                setState(() => _config = result);
                                debugPrint('Nhận Dữ Liệu ${_config.ArtboardSpace}');
                              }
                            },
                            icon: const Icon(Icons.settings, size: 16),
                            label: const Text('Cấu hình'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      /// Kích thước + Tổng + Tính
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: _kichthuocController,
                              hint: '46x92',
                              icon: 'assets/images/size01_16.png',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildTextField(
                              controller: _maxController,
                              hint: 'Tổng',
                              icon: 'assets/images/sum01_16.png',
                              enabled: false,
                              hintColor: Colors.red,
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: _tinhDanTrang,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text('Tính'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (showRender && dsTinhDanTrang.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Card(

                    color: Colors.blue.shade100,
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: render(dsTinhDanTrang: dsTinhDanTrang)),
              ),
          ]
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required String icon,
    bool enabled = true,
    Color hintColor = Colors.black87,
  }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      style: TextStyle(color: hintColor, fontSize: 16),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(icon, width: 20),
        ),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 14, color: hintColor),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.indigo),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.indigo, width: 2),
        ),
      ),
    );
  }
  void _tinhDanTrang() async {
    if (_giaylonController.text.isEmpty || _kichthuocController.text.isEmpty) {
      ShowDialog.showAlertDialog(context, 'Vui lòng nhập đầy đủ thông tin');
      return;
    }
    try {
      final parts = _kichthuocController.text.split('x');
      if (parts.length != 2) {
        ShowDialog.showAlertDialog(context, 'Vui lòng nhập định dạng Width x Height');
        return;
      }
      _config.Width = double.parse(parts[0]);
      _config.Height = double.parse(parts[1]);
      _config.GhiChu = _giaylonController.text;
      var json = tbl_TemGiay_CauHinhDanTrangToJson(_config);
      final danhSachMoi = await KhoGiayInApi.tinhDanTrang(json);
      if (danhSachMoi.isNotEmpty) {
        final tb = danhSachMoi.reduce((a, b) => a.kgITong > b.kgITong ? a : b);
        _maxController.text = tb.kgITong.toString();
      }
      setState(() {
        dsTinhDanTrang = danhSachMoi;
        showRender = dsTinhDanTrang.isNotEmpty;
      });
    } catch (e) {
      ShowDialog.showAlertDialog(context, 'Lỗi: $e');
    }
  }
}

class render extends StatelessWidget {
  final List<ThongTinDanTrang_V2> dsTinhDanTrang;
  const render({super.key, required this.dsTinhDanTrang});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 155, // Chiều cao cố định bạn muốn (có thể điều chỉnh)
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 12,
            dataRowMaxHeight: 48,
            headingRowHeight: 50,
            border: TableBorder.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
            columns: const [
              DataColumn(
                label: Center(
                  child: SizedBox(width: 80, child: Text('KGI', textAlign: TextAlign.center, style: WDatatable.headerStyle)),
                ),
              ),
              DataColumn(
                label: Center(
                  child: SizedBox(width: 50, child: Text('SL', textAlign: TextAlign.center, style: WDatatable.headerStyle)),
                ),
              ),
              DataColumn(
                label: Center(
                  child: SizedBox(width: 50, child: Text('RK', textAlign: TextAlign.center, style: WDatatable.headerStyle)),
                ),
              ),
              DataColumn(
                label: Center(
                  child: SizedBox(width: 50, child: Text('Tổng', textAlign: TextAlign.center, style: WDatatable.headerStyle)),
                ),
              ),
              DataColumn(
                label: Center(
                  child: SizedBox(width: 50, child: Text('PDF', textAlign: TextAlign.center, style: WDatatable.headerStyle)),
                ),
              ),
            ],
            rows: dsTinhDanTrang.asMap().entries.map((entry) {
              final index = entry.key;
              final actor = entry.value;

              return DataRow(
                color: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                    return index.isEven ? Colors.grey.shade50 : Colors.white;
                  },
                ),
                cells: [
                  WDatatable.buildDataCell(actor.kgi.toString(), width: 80),
                  WDatatable.buildDataCell(actor.catGiay.toString(), width: 50),
                  WDatatable.buildDataCell(actor.rk.toString(), width: 50),
                  WDatatable.buildDataCell(actor.kgITong.toString(), width: 50),
                  DataCell(
                    Center(
                      child: SizedBox(
                        width: 50,
                        height: 30,
                        child: GestureDetector(
                          onTap: () async {
                            LoadingDialog.showLoadingDialog(context, "");
                            try {
                              var json = tbl_TemGiay_CauHinhDanTrangToJson(_config);
                              var json2 = thongTinDanTrangV2ToJson(actor);
                              var result = await KhoGiayInApi.ExportPdf(json, json2);
                              if (result.isNotEmpty) {
                                final String filePath = result[0].url;
                                final openResult = await OpenFile.open(filePath);
                                if (openResult.type != ResultType.done) {
                                  _showErrorSnackBar(context, 'Không thể mở file PDF: ${openResult.message}');
                                }
                              } else {
                                _showErrorSnackBar(context, 'Không tìm thấy file PDF');
                              }
                            } catch (e) {
                              ShowDialog.showAlertDialog(context, 'Lỗi khi xuất PDF: $e');
                            } finally {
                              LoadingDialog.hideLoadingDialog(context);
                            }
                          },
                          child: Image.asset(
                            'assets/images/pdf01_64.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
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
  final ThongTinDanTrang_V2 actor;
  const ActorItem({Key? key, required this.actor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Khổ giấy in: ${actor.kgi}, Cắt giấy: ${actor.catGiay}, RK: ${actor.rk}, Tổng: ${actor.kgITong}',
      hint: 'Nhấn để xuất PDF',
      child: InkWell(
        onTap: () async {
          LoadingDialog.showLoadingDialog(context, "");
          try {
            await DonSanXuatApi.ExportPdf(actor.kgi.toString());
          } catch (e) {
            ShowDialog.showAlertDialog(context, 'Lỗi khi xuất PDF: $e');
          } finally {
            LoadingDialog.hideLoadingDialog(context);
          }
        },
        borderRadius: BorderRadius.circular(10),
        splashColor: Colors.blue.withOpacity(0.2),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.grey[50]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(
                  context,
                  icon: Icons.description,
                  label: 'KGI:',
                  value: actor.kgi.toString(),
                ),
                _buildInfoRow(
                  context,
                  icon: Icons.description,
                  label: 'DT:',
                  value: actor.dt.toString(),
                ),
                _buildInfoRow(
                  context,
                  icon: Icons.cut,
                  label: 'SL:',
                  value: actor.catGiay.toString(),
                ),
                _buildInfoRow(
                  context,
                  icon: Icons.layers,
                  label: 'RK:',
                  value: actor.rk.toString(),
                ),
                _buildInfoRow(
                  context,
                  icon: Icons.calculate,
                  label: 'Tổng:',
                  value: actor.kgITong.toString(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.blue[700]),
          const SizedBox(width: 6),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Colors.red,
        ),
        Text('no actor is found with this name'),
      ],
    );
  }
}