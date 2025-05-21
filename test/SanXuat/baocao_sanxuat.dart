import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const double spacingHeight = 10;

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? selectedEmployeeId;
  String? selectedWatermark;

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
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.lightBlue[100],
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'THÔNG TIN CHUNG',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    SizedBox(height: spacingHeight),
                    Row(
                      children: [
                        Expanded(child: _buildDisabledTextField('Mã Nhân Viên:', '12')),
                        SizedBox(width: 16),
                        Expanded(child: _buildDisabledTextField('Tên Nhân Viên:', '')),
                      ],
                    ),
                    SizedBox(height: spacingHeight),
                    _buildDisabledTextField('Bộ Phận:', ''),
                  ],
                ),
              ),
              SizedBox(height: spacingHeight * 2),

              // Group: Thông Tin Đơn Hàng
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.lightGreen[100],
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'THÔNG TIN ĐƠN HÀNG',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    SizedBox(height: spacingHeight),
                    _buildDisabledTextField('SCD:', ''),
                    SizedBox(height: spacingHeight),
                    Row(
                      children: [
                        Expanded(child: _buildDisabledTextField('Số Lượng Đơn Hàng:', '0')),
                        SizedBox(width: 16),
                        Expanded(child: _buildDisabledTextField('Số Lượng Còn Lại:', '0')),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: spacingHeight * 2),

              // Group: Thông Tin Nháp
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.yellow[100],
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'THÔNG TIN NHÁP:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    SizedBox(height: spacingHeight),
                    _buildDropdownField('CheckWaterMark:', ['CheckWaterMark', 'NoCheck'], (value) {
                      setState(() {
                        selectedWatermark = value;
                      });
                    }),
                  ],
                ),
              ),
              SizedBox(height: spacingHeight * 2),

              // Group: Ngày Báo Cáo và Thông Tin Máy
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDropdownField('Ngày Báo Cáo:', ['12/12/2024'], (value) {
                      setState(() {
                        selectedEmployeeId = value;
                      });
                    }),
                    SizedBox(height: spacingHeight),
                    Row(
                      children: [
                        Expanded(child: _buildNumberTextField('Số Lượng Chạy Máy:', '0')),
                        SizedBox(width: 16),
                        Expanded(child: _buildNumberTextField('Thời Gian Chạy Máy (Phút):', '0')),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: spacingHeight * 2),

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
        enabled: false,
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
            flex: 3,
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