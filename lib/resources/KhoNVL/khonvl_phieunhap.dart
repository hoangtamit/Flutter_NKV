import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nkv/widgets/wTextField.dart';
import '../../api/KhoNVL/KhoNVL_api.dart';
import '../../model/KhoNVL/tbKhoNVL.dart';
import '../../model/KhoNVL/tbl_Avery_GiaoHang.dart';
import '../../utilities/PrintRibbon.dart';
import '../../utilities/values/colors.dart';
import '../../utilities/values/format.dart';
import '../../model/KhoNVL/tbl_ViTri.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import '../../utilities/fDateTime.dart';
import 'ViTri_ChiTiet.dart';

final TextEditingController _MaPhieuController = TextEditingController();
final TextEditingController _IDVatLieuController = TextEditingController();
final TextEditingController _KhoController = TextEditingController();
final TextEditingController _TenHangHoaController = TextEditingController();
final TextEditingController _DonViTinhController = TextEditingController();
final TextEditingController _QuyCachController = TextEditingController();
final TextEditingController _SoLuongController = TextEditingController();
final TextEditingController _ViTriController = TextEditingController();
final TextEditingController _NgayNhapController = TextEditingController();

class KhoNVL_PhieuNhap extends StatefulWidget {
  final tbl_Avery_GiaoHang tb;
  const KhoNVL_PhieuNhap({super.key, required this.tb});

  @override
  _KhoNVL_PhieuNhapState createState() => _KhoNVL_PhieuNhapState();
}

class _KhoNVL_PhieuNhapState extends State<KhoNVL_PhieuNhap> {
  late tbl_Avery_GiaoHang _tb;
  List<tbl_ViTri> dsViTri = [];
  List<tbl_Avery_GiaoHang> dsNhapKho = []; // Danh sách phiếu nhập kho
  String? selectedViTri;
  bool isLoading = true;
  String? errorMessage;
  final ScrollController _scrollController = ScrollController();
  final FocusNode _viTriFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _tb = widget.tb;
    _MaPhieuController.text = '';
    _IDVatLieuController.text = _tb.IDVatLieu?.toString() ?? '';
    _KhoController.text = 'AVERY (GIA CÔNG)';
    _TenHangHoaController.text = _tb.TenHangHoa?.toString() ?? _tb.Description?.toString() ?? '';
    _DonViTinhController.text = _tb.DonViTinh?.toString() ?? _tb.UOM?.toString() ?? '';
    _QuyCachController.text = _tb.QuyCach?.toString() ?? '';
    _SoLuongController.text = _tb.RequestedQuantity?.toString() ?? '';
    _NgayNhapController.text = fDateTime.DD_MM_YYYY(DateTime.now().toString());
    _loadViTriData();
    _loadDsNhapKho(); // Tải danh sách ban đầu
    _viTriFocusNode.addListener(() {
      if (_viTriFocusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 300), () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
    });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    _viTriFocusNode.dispose();
    super.dispose();
  }
  Future<void> _loadViTriData() async {
    try {
      dsViTri = await KhoNVLApi.ViTri_LoadData();
      print('Danh sách vị trí: $dsViTri'); // Debug
      if (dsViTri.isNotEmpty) {
        setState(() {
          //selectedViTri = dsViTri.first.ViTri;
          _ViTriController.text = selectedViTri ?? '';
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Không có dữ liệu vị trí';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Lỗi khi tải dữ liệu vị trí: $e';
        isLoading = false;
      });
    }
  }
  Future<void> _loadDsNhapKho() async {
    try {
      final data = await KhoNVLApi.Avery_GiaoHang_LoadData();
      setState(() {
        dsNhapKho = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi tải danh sách nhập kho: $e')),
      );
    }
  }
  Future<void> _submitForm() async {
    try {
      if(_MaPhieuController.text != null && _MaPhieuController.text != '' && _MaPhieuController.text != 'Mã Phiếu') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã thêm rồi nên không thể thực hiện tao tác này.')),);return;
      }
      if(_SoLuongController.text == null && _SoLuongController.text == '' ) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vui lòng nhập Số Lượng Kho !!!')),);return;
      }
      if(_ViTriController.text == null && _ViTriController.text == '' ) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vui lòng nhập Vị Trí Kho !!!')),);return;
      }
      if(_NgayNhapController.text == null && _NgayNhapController.text == '' ) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vui lòng nhập Ngày Nhập Kho !!!')),);return;
      }
      final json = jsonEncode({
        'ViTri': _ViTriController.text,
        'Kho': _KhoController.text,
        'MaVatLieu': _IDVatLieuController.text,
        'SoLuongNhap': _SoLuongController.text,
        'NhapXuat': printRibbon.Nhap,
        'NhaCungCap' : printRibbon.nccAD,
        'ThaoTac': printRibbon.NhapKho,
      });
      // Gửi dữ liệu qua API
      final result = await KhoNVLApi.KhoNVL_Insert_Json(json);
      if (result != null) {
        // Tải lại danh sách dsNhapKho
        await _loadDsNhapKho();
        _MaPhieuController.text = result[0].maPhieu;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thêm phiếu nhập thành công')),
        );
        // Quay lại màn hình trước (nếu cần)
        //Navigator.pop(context, dsNhapKho);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thêm phiếu nhập thất bại')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi thêm phiếu nhập: $e')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Phiếu Nhập Kho'),
        centerTitle: true,
        backgroundColor: primaryColor,//Theme.of(context).primaryColor,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text(errorMessage!, style: const TextStyle(color: Colors.red)))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          controller: _scrollController,
          children: [
            // Center(
            //   child: Image.asset(
            //     'assets/images/nkv.png',
            //     height: 100,
            //     fit: BoxFit.contain,
            //   ),
            // ),
            // const SizedBox(height: 16),
            // const Center(child: Text('Phiếu Nhập Kho', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),),
            const SizedBox(height: 16),
            wTextField.buildTextField(_MaPhieuController, 'Mã Phiếu', readOnly: true, icon: Icons.receipt,),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: (MediaQuery.sizeOf(context).width - 30) * 0.48,
                  child: wTextField.buildTextField2(controller: _SoLuongController, label: 'Số Lượng Nhập', keyboardType: TextInputType.number, icon: Icons.production_quantity_limits,),
                ),
                SizedBox(
                  width: (MediaQuery.sizeOf(context).width - 30) * 0.48,
                  child:             wTextField.buildTextField2(controller: _NgayNhapController,
                    label: 'Ngày Nhập (dd/MM/yyyy)',
                    icon: Icons.calendar_today,
                    keyboardType: TextInputType.datetime,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')), LengthLimitingTextInputFormatter(10), _DateInputFormatter(),],
                  ),
                ),
              ],),
            const SizedBox(height: 16),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return dsViTri.map((viTri) => viTri.ViTri);
                }
                return dsViTri
                    .where((viTri) =>
                    viTri.ViTri.toLowerCase().contains(textEditingValue.text.toLowerCase()))
                    .map((viTri) => viTri.ViTri);
              },
              onSelected: (String selection) {
                setState(() {
                  selectedViTri = selection;
                  _ViTriController.text = selection;
                });
              },
              fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                controller.text = _ViTriController.text;
                return Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        labelText: 'Vị Trí Kho',
                        prefixIcon: Icon(Icons.location_on),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        errorText: _ViTriController.text.isEmpty ? 'Vui lòng nhập' : null,
                      ),
                      onSubmitted: (value) => onFieldSubmitted(),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        ShowViTriKhoDialog(context,dsViTri, (selectedViTri) { setState(() {
                          selectedViTri = selectedViTri;
                          _ViTriController.text = selectedViTri;});
                        });
                      },
                    ),
                  ],
                );
              },
              initialValue: TextEditingValue(text: selectedViTri ?? ''),
            ),
            const SizedBox(height: 16),
            wTextField.buildTextField(_KhoController,  'Kho Nhập', readOnly: true, icon: Icons.warehouse,),
            const SizedBox(height: 16),
            wTextField.buildTextField(_IDVatLieuController,  'Mã Vật Liệu', readOnly: true, icon: Icons.code,),
            const SizedBox(height: 16),
            wTextField.buildTextField(_TenHangHoaController, 'Tên Hàng Hoá', readOnly: true, icon: Icons.description,),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: (MediaQuery.sizeOf(context).width - 30) * 0.4,
                    child: wTextField.buildTextField(_DonViTinhController, 'Đơn Vị Tính', readOnly: true, icon: Icons.scale,)),
                SizedBox(
                    width: (MediaQuery.sizeOf(context).width - 30) * 0.58,
                    child: wTextField.buildTextField(_QuyCachController,'Quy Cách', readOnly: true, icon: Icons.format_list_bulleted,)),
              ],),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Xác Nhận',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// class ViTriKho_ChiTiet extends StatelessWidget {
//   const ViTriKho_ChiTiet({super.key});
//   @override
//   return
// }
// class _ViTriKho_ChiTietState extends State<ViTriKho_ChiTiet> {
//   @override
//   return super.build(context);
// }
// TextInputFormatter tùy chỉnh cho định dạng dd/MM/yyyy
class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;
    if (newText.length > 10) {
      return oldValue;
    }
    // Loại bỏ các ký tự không phải số
    String digitsOnly = newText.replaceAll(RegExp(r'[^0-9]'), '');
    String formatted = '';

    // Định dạng lại thành dd/MM/yyyy
    if (digitsOnly.isNotEmpty) {
      if (digitsOnly.length <= 2) {
        formatted = digitsOnly;
      } else if (digitsOnly.length <= 4) {
        formatted = '${digitsOnly.substring(0, 2)}/${digitsOnly.substring(2)}';
      } else if (digitsOnly.length <= 8) {
        formatted = '${digitsOnly.substring(0, 2)}/${digitsOnly.substring(2, 4)}/${digitsOnly.substring(4)}';
      } else {
        formatted = '${digitsOnly.substring(0, 2)}/${digitsOnly.substring(2, 4)}/${digitsOnly.substring(4, 8)}';
      }
    }

    // Tính toán vị trí con trỏ
    int selectionIndex = formatted.length;
    if (newValue.selection.start <= formatted.length) {
      selectionIndex = newValue.selection.start + (formatted.length - newText.length);
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}