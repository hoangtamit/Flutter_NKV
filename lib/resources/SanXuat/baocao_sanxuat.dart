import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const double spacingHeight = 10;
TextEditingController manhanvien = TextEditingController();
TextEditingController tennhanvien = TextEditingController();
TextEditingController bophan = TextEditingController();
TextEditingController scd = TextEditingController();
TextEditingController soluong = TextEditingController();
TextEditingController soluongconlai = TextEditingController();

class ReportScreen extends StatefulWidget {
  final SCD;
  const ReportScreen({super.key, required this.SCD});
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? selectedEmployeeId;
  String? selectedWatermark;
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BÁO CÁO SẢN XUẤT'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Group: Thông Tin Chung
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlueAccent, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      //color: Colors.lightBlue[100],
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'THÔNG TIN CHUNG',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),
                        ),
                      ),
                    ),
                    //SizedBox(height: spacingHeight),
                    Row(
                      children: [
                        SizedBox(width: 70, child: _buildDisabledTextField('MSNV:', '1234')),
                        SizedBox(width: 16),
                        Expanded(child: _buildDisabledTextField('Tên Nhân Viên:', 'Nguyễn Hoàng Tâm')),
                      ],
                    ),
                    //SizedBox(height: spacingHeight),
                    _buildDisabledTextField('Bộ Phận:', 'Thiết Kế'),
                    //SizedBox(height: spacingHeight),
                    _buildDisabledTextField('SCD:', 'LAN-250506-1157'),
                    //SizedBox(height: spacingHeight),
                    Row(
                      children: [
                        Expanded(child: _buildDisabledTextField('Số Lượng Đơn Hàng:', '12000')),
                        SizedBox(width: 16),
                        Expanded(child: _buildDisabledTextField('Số Lượng Còn Lại:', '5000')),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: spacingHeight),
              // Group: Ngày Báo Cáo và Thông Tin Máy
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlueAccent, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDropdownField('Công Đoạn:', ['In', 'Cắt', 'Kiểm'], (value) {
                      setState(() {
                        selectedWatermark = value;
                      });
                    }),
                    //SizedBox(height: spacingHeight),
                    _buildDropdownField('Ngày Báo Cáo:', ['12/12/2024'], (value) {
                      setState(() {
                        selectedEmployeeId = value;
                      });
                    }),
                    //SizedBox(height: spacingHeight),
                    Row(
                      children: [
                        Expanded(child: _buildNumberTextField('Số Lượng Chạy Máy:', '3000')),
                        SizedBox(width: 16),
                        Expanded(child: _buildNumberTextField('Thời Gian Chạy(Phút):', '40')),
                      ],
                    ),
                  ],
                ),
              ),
              //SizedBox(height: spacingHeight),
              // Nút Lưu
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Đã lưu thông tin!')),
                    );
                  },
                  child: Text('LƯU'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDisabledTextField(String label, String initialValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        readOnly: true,
        controller: TextEditingController(text: initialValue),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label),
          ),
          Expanded(
            flex: 4,
            child: DropdownButtonFormField<String>(
              value: items.contains(selectedEmployeeId) ? selectedEmployeeId : items.first,
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: onChanged,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberTextField(String label, String initialValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: TextEditingController(text: initialValue),
      ),
    );
  }
}