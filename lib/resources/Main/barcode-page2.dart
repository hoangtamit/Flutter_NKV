import 'dart:async';

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
  final MobileScannerController controller = MobileScannerController(
  );
  StreamSubscription<Object?>? _subscription;
  @override
  void initState() {
    super.initState();

    // Start listening to lifecycle changes.
    //WidgetsBinding.instance.addObserver(this as WidgetsBindingObserver);

    // Start listening to the barcode events.
    //_subscription = controller.barcodes.listen(_handleBarcode);

    // Finally, start the scanner itself.
    //unawaited(controller.start());
    // Tự động mở trình quét khi trang được tải
    _openScanner();
  }

  // Hàm mở trình quét mã vạch
  void _openScanner() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      while (mounted) {
        // Khởi tạo mới MobileScannerController cho mỗi lần mở trình quét
        final controller = MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
        );

        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AiBarcodeScanner(
              onDispose: () {
                // Hủy controller khi trình quét bị đóng
                controller.dispose();
                debugPrint("Trình quét mã vạch đã bị hủy!");
              },
              hideGalleryButton: false,
              controller: controller,
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
                  // Đóng trình quét trước khi điều hướng
                  Navigator.pop(context);
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
  Future<void> dispose() async {
    super.dispose();
    // Stop listening to lifecycle changes.
    //WidgetsBinding.instance.removeObserver(this as WidgetsBindingObserver);
    // Stop listening to the barcode events.
    //unawaited(_subscription?.cancel());
    //_subscription = null;
    // Dispose the widget itself.
    //super.dispose();
    // Finally, dispose of the controller.
    //await controller.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If the controller is not ready, do not try to start or stop it.
    // Permission dialogs can trigger lifecycle changes before the controller is ready.
    if (!controller.value.isInitialized) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
      // Restart the scanner when the app is resumed.
      // Don't forget to resume listening to the barcode events.
        //_subscription = controller.barcodes.listen(_handleBarcode);

        unawaited(controller.start());
      case AppLifecycleState.inactive:
      // Stop the scanner when the app is paused.
      // Also stop the barcode events subscription.
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
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
