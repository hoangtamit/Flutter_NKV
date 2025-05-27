import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../main.dart';
import '../SanXuat/baocao_sanxuat.dart';
import '../home.dart';

const Color activeIconColor = Colors.orange;
class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});
  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  MobileScannerController controller = MobileScannerController();
  String? scannedCode = '';//'''LAN-250506-1157';
  @override
  void initState() {
    super.initState();
    scannedCode = '';
    controller.start();
  }
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final ModalRoute? modalRoute = ModalRoute.of(context);
  //   if (modalRoute != null) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       modalRoute.routeObserver.subscribe(this, modalRoute);
  //     });
  //   }
  // }

  // @override
  // void didPopNext() {
  //   // Khi quay lại từ trang khác (như frmBaoCaoSanXuat), khởi động lại camera
  //   controller.start().then((_) {
  //     print('Camera started on didPopNext');
  //   }).catchError((error) {
  //     print('Error starting camera on didPopNext: $error');
  //   });
  //   setState(() {
  //     scannedCode = ''; // Reset scannedCode để cho phép quét lại
  //   });
  // }
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
                // Tạm dừng camera sau khi quét thành công
                  controller.stop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => frmBaoCaoSanXuat(SCD: scannedCode,),),);
                }
              }
            },
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BarcodeScannerPage(),),);
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: activeIconColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Đóng'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}