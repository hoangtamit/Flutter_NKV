import 'dart:convert';
import 'package:flutter/material.dart';
import '../../model/ThietKe/tbl_tem_giay_cau_hinh_dan_trang.dart';

class CauHinhDanTrang extends StatefulWidget {
  final tbl_TemGiay_CauHinhDanTrang config;
  const CauHinhDanTrang({super.key,required this.config});
  @override
  State<CauHinhDanTrang> createState() => _CauHinhDanTrangState();
}

class _CauHinhDanTrangState extends State<CauHinhDanTrang> {
  // Biến trạng thái cho các trường số (ánh xạ từ _config)
  late Map<String, dynamic> _values;

  // Biến trạng thái cho checkbox
  late bool _Symmetry;
  late bool _SelfReturn;
  late tbl_TemGiay_CauHinhDanTrang _config;
  // Biến trạng thái cho radio button
  late String _layoutDirection;
  @override
  void initState() {
    super.initState();
    _config = widget.config;
    _values = {
      'ArtboardWidth': _config.ArtboardWidth,
      'ArtboardHeight': _config.ArtboardHeight,
      'ArtboardSpace': _config.ArtboardSpace,
      'ArtboardNumber': _config.ArtboardNumber,
      'MarginLeft': _config.MarginLeft,
      'MarginRight': _config.MarginRight,
      'MarginBottom': _config.MarginBottom,
      'MarginTop': _config.MarginTop,
      'TrimMark_Length': _config.TrimMark_Length,
      'TrimMark_Space': _config.TrimMark_Space,
      'Width': _config.Width,
      'Height': _config.Height,
      'WidthPlace': _config.WidthPlace,
      'HeightPlace': _config.HeightPlace,
      'WidthSpace': _config.WidthSpace,
      'HeightSpace': _config.HeightSpace,
      'ColumnPosition': _config.ColumnPosition,
      'ColumnSpace': _config.ColumnSpace,
      'RowPosition': _config.RowPosition,
      'RowSpace': _config.RowSpace,
      'GhiChu': _config.GhiChu,
      // 'RK': _config.RK,
      // 'xay180': _config.Rotate ? 1 : 0,
      // 'activeDocum': _config.ActiveDocument ? 1 : 0,
    };
    // Khởi tạo trạng thái cho checkbox và radio button
    // _SelfReturn = _config.SelfReturn;
    // _Symmetry = _config.Symmetry;
    // _layoutDirection = _config.LayoutDirection;
  }

  // Hàm cập nhật giá trị số và đồng bộ với _config
  void _updateValue(String key, int delta) {
    setState(() {
      _values[key] = (_values[key]! + delta).clamp(0, 999);
      _config = tbl_TemGiay_CauHinhDanTrang(
        ArtboardWidth: _values[key]!,
        ArtboardHeight: _config.ArtboardHeight,
        ArtboardSpace: _config.ArtboardSpace,
        ArtboardNumber: _config.ArtboardNumber,
        MarginLeft: _config.MarginLeft,
        MarginRight: _config.MarginRight,
        MarginBottom: _config.MarginBottom,
        MarginTop: _config.MarginTop,
        Width: _config.Width,
        Height: _config.Height,
        WidthPlace: _config.WidthPlace,
        HeightPlace: _config.HeightPlace,
        RK: _config.RK,
        WidthSpace: _config.PaddingLeft + _config.PaddingRight,
        HeightSpace: _config.PaddingBottom + _config.PaddingTop,
        PaddingLeft: _config.PaddingLeft,
        PaddingRight: _config.PaddingRight,
        PaddingBottom: _config.PaddingBottom,
        PaddingTop: _config.PaddingTop,
        ColumnPosition: _config.ColumnPosition,
        ColumnSpace: _config.ColumnSpace,
        RowPosition: _config.RowPosition,
        RowSpace: _config.RowSpace,
        TrimMark_Length: _config.TrimMark_Length,
        TrimMark_Space: _config.TrimMark_Space,
        TrimMark_Thickness: _config.TrimMark_Thickness,
        TrimMark_Color: _config.TrimMark_Color,
        Symmetry: _config.Symmetry,
        SelfReturn: _config.SelfReturn,
        Rotate: _config.Rotate,
        ActiveDocument: _config.ActiveDocument,
        LayoutDirection: _config.LayoutDirection,
        GhiChu: _config.GhiChu,
      );
    });
  }
  // Widget cho một cặp trường số
  Widget _buildNumberFieldPair(String label1, String key1, String label2, String key2) {
    return Row(
      children: [
        Expanded(
          child: _buildNumberField(label1, key1),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildNumberField(label2, key2),
        ),
      ],
    );
  }

  // Widget cho một trường số
  Widget _buildNumberField(String label, String key, {bool highlight = false}) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            color: highlight ? Colors.blue[100] : Colors.grey[200],
            child: Text(label),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 60,
          color: highlight ? Colors.blue[100] : Colors.grey[200],
          child: Row(
            children: [
              Expanded(
                child: Center(child: Text('${_values[key]}')),
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () => _updateValue(key, 1),
                    child: const Icon(Icons.arrow_drop_up, size: 16),
                  ),
                  InkWell(
                    onTap: () => _updateValue(key, -1),
                    child: const Icon(Icons.arrow_drop_down, size: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget cho một cặp checkbox
  Widget _buildCheckboxPair(String label1, bool value1, ValueChanged<bool?> onChanged1, String label2, bool value2, ValueChanged<bool?> onChanged2) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Checkbox(value: value1, onChanged: onChanged1),
              Text(label1),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Row(
            children: [
              Checkbox(value: value2, onChanged: onChanged2),
              Text(label2),
            ],
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Form Layout'),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNumberFieldPair('Artboard Space:', 'ArtboardSpace', 'Artboard Number:', 'ArtboardNumber'),
                  const SizedBox(height: 8),
                  _buildNumberFieldPair('Margin Left:', 'MarginLeft', 'Margin Right:', 'MarginRight'),
                  const SizedBox(height: 8),
                  _buildNumberFieldPair('Margin Bottom:', 'MarginBottom', 'Margin Top:', 'MarginTop'),
                  const SizedBox(height: 8),
                  _buildNumberFieldPair('TrimMark Length:', 'TrimMark_Length', 'TrimMark Space:', 'TrimMark_Space'),
                  const SizedBox(height: 8),
                  _buildNumberFieldPair('Width Space:', 'WidthSpace', 'Height Space:', 'HeightSpace'),
                  const SizedBox(height: 8),
                  _buildNumberFieldPair('Column Position:', 'ColumnPosition', 'Column Space:', 'ColumnSpace'),
                  const SizedBox(height: 8),
                  _buildNumberFieldPair('Row Position:', 'RowPosition', 'Row Space:', 'RowSpace'),
                  const SizedBox(height: 8),
                  //_buildCheckboxPair('Symmetry': false),
                  // _buildCheckboxPair(
                  //   'Symmetry:', _Symmetry, (value) => setState(() => _Symmetry = value!),
                  //   'SelfReturn:', _SelfReturn, (value) => setState(() => _SelfReturn = value!),
                  // ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context, _config);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(120, 40),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Lưu và Truyền Dữ Liệu',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ]
            )
        )
    );
  }
}

