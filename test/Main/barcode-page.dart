import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Bỏ import mobile_scanner nếu bạn không dùng đến nó trong chế độ giả lập này
// import 'package:mobile_scanner/mobile_scanner.dart';
import '../SanXuat/baocao_sanxuat.dart'; // Đảm bảo đường dẫn này chính xác

const Color activeIconColor = Colors.orange;

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});
  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  // Tạm thời không cần controller nếu không có camera thật
  // MobileScannerController controller = MobileScannerController();
  String? scannedCode; // Sẽ gán giá trị giả lập
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    // ---- GIẢ LẬP MÃ SCANNED ----
    // Bạn có thể kích hoạt giả lập ở đây hoặc qua một nút bấm
    _simulateScanAndNavigate();
  }

  void _simulateScanAndNavigate() {
    // Gán mã giả lập
    const String simulatedCode = 'LAN-250506-1157';

    if (_isNavigating) return;

    if (simulatedCode.length == 15) {
      setState(() {
        scannedCode = simulatedCode;
        _isNavigating = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mã giả lập: $scannedCode'),
          duration: const Duration(seconds: 1),
        ),
      );

      Future.delayed(const Duration(milliseconds: 500), () {
        if (!mounted) return; // Kiểm tra widget còn trong cây không trước khi điều hướng
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => frmBaoCaoSanXuat(SCD: scannedCode!),
          ),
        ).then((_) {
          if (!mounted) return;
          setState(() {
            _isNavigating = false;
            // scannedCode = null; // Reset để có thể giả lập lại nếu cần
          });
          // Nếu bạn muốn quay lại và có thể giả lập lại, bạn có thể gọi lại _simulateScanAndNavigate()
          // Hoặc đơn giản là pop trang này nếu không cần quay lại trang barcode giả lập
          // Navigator.pop(context); // Tùy chọn: đóng trang barcode sau khi giả lập
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mã giả lập không hợp lệ: $simulatedCode'),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    // controller.dispose(); // Không cần nếu controller không được khởi tạo
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quét mã barcode (Giả lập)'),
        backgroundColor: activeIconColor,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (scannedCode != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Mã đang được xử lý: $scannedCode',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            Text(
              'Đang giả lập quá trình quét barcode...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Nếu bạn muốn có nút để kích hoạt lại giả lập
                if (!_isNavigating) {
                  _simulateScanAndNavigate();
                }
              },
              child: Text('Giả lập lại'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Đóng trang quét barcode
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: activeIconColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Đóng'),
            ),
          ],
        ),
      ),
      // Stack chứa MobileScanner được loại bỏ vì chúng ta đang giả lập
    );
  }
}