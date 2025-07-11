import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nkv/api/NhanVien/authorize_api.dart';
import 'package:nkv/api/ThietKe/thietke_api.dart';
import 'package:nkv/model/ThietKe/ThongTinDanTrang_V2.dart';
import 'package:nkv/model/ThietKe/tbl_tem_giay_cau_hinh_dan_trang.dart';
import 'package:nkv/model/ThietKe/tbKhoGiayIn.dart';
import 'package:nkv/model/ThietKe/tbl_GiayLon.dart';
import 'package:nkv/resources/Users/register_page.dart';
import 'package:nkv/services/show_Dialog.dart';
import '../../api/NghiepVu/donsanxuat_api.dart';
import '../../model/drop_list_model.dart';
import '../../utilities/loading_dialog.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:open_file/open_file.dart';
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
        } else if (snapshot.hasData) {
          return frmThongTin(dsGiayLon: snapshot.data as List<tbl_GiayLon>);
        }
        return frmThongTin(dsGiayLon: snapshot.data as List<tbl_GiayLon>);
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
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    DropdownMenu<String>(
                      width: MediaQuery.of(context).size.width / 2,
                      controller: _giaylonController,
                      textStyle: const TextStyle(fontSize: 12),
                      initialSelection: widget.dsGiayLon.isNotEmpty ? widget.dsGiayLon[6].idGiayLon.toString() : null,
                      dropdownMenuEntries: widget.dsGiayLon.isNotEmpty ? widget.dsGiayLon.map((item) => DropdownMenuEntry<String>(value: item.idGiayLon.toString(),
                        label: item.idGiayLon.toString(),)).toList() : [],
                      inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(8, 0, 0, 0)),
                    ElevatedButton(
                      onPressed: () async {
                        final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => CauHinhDanTrang(config: _config)));
                        if (result != null && result is tbl_TemGiay_CauHinhDanTrang) {
                          setState(() {
                            _config = result;
                          });
                          debugPrint('Nhận Dữ Liệu ${_config.ArtboardSpace}');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 40),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Cấu Hình',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 8)),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 10 * 3,
                      child: TextField(
                        controller: _kichthuocController,
                        style: const TextStyle(color: Colors.black87, fontSize: 16),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/images/size01_16.png', width: 20),
                          ),
                          hintText: '46x92',
                          hintStyle: const TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.blue, width: 2),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 8, 0)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 10 * 3,
                      child: TextField(
                        controller: _maxController,
                        enabled: false,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/images/sum01_16.png', width: 20),
                          ),
                          hintText: 'Tổng',
                          hintStyle: const TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.blue, width: 2),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
                    ElevatedButton(
                      onPressed: () async {
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
                          if (danhSachMoi.length > 0) {
                            final tb = danhSachMoi.reduce((a, b) => a.kgITong > b.kgITong ? a : b);
                            _maxController.text = tb.kgITong.toString();
                            debugPrint('------------------------- Số lớn nhất: ${tb.kgITong}');
                          }
                          setState(() {
                            dsTinhDanTrang = danhSachMoi ?? [];
                            showRender = dsTinhDanTrang.isNotEmpty;
                          });
                        } catch (e) {
                          ShowDialog.showAlertDialog(context, 'Lỗi: $e');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 40),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Tính',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (showRender && dsTinhDanTrang.isNotEmpty) render(dsTinhDanTrang: dsTinhDanTrang),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class render extends StatelessWidget {
  final List<ThongTinDanTrang_V2> dsTinhDanTrang;
  const render({super.key, required this.dsTinhDanTrang});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 0,
        dataRowMaxHeight: 48,
        headingRowHeight: 50,
        border: TableBorder.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
        columns: const [
          DataColumn(
            label: SizedBox(
              width: 50,
              child: Text(
                'KGI',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          DataColumn(
            label: SizedBox(
              //MediaQuery.of(context).size.width / 10 * 3,
              width: 60,
              child: Text(
                'SL',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          DataColumn(
            label: SizedBox(
              width: 60,
              child: Text(
                'RK',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          DataColumn(
            label: SizedBox(
              width: 60,
              child: Text(
                'Tổng',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          DataColumn(
            label: SizedBox(
              width: 50,
              child: Text(
                'PDF',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
        rows: dsTinhDanTrang.asMap().entries.map((entry) {
          final index = entry.key;
          final actor = entry.value;
          return DataRow(
            color: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                if (index % 2 == 0) {
                  return Colors.grey.shade50;
                }
                return Colors.white;
              },
            ),
            cells: [
              DataCell(
                SizedBox(
                  width: 50,
                  child: Text(
                    actor.kgi.toString(),
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                    // textAlign: TextAlign.center,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 60,
                  child: Text(
                    actor.catGiay.toString(),
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 60,
                  child: Text(
                    actor.rk.toString(),
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 60,
                  child: Text(
                    actor.kgITong.toString(),
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              DataCell(
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: SizedBox(
                    width: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        LoadingDialog.showLoadingDialog(context, "");
                        try {
                          var json = tbl_TemGiay_CauHinhDanTrangToJson(_config);
                          var json2 = thongTinDanTrangV2ToJson(actor);
                          var result = await KhoGiayInApi.ExportPdf(json,json2);
                          if (result.isNotEmpty && result[0].url != null) {
                            final String filePath = result[0].url; // Đường dẫn cục bộ
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
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        minimumSize: const Size(40, 20),
                      ),
                      child: const Text(
                        'PDF',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
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