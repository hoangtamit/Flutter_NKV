import 'dart:async';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qlsx/utilities/values/screen.dart';
import 'package:qlsx/widgets/wAppBar.dart';
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
    _openScanner();
  }
  // Hàm mở trình quét mã vạch
  void _openScanner() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
        // Khởi tạo mới MobileScannerController cho mỗi lần mở trình quét
        // final controller = MobileScannerController(
        //   detectionSpeed: DetectionSpeed.noDuplicates,
        // );
        final controller = MobileScannerController(
          detectionSpeed: DetectionSpeed.normal,
          detectionTimeoutMs: 100, // Giới hạn thời gian xử lý
          facing: CameraFacing.back,
        );
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AiBarcodeScanner(
              onDispose: () {
                // Hủy controller khi trình quét bị đóng
                controller.dispose();
                debugPrint("Trình quét mã vạch đã bị hủy!");
              },
              hideGalleryButton: true,
              hideSheetTitle: true,
              hideSheetDragHandler: true,
              //hideGalleryIcon: true  ,
              controller: controller,
              onDetect: (BarcodeCapture capture) {
                // final String? scannedValue = capture.barcodes.first.rawValue;
                // debugPrint("Mã vạch được quét: $scannedValue");
                //
                // final Uint8List? image = capture.image;
                // debugPrint("Hình ảnh mã vạch: $image");
                //
                // final Object? raw = capture.raw;
                // debugPrint("Dữ liệu thô mã vạch: $raw");
                //
                // final List<Barcode> barcodes = capture.barcodes;
                // debugPrint("Danh sách mã vạch: $barcodes");
              },

              validator: (value) {
                if (value.barcodes.isEmpty) {
                  return false;
                }
                if (value.barcodes.first.rawValue != null && value.barcodes.first.rawValue!.length == 15) {
                  // Đóng trình quét trước khi điều hướng
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BaoCaoSanXuat(SCD: value.barcodes.first.rawValue),
                    ),
                  );
                }
                return true;
              },
            ),
          ),
        );
    });
  }

  @override
  Future<void> dispose() async {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar.buildAppBar('Quét Barcode', onRefresh: () {setState(() {});}),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ElevatedButton(
                //   onPressed: _openScanner,
                //   child: const Text('Scan Barcode'),
                // ),
                Text(barcode),
              ],
            ),
          ),
          Positioned(
            right: 16.0, // Cách lề phải 16 pixels
            bottom: 100.0, // Cách đáy 100 pixels để kéo lên trên
            child: FloatingActionButton(
              //backgroundColor: Colors.blue,
              onPressed: _openScanner,
              child: const Icon(Icons.barcode_reader),
            ),
          ),
        ],
      ),
    );
  }
}
