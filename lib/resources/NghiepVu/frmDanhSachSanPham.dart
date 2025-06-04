import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nkv/api/KhachHang/KhachHang_api.dart';
import 'package:nkv/api/NghiepVu/SanPhamApi.dart';
import '../../api/NghiepVu/donsanxuat_api.dart';
import '../../model/NghiepVu/tbl_DanhSachSanPham.dart';
import '../../model/KhachHang/tbl_KhachHang.dart';
import '../../widgets/wAppBar.dart';
import '../../widgets/wDropdownField.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:open_file/open_file.dart';
import '../../utilities/values/colors.dart';
//const Color primaryColor = Colors.blue;
const double cardMargin = 16.0;
const double borderRadius = 12.0;
const Color cardColor = Colors.white;
const double cardPadding = 0.0;
const double cardElevation = 4.0;
const double iconSize = 50.0;
const double labelFontSize = 16.0;
const double titleFontSize = 16.0;
const color = Colors.black87;
const double fontSize = 14;
const double width = 90;
List<tbl_DanhSachSanPham> dsDanhSachSanPham = [];

class frmDanhSachSanPham extends StatefulWidget {
  const frmDanhSachSanPham({super.key});
  @override
  _frmDanhSachSanPhamState createState() => _frmDanhSachSanPhamState();
}

class _frmDanhSachSanPhamState extends State<frmDanhSachSanPham> {
  String _searchQuery = '';
  List<tbl_DanhSachSanPham> _filteredList = [];
  final TextEditingController _KhachHangController = TextEditingController();
  List<tbl_KhachHang> dsKhachHang = [];
  String? _selectedKhachHang;
  bool _isLoading = false; // Biến trạng thái loading
  @override
  void initState() {
    super.initState();
    _filteredList = dsDanhSachSanPham;
    _loadKhachHangData();
  }
  @override
  void dispose() {
    _KhachHangController.dispose();
    super.dispose();
  }

  Future<void> _loadKhachHangData() async {
    try {
      final KhachHangData = await KhachHangApi.KhachHang_Get4C_V2();
      setState(() {
        dsKhachHang = KhachHangData;
        if (dsKhachHang.isNotEmpty) {
          _selectedKhachHang = KhachHangData[0].Alias;
          _KhachHangController.text = _selectedKhachHang!;
          // Tải danh sách sản phẩm cho khách hàng mặc định
          _loadDanhSachSanPham(_selectedKhachHang!);
        } else {
          //_showErrorSnackBar(context, 'Không tìm thấy khách hàng nào');
        }
      });
    } catch (e) {
      //_showErrorSnackBar(context, 'Lỗi khi tải danh sách khách hàng: $e');
    }
  }
  Future<void> _loadDanhSachSanPham(String TenKhachHang) async {
    try {
      _filteredList = [];
      final dsSanPham = await SanPhamApi.SanPham4C_GetTenKhachHang(TenKhachHang); // Giả định API trả về danh sách bộ phận
      setState(() {
        _filteredList = dsSanPham;
      });
    } catch (e) {
      //_showErrorSnackBar(context, 'Lỗi khi tải danh sách bộ phận: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar.buildAppBar('Danh Sách Sản Phẩm', onRefresh: () {
          setState(() {
            _loadKhachHangData(); // Làm mới cả danh sách bộ phận và sản phẩm
          });
        },),
      body: Container(
        padding: EdgeInsets.fromLTRB(16,0,16,0),
        child:
          Column(
            children: [
              //Expanded(child: wDropdownField.buildDropdownField(dsKhachHang, (value) {setState(() {_selectedKhachHang = value;});}, selectedValue: _selectedKhachHang)),
              Container(
                padding: EdgeInsets.fromLTRB(0, 16, 0,16),
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return dsKhachHang.map((tb) => tb.Alias);
                    }
                    return dsKhachHang.where((tb) => tb.Alias.toLowerCase().contains(textEditingValue.text.toLowerCase(),),).map((tb) => tb.Alias);
                  },
                  onSelected: (String selection) {
                    setState(() {
                      _KhachHangController.text = selection;
                      _loadDanhSachSanPham(selection); // Tải danh sách sản phẩm khi bộ phận được chọn;)
                    });
                  },
                  fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                    controller.text = _KhachHangController.text;
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        labelText: 'Khách Hàng',
                        prefixIcon: Icon(Icons.location_on),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        errorText: _KhachHangController.text.isEmpty ? 'Vui lòng nhập' : null,
                      ),
                      onSubmitted: (value) => onFieldSubmitted(),
                    );
                  },
                  //initialValue: TextEditingValue(text: selectedViTri ?? ''),
                ),
              ),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else if (_filteredList.isNotEmpty)
                Expanded(
                  child: SearchableList<tbl_DanhSachSanPham>(
                    itemBuilder: (item) => ActorItem(actor: item),
                    initialList: _filteredList,
                    filter: (query) => _filteredList.where((element) => element.MaSanPham.contains(query)).toList(),
                    emptyWidget: const EmptyView(),
                    inputDecoration: InputDecoration(
                      labelText: "Tìm kiếm MaSanPham",
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
                  ),
                )
              else
                const EmptyView(),
            ],
          ),
      ),
    );
  }
}
class ActorItem extends StatelessWidget {
  final tbl_DanhSachSanPham actor;
  const ActorItem({super.key, required this.actor});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: cardElevation,
      //margin: const EdgeInsets.symmetric(vertical: cardMargin),
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
          '${actor.MaSanPham}',
          style: const TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Row(
              children: [
                const SizedBox(
                  width: width,
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
                  width: width,
                  child: Text(
                    'Sản Phẩm',
                    style: TextStyle(fontWeight: FontWeight.bold, color: color),
                  ),
                ),
                Text(
                  actor.TenSanPham.toString(),
                  style: const TextStyle(color: color, fontSize: fontSize),
                  textScaler: TextScaler.linear(0.6),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: width,
                  child: Text(
                    'Kích Thước:',
                    style: TextStyle(fontWeight: FontWeight.bold, color: color),
                  ),
                ),
                Text(
                  actor.KichThuoc.toString(),
                  style: const TextStyle(color: color, fontSize: fontSize),
                ),
              ],
            ),
          ],
        ),
        //onTap: () => _openPdf(context, actor),
      ),
    );
  }

  Future<void> _openPdf(BuildContext context, tbl_DanhSachSanPham actor) async {
    try {
      final result;
      if(Platform.isAndroid) {
        result = await DonSanXuatApi.DownloadPdf(actor.MaSanPham.toString());
      }
      else{
        result = await DonSanXuatApi.OpenPdf(actor.MaSanPham.toString());
      }
      if (result.isNotEmpty) {
        final String pathfile = result[0].url;
        print('Đường dẫn file PDF: $pathfile');
        if (await File (pathfile).exists()) {
          final openResult;
          openResult = await OpenFile.open(pathfile);

          if (openResult.type != ResultType.done) {
            _showErrorSnackBar(context, 'Không thể mở file PDF: ${openResult.message}');
          }
        } else {
          _showErrorSnackBar(context, 'File PDF không tồn tại tại đường dẫn: $pathfile');
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
