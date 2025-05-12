import 'package:flutter/material.dart';
import 'package:nkv/api/KhoNVL/KhoNVL_api.dart';
import 'package:nkv/model/KhoNVL/tbl_Avery_GiaoHang.dart';
import '../../model/KhoNVL/tbl_ViTri.dart';

final TextEditingController _IDVatLieuController = TextEditingController();
final TextEditingController _KhoController = TextEditingController();
final TextEditingController _TenHangHoaController = TextEditingController();
final TextEditingController _DonViTinhController = TextEditingController();
final TextEditingController _QuyCachController = TextEditingController();
final TextEditingController _RequestedQuantityController = TextEditingController();
final TextEditingController _ViTriController = TextEditingController();

class KhoNVL_PhieuNhap extends StatefulWidget {
  final tbl_Avery_GiaoHang tb;
  const KhoNVL_PhieuNhap({super.key, required this.tb});

  @override
  _KhoNVL_PhieuNhapState createState() => _KhoNVL_PhieuNhapState();
}

class _KhoNVL_PhieuNhapState extends State<KhoNVL_PhieuNhap> {
  late tbl_Avery_GiaoHang _tb;
  List<tbl_ViTri> dsViTri = [];
  String? selectedViTri;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _tb = widget.tb;
    _IDVatLieuController.text = _tb.IDVatLieu?.toString() ?? '';
    _KhoController.text = 'AVERY (GIA CÔNG)';
    _TenHangHoaController.text = _tb.TenHangHoa?.toString() ?? _tb.Description?.toString() ?? '';
    _DonViTinhController.text = _tb.DonViTinh?.toString() ?? _tb.UOM?.toString() ?? '';
    _QuyCachController.text = _tb.QuyCach?.toString() ?? '';
    _RequestedQuantityController.text = _tb.RequestedQuantity?.toString() ?? '';
    _loadViTriData();
  }

  Future<void> _loadViTriData() async {
    try {
      dsViTri = await KhoNVLApi.ViTri_LoadData();
      if (dsViTri.isNotEmpty) {
        setState(() {
          selectedViTri = dsViTri.first.ViTri;
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

  void _submitForm() {
    // Logic xử lý khi nhấn nút "Xác nhận"
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã gửi phiếu nhập')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phiếu Nhập Kho'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text(errorMessage!, style: const TextStyle(color: Colors.red)))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/nkv.png',
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Phiếu Nhập Kho',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: null,
                label: 'Mã Phiếu',
                readOnly: true,
                icon: Icons.receipt,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _KhoController,
                label: 'Kho Nhập',
                readOnly: true,
                icon: Icons.warehouse,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _IDVatLieuController,
                label: 'Mã Vật Liệu',
                readOnly: true,
                icon: Icons.code,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _TenHangHoaController,
                label: 'Tên Hàng Hoá',
                readOnly: true,
                icon: Icons.description,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _DonViTinhController,
                label: 'Đơn Vị Tính',
                readOnly: true,
                icon: Icons.scale,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _QuyCachController,
                label: 'Quy Cách',
                readOnly: true,
                icon: Icons.format_list_bulleted,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _RequestedQuantityController,
                label: 'Số Lượng Nhập',
                keyboardType: TextInputType.number,
                icon: Icons.production_quantity_limits,
              ),
              const SizedBox(height: 16),
              const Text('Vị Trí:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return dsViTri.map((viTri) => viTri.ViTri);
                  }
                  return dsViTri
                      .where(
                        (viTri) => viTri.ViTri.toLowerCase().contains(
                      textEditingValue.text.toLowerCase(),
                    ),
                  )
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
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      labelText: 'Tìm kiếm vị trí',
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onSubmitted: (value) => onFieldSubmitted(),
                  );
                },
                initialValue: TextEditingValue(text: selectedViTri ?? ''),
              ),
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
      ),
    );
  }

  Widget _buildTextField({
    TextEditingController? controller,
    required String label,
    bool readOnly = false,
    IconData? icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        filled: true,
        fillColor: readOnly ? Colors.grey[200] : Colors.white,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}