import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../SanXuat/baocao_sanxuat.dart'; // Đảm bảo đường dẫn này chính xác

const Color activeIconColor = Colors.orange;

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});
  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  MobileScannerController controller = MobileScannerController();
  String? scannedCode ; // Khởi tạo là null, không cần giá trị mặc định ở đây nữa
  bool _isNavigating = true; // Thêm biến cờ để tránh điều hướng nhiều lần

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quét mã barcode'),
        backgroundColor: activeIconColor,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              //if (_isNavigating) return; // Nếu đang điều hướng thì không xử lý nữa
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final String? currentCode = barcodes.first.rawValue;
                if (currentCode != null && currentCode.length == 15) {
                  setState(() {
                    scannedCode = currentCode;
                    _isNavigating = true; // Đặt cờ là đang điều hướng
                  });
                  // Tạm dừng camera sau khi quét thành công
                  controller.stop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Mã barcode: $scannedCode'),
                      duration: const Duration(seconds: 2), // Giảm thời gian hiển thị snackbar
                    ),
                  );

                  // Đợi một chút để người dùng thấy SnackBar rồi mới chuyển trang
                  Future.delayed(const Duration(milliseconds: 500), () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BaoCaoSanXuat(SCD: scannedCode!),),).then((_) {
                      // Khi quay lại từ ReportScreen
                      setState(() {
                        _isNavigating = false; // Reset cờ
                        // scannedCode = null; // Tùy chọn: reset mã đã quét
                      });
                      // Khởi động lại camera nếu cần thiết và nếu người dùng chưa đóng trang quét
                      if (mounted) { // Kiểm tra widget còn trong cây widget không
                        controller.start();
                      }
                    });
                  });
                } else if (currentCode != null) {
                  // Hiển thị thông báo nếu mã không đúng định dạng mong muốn nhưng không null
                  ScaffoldMessenger.of(context).removeCurrentSnackBar(); // Xóa snackbar cũ nếu có
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Mã không hợp lệ: $currentCode. Cần mã có 15 ký tự.'),
                      duration: const Duration(seconds: 3),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Đóng trang quét barcode
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: activeIconColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Đóng'),
              ),
            ),
          ),
          // Bỏ phần hiển thị ReportScreen trực tiếp ở đây
          // if (scannedCode != null && scannedCode?.length == 15)
          //    ReportScreen(SCD: scannedCode,)

          // Phần hiển thị mã đã quét có thể giữ lại hoặc bỏ đi tùy ý
          if (scannedCode != null)
          //BaoCaoSanXuat(SCD: scannedCode!),
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.black54,
                  child:
                  Text('Mã đã quét: $scannedCode', style: const TextStyle(color: Colors.white, fontSize: 16),),
                ),
              ),
            ),
        ],
      ),
    );
  }
}