import 'package:flutter/material.dart';

class CauHinhDanTrang extends StatelessWidget {
  const CauHinhDanTrang({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyFormScreen(),
    );
  }
}
class MyFormScreen extends StatefulWidget {
  const MyFormScreen({super.key});

  @override
  State<MyFormScreen> createState() => _MyFormScreenState();
}

class _MyFormScreenState extends State<MyFormScreen> {
  // Biến trạng thái cho các trường số
  final Map<String, int> _values = {
    'artboardWidth': 0,
    'artboardHeight': 0,
    'artboardSpace': 20,
    'artboardNumber': 1,
    'limitBottom': 15,
    'limitTop': 0,
    'limitLeft': 0,
    'limitRight': 0,
    'lineLength': 3,
    'lineSpace': 2,
    'width': 0,
    'height': 0,
    'widthPlace': 0,
    'heightPlace': 0,
    'widthSpace': 3,
    'heightSpace': 3,
    'rk': 0,
    'kgiSpace': 0,
    'xay180': 0,
    'activeDocum': 3,
  };

  // Biến trạng thái cho checkbox
  bool _activeDocum = false;
  bool _tuTrd2Mat = false;
  bool _doiXuong = false;

  // Biến trạng thái cho radio button
  String _layoutDirection = 'Bottom,Left';

  // Hàm cập nhật giá trị số
  void _updateValue(String key, int delta) {
    setState(() {
      _values[key] = (_values[key]! + delta).clamp(0, 999);
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
            //color: highlight ? Colors.blue[100] : Colors.grey[200],
            child: Text(label, style: TextStyle(fontSize: 12),),
          ),
        ),
        const SizedBox(width: 4),
        Container(
          width: 60,
          //color: highlight ? Colors.blue[100] : Colors.grey[200],
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
            _buildNumberFieldPair('Artboard Width:', 'artboardWidth', 'Artboard Height:', 'artboardHeight'),
            const SizedBox(height: 8),
            _buildNumberFieldPair('Artboard Space:', 'artboardSpace', 'Artboard Number:', 'artboardNumber'),
            const SizedBox(height: 8),
            _buildNumberFieldPair('Limit Bottom:', 'limitBottom', 'Limit Top:', 'limitTop'),
            const SizedBox(height: 8),
            _buildNumberFieldPair('Limit Left:', 'limitLeft', 'Limit Right:', 'limitRight'),
            const SizedBox(height: 8),
            _buildNumberFieldPair('Line Length:', 'lineLength', 'Line Space:', 'lineSpace'),
            const SizedBox(height: 8),
            _buildNumberFieldPair('Width:', 'width', 'Height:', 'height'),
            const SizedBox(height: 8),
            _buildNumberFieldPair('Width Place:', 'widthPlace', 'Height Place:', 'heightPlace'),
            const SizedBox(height: 8),
            _buildNumberFieldPair('Width Space:', 'widthSpace', 'Height Space:', 'heightSpace',),
            const SizedBox(height: 8),
            _buildNumberFieldPair('Column Number:', 'widthSpace', 'Column Space:', 'heightSpace', ),
            const SizedBox(height: 8),
            _buildNumberFieldPair('Row Number:', 'widthSpace', 'Row Space:', 'heightSpace',),
            const SizedBox(height: 8),
            _buildNumberFieldPair('RK:', 'rk', 'KGI Space:', 'kgiSpace'),
            const SizedBox(height: 8),
            _buildNumberFieldPair('Xoay 180:', 'xay180', 'Active Docum:', 'activeDocum',),
            const SizedBox(height: 8),
            _buildCheckboxPair(
              'Đổi Xương:',
              _doiXuong,
                  (value) => setState(() => _doiXuong = value!),
              'Tu Trd 2 Mat:',
              _tuTrd2Mat,
                  (value) => setState(() => _tuTrd2Mat = value!),
            ),
            const SizedBox(height: 16),
            const Text('Layout Direction:', style: TextStyle(fontWeight: FontWeight.bold)),
            Column(
              children: [
                RadioListTile<String>(
                  title: const Text('Bottom,Left'),
                  value: 'Bottom,Left',
                  groupValue: _layoutDirection,
                  onChanged: (value) => setState(() => _layoutDirection = value!),
                  activeColor: Colors.red,
                ),
                RadioListTile<String>(
                  title: const Text('Left,Bottom'),
                  value: 'Left,Bottom',
                  groupValue: _layoutDirection,
                  onChanged: (value) => setState(() => _layoutDirection = value!),
                ),
                RadioListTile<String>(
                  title: const Text('Bottom,Right'),
                  value: 'Bottom,Right',
                  groupValue: _layoutDirection,
                  onChanged: (value) => setState(() => _layoutDirection = value!),
                ),
                RadioListTile<String>(
                  title: const Text('Right,Bottom'),
                  value: 'Right,Bottom',
                  groupValue: _layoutDirection,
                  onChanged: (value) => setState(() => _layoutDirection = value!),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}