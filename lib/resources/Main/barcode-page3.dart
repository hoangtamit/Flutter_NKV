// import 'dart:html' as html;
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:js/js.dart';
//
// // Định nghĩa hàm JavaScript để gọi jsQR
// @JS('jsQR')
// external dynamic jsQR(dynamic data, int width, int height, [dynamic options]);
//
// class CameraScreen extends StatefulWidget {
//   const CameraScreen({Key? key}) : super(key: key);
//
//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }
//
// class _CameraScreenState extends State<CameraScreen> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   String _barcodeResult = 'Chưa quét được barcode'; // Lưu kết quả barcode
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }
//
//   Future<void> _initializeCamera() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     final cameras = await availableCameras();
//     final rearCamera = cameras.firstWhere(
//           (camera) => camera.lensDirection == CameraLensDirection.back,
//       orElse: () => cameras.first,
//     );
//
//     _controller = CameraController(
//       rearCamera,
//       ResolutionPreset.medium,
//     );
//     _initializeControllerFuture = _controller.initialize().then((_) {
//       // Bắt đầu quét barcode liên tục
//       _startBarcodeScanning();
//     });
//   }
//
//   void _startBarcodeScanning() {
//     // Quét barcode từ luồng camera
//     Future.doWhile(() async {
//       if (!mounted || !_controller.value.isInitialized) return false;
//
//       try {
//         // Chụp ảnh từ camera
//         final image = await _controller.takePicture();
//         final img = html.ImageElement()
//           ..src = image.path; // Đường dẫn ảnh từ camera
//
//         // Chờ ảnh tải xong
//         await img.onLoad.first;
//
//         // Tạo canvas để xử lý ảnh
//         final canvas = html.CanvasElement()
//           ..width = img.width
//           ..height = img.height;
//         final ctx = canvas.getContext('2d') as html.CanvasRenderingContext2D;
//         ctx.drawImage(img, 0, 0);
//
//         // Lấy dữ liệu ảnh
//         final imageData = ctx.getImageData(0, 0, img.width!, img.height!);
//         final code = jsQR(imageData.data, img.width!, img.height!);
//
//         if (code != null && code.data != null) {
//           setState(() {
//             _barcodeResult = code.data; // Cập nhật chuỗi barcode
//           });
//         }
//       } catch (e) {
//         print('Lỗi quét barcode: $e');
//       }
//
//       // Tiếp tục quét sau 1 giây
//       await Future.delayed(Duration(seconds: 1));
//       return mounted;
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Quét Barcode')),
//       body: Column(
//         children: [
//           Expanded(
//             child: FutureBuilder<void>(
//               future: _initializeControllerFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   return CameraPreview(_controller);
//                 } else {
//                   return Center(child: CircularProgressIndicator());
//                 }
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'Kết quả: $_barcodeResult',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }