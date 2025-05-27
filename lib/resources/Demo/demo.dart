import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:qlsx/api/BoPhan/BoPhan_api.dart';
import 'package:qlsx/model/BoPhan/tbl_bophan.dart';

import '../../widgets/wDateTime.dart';
import 'hero_demo.dart';

// Màn hình chính, sử dụng Scaffold để hiển thị các widget
class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});
  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  // Controller cho TextField và TextFormField
  final TextEditingController _textController = TextEditingController(text: 'Nhập văn bản');
  final TextEditingController _dateController = TextEditingController(
    text: DateFormat('dd/MM/yyyy').format(DateTime.now()),
  );
  final TextEditingController _bophanController = TextEditingController();
  final TextEditingController _formController = TextEditingController();
  // Biến trạng thái
  String? _dropdownValue = 'Option 1';
  bool _checkboxValue = false;
  int? _radioValue = 1;
  double _sliderValue = 50;
  bool _switchValue = false;
  int _tabIndex = 0;
  String? selectedViTri;
  List<tbl_BoPhan> dsBoPhan = [];
  bool isLoading = true;
  String? errorMessage;
  Future<void> _loadBoPhanData() async {
    try {
      dsBoPhan = await BoPhanApi.Get1C();
      print('Danh sách vị trí: $dsBoPhan'); // Debug
      if (dsBoPhan.isNotEmpty) {
        setState(() {
          //selectedViTri = dsBoPhan.first.ViTri;
          _bophanController.text = selectedViTri ?? '';
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
  // Hàm hiển thị AlertDialog
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('AlertDialog Title'),
        content: const Text('This is an example of AlertDialog.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  // Hàm hiển thị BottomSheet
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('BottomSheet Example', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    _loadBoPhanData(); // Tải danh sách ban đầu

  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        //--------------------------------------------------- Scaffold: Widget cơ bản cung cấp bố cục (AppBar, Body, Drawer, FAB, v.v.)
        // Thuộc tính:
        // - appBar: Thanh tiêu đề
        // - body: Nội dung chính
        // - floatingActionButton: Nút nổi
        // - bottomNavigationBar: Thanh điều hướng dưới
        // - backgroundColor: Màu nền
        appBar: AppBar(
          //--------------------------------------------------- AppBar: Thanh tiêu đề với tiêu đề, nút hành động
          // Thuộc tính:
          // - title: Tiêu đề
          // - centerTitle: Căn giữa
          // - actions: Nút bên phải
          // - bottom: Widget dưới (ví dụ: TabBar)
          title: const Text('1. AppBar'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => setState(() {}),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
              Tab(text: 'Tab 3'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          //--------------------------------------------------- FloatingActionButton: Nút nổi tròn
          // Thuộc tính:
          // - onPressed: Hàm gọi khi nhấn
          // - child: Widget con (thường là Icon)
          // - backgroundColor: Màu nền
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('FAB pressed!')),
            );
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          //--------------------------------------------------- BottomNavigationBar: Thanh điều hướng dưới
          // Thuộc tính:
          // - items: Danh sách BottomNavigationBarItem
          // - currentIndex: Chỉ số mục hiện tại
          // - onTap: Hàm gọi khi nhấn
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
          currentIndex: 0,
          onTap: (index) {},
        ),
        body: ListView(
          //--------------------------------------------------- 01.ListView: Hiển thị danh sách cuộn
          // Thuộc tính:
          // - children: Danh sách widget con
          // - padding: Khoảng cách bên trong
          // - scrollDirection: Hướng cuộn
          padding: const EdgeInsets.all(16.0),
          children: [
            //---------------------------------------------------02.Container: Bọc widget với padding, margin, màu nền
            // Thuộc tính:
            // - child: Widget con
            // - padding, margin: Khoảng cách
            // - color, decoration: Màu nền, viền
            // - width, height: Kích thước
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey),
              ),
              child: const Text('2. Container: Bọc widget với viền và màu nền.'),
            ),

            //---------------------------------------------------03. Text: Hiển thị văn bản
            // Thuộc tính:
            // - data: Chuỗi văn bản
            // - style: Kiểu (fontSize, fontWeight, color)
            // - textAlign, maxLines, overflow
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Text(
                '3. Text: Hiển thị văn bản tùy chỉnh.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                textAlign: TextAlign.center,
              ),
            ),

            //---------------------------------------------------04. TextField: Nhập văn bản
            // Thuộc tính:
            // - controller: Quản lý nội dung
            // - decoration: Label, hint, border
            // - keyboardType, inputFormatters
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: '4. TextField: Nhập văn bản',
                  hintText: 'Nhập nội dung...',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.edit),
                  errorText: _textController.text.isEmpty ? 'Vui lòng nhập' : null,
                ),
                keyboardType: TextInputType.text,
                onChanged: (value) => setState(() {}),
              ),
            ),

            //---------------------------------------------------05.TextFormField: TextField với xác thực form
            // Thuộc tính:
            // - controller, decoration: Như TextField
            // - validator: Hàm xác thực
            // - onSaved: Hàm lưu giá trị
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: _formController,
                decoration: const InputDecoration(
                  labelText: '5. TextFormField: Nhập với xác thực',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.account_tree),
                ),
                validator: (value) => value!.isEmpty ? 'Vui lòng nhập' : null,
              ),
            ),

            //---------------------------------------------------06.TextField cho ngày (dd/MM/yyyy)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: '6. TextField (Date): Nhập ngày (dd/MM/yyyy)',
                  hintText: 'VD: 08/05/2025',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.calendar_today),
                  errorText: _dateController.text.isNotEmpty &&
                      !RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(_dateController.text)
                      ? 'Nhập đúng định dạng dd/MM/yyyy'
                      : null,
                ),
                keyboardType: TextInputType.datetime,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                  LengthLimitingTextInputFormatter(10),
                  _DateInputFormatter(),
                ],
              ),
            ),
            //--------------------------------------------------- 06.B. Kết hợp TextField và Autocomplete và FittedBox
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: wDateTime.buildDateTimeField(context,'6.B', _dateController,
                    (value) {try {DateTime.now();} catch (e) {}},),
            ),
            //---------------------------------------------------07. ElevatedButton: Nút nổi
            // Thuộc tính:
            // - onPressed: Hàm khi nhấn
            // - child: Widget con
            // - style: ButtonStyle
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('ElevatedButton pressed!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text('7. ElevatedButton: Nút nổi'),
              ),
            ),

            //---------------------------------------------------08. TextButton: Nút phẳng
            // Thuộc tính:
            // - onPressed, child, style
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('TextButton pressed!')),
                  );
                },
                child: const Text('8. TextButton: Nút phẳng'),
              ),
            ),

            //---------------------------------------------------09. IconButton: Nút biểu tượng
            // Thuộc tính:
            // - icon: Biểu tượng
            // - onPressed, color, tooltip
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: IconButton(
                icon: const Icon(Icons.favorite),
                color: Colors.red,
                tooltip: '9. IconButton: Nút biểu tượng',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('IconButton pressed!')),
                  );
                },
              ),
            ),

            //---------------------------------------------------10. Row: Sắp xếp ngang
            // Thuộc tính:
            // - children: Widget con
            // - mainAxisAlignment, crossAxisAlignment
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.star, color: Colors.yellow),
                  const Text('10. Row: Sắp xếp ngang'),
                  ElevatedButton(onPressed: () {}, child: const Text('Button')),
                ],
              ),
            ),

            //---------------------------------------------------11. Column: Sắp xếp dọc
            // Thuộc tính:
            // - children, mainAxisAlignment, crossAxisAlignment
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_upward, color: Colors.green),
                  const Text('11. Column: Sắp xếp dọc'),
                  ElevatedButton(onPressed: () {}, child: const Text('Button')),
                ],
              ),
            ),

            //---------------------------------------------------12. Stack: Xếp chồng widget
            // Thuộc tính:
            // - children: Widget con
            // - alignment: Căn chỉnh
            // - fit: Cách mở rộng widget con
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              height: 100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    color: Colors.blue,
                    width: 80,
                    height: 80,
                  ),
                  Container(
                    color: Colors.red,
                    width: 50,
                    height: 50,
                  ),
                  const Text('12. Stack:', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),

            //---------------------------------------------------13. Expanded: Mở rộng widget để chiếm không gian
            // Thuộc tính:
            // - child: Widget con
            // - flex: Tỷ lệ mở rộng
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.blue,
                      height: 50,
                      child: const Center(child: Text('13. Expanded: Chiếm 2/3')),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.green,
                      height: 50,
                      child: const Center(child: Text('1/3')),
                    ),
                  ),
                ],
              ),
            ),

            //---------------------------------------------------14. Padding: Thêm khoảng cách
            // Thuộc tính:
            // - padding: EdgeInsets
            // - child: Widget con
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: Colors.grey[200],
                child: const Text('14. Padding: Thêm khoảng cách xung quanh'),
              ),
            ),

            //---------------------------------------------------15. Center: Căn giữa widget con
            // Thuộc tính:
            // - child: Widget con
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              height: 50,
              color: Colors.grey[200],
              child: const Center(child: Text('15. Center: Căn giữa')),
            ),

            //---------------------------------------------------16. GridView: Hiển thị lưới
            // Thuộc tính:
            // - gridDelegate: Cấu hình lưới
            // - children: Widget con
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              height: 150,
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                children: List.generate(
                  6,
                      (index) => Container(
                    color: Colors.blue[100],
                    child: Center(child: Text('16. GridView: Item ${index + 1}')),
                  ),
                ),
              ),
            ),

            //---------------------------------------------------17. SingleChildScrollView: Cho phép cuộn một widget
            // Thuộc tính:
            // - child: Widget con
            // - scrollDirection: Hướng cuộn
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              height: 100,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    10,
                        (index) => Container(
                      width: 80,
                      margin: const EdgeInsets.only(right: 8.0),
                      color: Colors.blue[100],
                      child: Center(child: Text('17. SingleChildScrollView: ${index + 1}')),
                    ),
                  ),
                ),
              ),
            ),

            //---------------------------------------------------18. DataTable: Hiển thị bảng
            // Thuộc tính:
            // - columns: Danh sách DataColumn
            // - rows: Danh sách DataRow
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('18')),
                    DataCell(Text('Item A')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('2')),
                    DataCell(Text('Item B')),
                  ]),
                ],
              ),
            ),

            //---------------------------------------------------19. Card: Thẻ với bóng và viền
            // Thuộc tính:
            // - child: Widget con
            // - elevation: Độ bóng
            // - shape: Hình dạng
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 4,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('19. Card: Widget dạng thẻ'),
              ),
            ),

            //---------------------------------------------------20. Table: Bố cục bảng cơ bản
            // Thuộc tính:
            // - children: Danh sách TableRow
            // - border: Viền bảng
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Table(
                border: TableBorder.all(),
                children: const [
                  TableRow(children: [
                    Padding(padding: EdgeInsets.all(8.0), child: Text('20. Table: Cell 1')),
                    Padding(padding: EdgeInsets.all(8.0), child: Text('Cell 2')),
                  ]),
                ],
              ),
            ),

            //---------------------------------------------------21. Image: Hiển thị hình ảnh
            // Thuộc tính:
            // - image: AssetImage, NetworkImage
            // - width, height, fit
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Image.asset('assets/images/qlsx.png',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Text('21. Image: Lỗi tải hình'),
              ),
            ),

            //---------------------------------------------------22. Icon: Biểu tượng
            // Thuộc tính:
            // - icon, color, size
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Icon(
                Icons.star,
                color: Colors.yellow,
                size: 40,
                semanticLabel: '22. Icon: Ngôi sao',
              ),
            ),

            //---------------------------------------------------23. DropdownButton: Menu thả xuống
            // Thuộc tính:
            // - value, items, onChanged
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: DropdownButton<String>(
                value: _dropdownValue,
                hint: const Text('23. DropdownButton: Chọn tùy chọn'),
                isExpanded: true,
                items: ['Option 1', 'Option 2', 'Option 3']
                    .map((option) => DropdownMenuItem(
                  value: option,
                  child: Text(option),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _dropdownValue = value;
                  });
                },
              ),
            ),

            //---------------------------------------------------24. Checkbox: Hộp kiểm
            // Thuộc tính:
            // - value, onChanged, activeColor
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Checkbox(
                    value: _checkboxValue,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      setState(() {
                        _checkboxValue = value ?? false;
                      });
                    },
                  ),
                  const Text('24. Checkbox: Bật/tắt'),
                ],
              ),
            ),

            //---------------------------------------------------25. Radio: Nút chọn
            // Thuộc tính:
            // - value, groupValue, onChanged
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  const Text('25. Radio: Chọn tùy chọn'),
                  Row(
                    children: [
                      Radio<int>(
                        value: 1,
                        groupValue: _radioValue,
                        onChanged: (value) {
                          setState(() {
                            _radioValue = value;
                          });
                        },
                      ),
                      const Text('Option 1'),
                      Radio<int>(
                        value: 2,
                        groupValue: _radioValue,
                        onChanged: (value) {
                          setState(() {
                            _radioValue = value;
                          });
                        },
                      ),
                      const Text('Option 2'),
                    ],
                  ),
                ],
              ),
            ),

            //---------------------------------------------------26. Slider: Thanh trượt
            // Thuộc tính:
            // - value, min, max, divisions
            // - onChanged, label
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Slider(
                value: _sliderValue,
                min: 0,
                max: 100,
                divisions: 100,
                label: _sliderValue.round().toString(),
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
              ),
            ),

            //---------------------------------------------------27. Switch: Công tắc
            // Thuộc tính:
            // - value, onChanged, activeColor
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Switch(
                    value: _switchValue,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      setState(() {
                        _switchValue = value;
                      });
                    },
                  ),
                  const Text('27. Switch: Bật/tắt'),
                ],
              ),
            ),

            //---------------------------------------------------28. GestureDetector: Phát hiện cử chỉ
            // Thuộc tính:
            // - onTap, onDoubleTap, onLongPress
            // - child: Widget con
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('GestureDetector tapped!')),
                  );
                },
                child: Container(
                  color: Colors.blue[100],
                  padding: const EdgeInsets.all(16.0),
                  child: const Text('28. GestureDetector: Nhấn vào đây'),
                ),
              ),
            ),

            //---------------------------------------------------29. AlertDialog: Hộp thoại
            // Thuộc tính:
            // - title, content, actions
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () => _showAlertDialog(context),
                child: const Text('29. AlertDialog: Hiển thị hộp thoại'),
              ),
            ),

            //---------------------------------------------------30. SnackBar: Thông báo
            // Thuộc tính:
            // - content: Nội dung
            // - duration: Thời gian hiển thị
            // - action: Nút hành động
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('30. SnackBar: Thông báo'),
                      duration: const Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {},
                      ),
                    ),
                  );
                },
                child: const Text('Hiển thị SnackBar'),
              ),
            ),

            //---------------------------------------------------31. BottomSheet: Tấm dưới cùng
            // Thuộc tính:
            // - builder: Xây dựng nội dung
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () => _showBottomSheet(context),
                child: const Text('31. BottomSheet: Hiển thị tấm dưới'),
              ),
            ),

            //---------------------------------------------------32. TabBarView: Nội dung tab
            // Thuộc tính:
            // - children: Danh sách widget con
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              height: 100,
              child: TabBarView(
                children: [
                  Center(child: Text('32. TabBarView: Tab 1 content')),
                  Center(child: Text('Tab 2 content')),
                  Center(child: Text('Tab 3 content')),
                ],
              ),
            ),

            //---------------------------------------------------33. SliverAppBar: AppBar cuộn
            // Thuộc tính:
            // - title, flexibleSpace, expandedHeight
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              height: 150,
              child: CustomScrollView(
                slivers: [
                  const SliverAppBar(
                    title: Text('33. SliverAppBar'),
                    floating: true,
                    expandedHeight: 100,
                    flexibleSpace: FlexibleSpaceBar(
                      background: ColoredBox(color: Colors.blue),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 50,
                      color: Colors.grey[200],
                      child: const Center(child: Text('Sliver content')),
                    ),
                  ),
                ],
              ),
            ),

            //---------------------------------------------------34. AnimatedContainer: Container với hiệu ứng
            // Thuộc tính:
            // - duration: Thời gian chuyển đổi
            // - color, width, height
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () => setState(() {}),
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  width: _checkboxValue ? 100 : 50,
                  height: 50,
                  color: _checkboxValue ? Colors.blue : Colors.red,
                  child: const Center(child: Text('34. AnimatedContainer')),
                ),
              ),
            ),

            //---------------------------------------------------35. FutureBuilder: Xây dựng từ Future
            // Thuộc tính:
            // - future: Future cung cấp dữ liệu
            // - builder: Xây dựng giao diện
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: FutureBuilder<String>(
                future: Future.delayed(
                  const Duration(seconds: 2),
                      () => '35. FutureBuilder: Data loaded',
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),

            //---------------------------------------------------36. StreamBuilder: Xây dựng từ Stream
            // Thuộc tính:
            // - stream: Stream cung cấp dữ liệu
            // - builder: Xây dựng giao diện
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: StreamBuilder<int>(
                stream: Stream.periodic(const Duration(seconds: 1), (i) => i).take(5),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text('36. StreamBuilder: ${snapshot.data}');
                  }
                  return const Text('Waiting...');
                },
              ),
            ),

            //---------------------------------------------------37.  Hero: Hiệu ứng chuyển tiếp
            // Thuộc tính:
            // - tag: Định danh duy nhất
            // - child: Widget con
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Hero(
                tag: 'hero-tag',
                child: Image.asset('assets/images/qlsx.png',
                  width: 50,
                  height: 80,
                ),
              ),
            ),

            //---------------------------------------------------38. ClipRRect: Cắt góc bo tròn
            // Thuộc tính:
            // - borderRadius: Bán kính góc
            // - child: Widget con
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  color: Colors.blue,
                  width: 100,
                  height: 50,
                  child: const Center(child: Text('38. ClipRRect: Góc bo tròn')),
                ),
              ),
            ),

            //---------------------------------------------------39.  Opacity: Điều chỉnh độ trong suốt
            // Thuộc tính:
            // - opacity: Giá trị từ 0.0 đến 1.0
            // - child: Widget con
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  color: Colors.blue,
                  width: 100,
                  height: 50,
                  child: const Center(child: Text('39. Opacity: Trong suốt')),
                ),
              ),
            ),

            //--------------------------------------------------- 40 Divider: Đường phân cách
            // Thuộc tính:
            // - height, thickness, color
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Divider(
                height: 20,
                thickness: 2,
                color: Colors.grey,
              ),
            ),

            //--------------------------------------------------- 41 Spacer: Khoảng cách linh hoạt
            // Thuộc tính:
            // - flex: Tỷ lệ khoảng cách
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Text('41. Spacer: '),
                  const Spacer(),
                  ElevatedButton(onPressed: () {}, child: const Text('Button')),
                ],
              ),
            ),
            //--------------------------------------------------- 42 AspectRatio: Duy trì tỷ lệ
            // Thuộc tính:
            // - aspectRatio: Tỷ lệ chiều rộng/chiều cao
            // - child: Widget con
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: AspectRatio(
                aspectRatio: 2 / 1,
                child: Container(
                  color: Colors.blue[100],
                  child: const Center(child: Text('42. AspectRatio: 2:1')),
                ),
              ),
            ),

            //--------------------------------------------------- 43. FittedBox: Điều chỉnh kích thước Hình Ảnh
            // Thuộc tính:
            // - fit: BoxFit (contain, cover, fill)
            // - child: Widget con
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              width: 100,
              height: 100,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image.asset('assets/images/qlsx.png',
                ),
              ),
            ),
            //--------------------------------------------------- 44. Autocomplete kết hợp TextField để ra tính search data.
            // Thuộc tính:
            // - fit: BoxFit (contain, cover, fill)
            // - child: Widget con
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return dsBoPhan.map((tb) => tb.ID);
                }
                return dsBoPhan.where((tb) => tb.ID.toLowerCase().contains(textEditingValue.text.toLowerCase(),),).map((tb) => tb.ID);
              },
              onSelected: (String selection) {
                setState(() {
                  selectedViTri = selection;
                  _bophanController.text = selection;
                });
              },
              fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                controller.text = _bophanController.text;
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: 'Bộ Phận',
                    prefixIcon: Icon(Icons.location_on),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    errorText: _bophanController.text.isEmpty ? 'Vui lòng nhập' : null,
                  ),
                  onSubmitted: (value) => onFieldSubmitted(),
                );
              },
              initialValue: TextEditingValue(text: selectedViTri ?? ''),
            ),
            //--------------------------------------------------- 45. Hero kết hơp ListView: Xem hiệu ứng chuyển tiếp
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen_ListView()),
                  );
                },
                child: const Text('45. Hero kết hơp ListView: Xem hiệu ứng chuyển tiếp'),
              ),
            ),
            //--------------------------------------------------- 46. Hero kết hơp GridView: Xem hiệu ứng chuyển tiếp
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen_GridView()),
                  );
                },
                child: const Text('46. Hero kết hợp với GridView: Xem hiệu ứng chuyển tiếp'),
              ),
            ),
            //--------------------------------------------------- 47. Kết hợp Gridview và FittedBox
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              height: 500, // Tăng chiều cao để hiển thị nhiều mục
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 cột
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1, // Tỷ lệ vuông cho các ô
                ),
                //physics: const NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn
                shrinkWrap: true, // Điều chỉnh theo nội dung
                itemCount: 20,
                itemBuilder: (context, index) {
                  // Sử dụng Image.network thay vì Image.asset để minh họa đa dạng
                  // Bọc Image trong FittedBox để đảm bảo hình ảnh vừa ô
                  return FittedBox(
                    fit: BoxFit.cover,
                    child: Image.network(
                      'https://picsum.photos/250?image=$index',
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
// TextInputFormatter cho định dạng dd/MM/yyyy
class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;
    if (newText.length > 10) {
      return oldValue;
    }
    String digitsOnly = newText.replaceAll(RegExp(r'[^0-9]'), '');
    String formatted = '';
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