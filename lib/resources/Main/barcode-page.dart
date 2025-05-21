import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../SanXuat/baocao_sanxuat.dart';

const Color activeIconColor = Colors.orange;

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});
  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  MobileScannerController controller = MobileScannerController();
  String? scannedCode;
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
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                setState(() {
                  scannedCode = barcodes.first.rawValue;
                });
                if (scannedCode != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Mã barcode: $scannedCode'),
                      duration: const Duration(seconds: 3),
                    ),
                  );
// Tạm dừng camera sau khi quét thành công
                  controller.stop();
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
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: activeIconColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Đóng'),
              ),
            ),
          ),
          if (scannedCode != null && scannedCode?.length == 15)
             ReportScreen(SCD: scannedCode,)

            // Positioned(
            //   top: 20,
            //   left: 0,
            //   right: 0,
            //   child: Center(
            //     child: Container(
            //       padding: const EdgeInsets.all(16),
            //       color: Colors.black54,
            //       child: Text(
            //         'Mã đã quét: $scannedCode',
            //         style: const TextStyle(color: Colors.white, fontSize: 16),
            //       ),
            //     ),
            //   ),
            // ),
        ],
      ),
    );
  }
}