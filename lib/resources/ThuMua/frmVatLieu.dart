import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nkv/api/ThuMua/VatLieuApi.dart';
import '../../api/ThuMua/MaHangHoaApi.dart';
import '../../model/ThuMua/VatLieu_Get4C.dart';
import '../../model/ThuMua/tbl_MaHangHoa.dart';
import '../../model/ThuMua/VatLieu_Get4C.dart';
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
List<VatLieu_Get4C> dsVatLieu = [];

class frmVatLieu extends StatefulWidget {
  const frmVatLieu({super.key});
  @override
  _frmVatLieuState createState() => _frmVatLieuState();
}

class _frmVatLieuState extends State<frmVatLieu> {
  String _searchQuery = '';
  List<VatLieu_Get4C> _filteredList = [];
  final TextEditingController _MaHangHoaController = TextEditingController();
  List<tbl_MaHangHoa> dsMaHangHoa = [];
  List<String> dsMaHangHoa2 = [];
  String? _selectedMaHangHoa;
  bool _isLoading = false; // Biến trạng thái loading
  @override
  void initState() {
    super.initState();
    _filteredList = dsVatLieu;
    _loadMaHangHoaData();
  }
  @override
  void dispose() {
    _MaHangHoaController.dispose();
    super.dispose();
  }

  Future<void> _loadMaHangHoaData() async {
    try {
      final MaHangHoaData = await MaHangHoaApi.MaHangHoa_LoadData();
      setState(() {
        dsMaHangHoa = MaHangHoaData;
        for (var item in dsMaHangHoa) {
          dsMaHangHoa2.add(item.DIENGIAI);
        }
        if (dsMaHangHoa.isNotEmpty) {
          _selectedMaHangHoa = MaHangHoaData[0].DIENGIAI;
          _MaHangHoaController.text = _selectedMaHangHoa!;
          _loadVatLieu(_selectedMaHangHoa!);
        } else {
          //_showErrorSnackBar(context, 'Không tìm thấy khách hàng nào');
        }
      });
    } catch (e) {
      //_showErrorSnackBar(context, 'Lỗi khi tải danh sách khách hàng: $e');
    }
  }
  Future<void> _loadVatLieu(String LoaiHang) async {
    try {
      _filteredList = [];
      final dsVatLieu = await VatLieuApi.VatLieu4C_GetLoaiHang(LoaiHang); // Giả định API trả về danh sách bộ phận
      setState(() {
        _filteredList = dsVatLieu;
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
          _loadMaHangHoaData(); // Làm mới cả danh sách bộ phận và sản phẩm
        });
      },),
      body: Container(
        padding: EdgeInsets.fromLTRB(16,0,16,0),
        child:
        Column(
          children: [
            //Expanded(child: wDropdownField.buildDropdownField(dsMaHangHoa2, (value) {setState(() {_selectedMaHangHoa = value;});}, selectedValue: _selectedMaHangHoa)),
            Container(
              padding: EdgeInsets.fromLTRB(0, 16, 0,8),
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return dsMaHangHoa.map((tb) => tb.DIENGIAI);
                  }
                  return dsMaHangHoa.where((tb) => tb.DIENGIAI.toLowerCase().contains(textEditingValue.text.toLowerCase(),),).map((tb) => tb.DIENGIAI);
                },
                onSelected: (String selection) {
                  setState(() {
                    _MaHangHoaController.text = selection;
                    _loadVatLieu(selection); // Tải danh sách sản phẩm khi bộ phận được chọn;)
                  });
                },
                fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                  controller.text = _MaHangHoaController.text;
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      labelText: 'Loại Sản Phẩm',
                      prefixIcon: Icon(Icons.production_quantity_limits, color: primaryColor),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      errorText: _MaHangHoaController.text.isEmpty ? 'Vui lòng nhập' : null,
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
                child: SearchableList<VatLieu_Get4C>(
                  itemBuilder: (item) => ActorItem(actor: item),
                  initialList: _filteredList,
                  filter: (query) => _filteredList.where((element) => element.TenHangHoa!.contains(query)).toList(),
                  emptyWidget: const EmptyView(),
                  inputDecoration: InputDecoration(
                    labelText: "Tìm kiếm Tên Hàng Hoá",
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
  final VatLieu_Get4C actor;
  const ActorItem({super.key, required this.actor});
  @override
  Widget build(BuildContext context) {
    int stt = 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black38, // Màu viền
            width: 0.5,           // Độ dày viền
          ),
          borderRadius: BorderRadius.circular(8), // Bo góc nếu cần
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(cardPadding),
          leading: Image.asset(
            'assets/images/checklist-64.png',
            width: iconSize,
            height: iconSize,
          ),
          title:Text(            actor.TenHangHoa.toString(),
            style: const TextStyle(color: color, fontSize: fontSize),
            textScaler: TextScaler.linear(0.8),
            maxLines: 2, // Cho phép tối đa 2 dòng
            overflow: TextOverflow.visible, // Văn bản sẽ xuống dòng
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
                      'Sản Phẩm',
                      style: TextStyle(fontWeight: FontWeight.bold, color: color),
                    ),
                  ),
                  Expanded( // Sử dụng Expanded để văn bản chiếm không gian còn lại
                    child: Text(
                      actor.IDVatLieu.toString(),
                      style: const TextStyle(color: color, fontSize: fontSize),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: width,
                    child: Text(
                      'Quy Cách',
                      style: TextStyle(fontWeight: FontWeight.bold, color: color),
                    ),
                  ),
                  Text(
                    actor.QuyCach.toString(),
                    style: const TextStyle(color: color, fontSize: fontSize),
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
                    actor.DonViTinh.toString(),
                    style: const TextStyle(color: color, fontSize: fontSize),
                  ),
                ],
              ),
            ],
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