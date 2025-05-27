import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../SanXuat/baocao_sanxuat.dart';

class BarcodeHomePage extends StatefulWidget {
  const BarcodeHomePage({super.key});

  @override
  State<BarcodeHomePage> createState() => _BarcodeHomePageState();
}

class _BarcodeHomePageState extends State<BarcodeHomePage> {
  String barcode = 'Nhấn để quét';

  @override
  void initState() {
    super.initState();
    // Tự động mở trình quét khi trang được tải
    _openScanner();
  }

  // Hàm mở trình quét mã vạch
  void _openScanner() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      while (mounted) {
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AiBarcodeScanner(
              onDispose: () {
                debugPrint("Trình quét mã vạch đã bị hủy!");
              },
              hideGalleryButton: false,
              controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.noDuplicates,
              ),
              onDetect: (BarcodeCapture capture) {
                final String? scannedValue = capture.barcodes.first.rawValue;
                debugPrint("Mã vạch được quét: $scannedValue");

                final Uint8List? image = capture.image;
                debugPrint("Hình ảnh mã vạch: $image");

                final Object? raw = capture.raw;
                debugPrint("Dữ liệu thô mã vạch: $raw");

                final List<Barcode> barcodes = capture.barcodes;
                debugPrint("Danh sách mã vạch: $barcodes");
              },
              validator: (value) {
                if (value.barcodes.isEmpty) {
                  return false;
                }
                if (value.barcodes.first.rawValue != null && value.barcodes.first.rawValue!.length == 15) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => frmBaoCaoSanXuat(SCD: value.barcodes.first.rawValue),
                    ),
                  );
                }
                return true;
              },
            ),
          ),
        );
        // Nếu người dùng quay lại từ frmBaoCaoSanXuat, tiếp tục mở lại trình quét
        // if (result == null && mounted) {
        //   continue;
        // }
        break; // Thoát vòng lặp nếu không cần tiếp tục quét
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trình quét'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: _openScanner,
              child: const Text('Scan Barcode'),
            ),
            Text(barcode),
          ],
        ),
      ),
    );
  }
}