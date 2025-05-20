import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:printing/printing.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

String pdfUrl = '';
class PdfViewer extends StatefulWidget {
  final pathfile;
  final action ;
  const PdfViewer({super.key, required this.pathfile, this.action = 'network'});
  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewer> {
  bool isLoading = false;
  bool isNetworkSource = true; // Mặc định là network
// Hàm kiểm tra và yêu cầu quyền lưu trữ
  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      // Chỉ cần quyền cho Android 9 trở xuống
      if (await Permission.storage.isGranted) {
        var status = await Permission.storage.request();
        return status.isGranted;
      }
    }
    return true; // iOS hoặc Android 10+ không cần quyền
  }
// Hàm tải file PDF và lưu vào thư mục Downloads
  Future<File> _downloadFile(String url, String filename) async {
    setState(() {
      isLoading = true;
    });
    try {
      // Kiểm tra quyền
      if (!await _requestStoragePermission()) {
        throw Exception('Storage permission denied');
      }
      final response = await http.get(Uri.parse(url));
      // Lấy thư mục Downloads
      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory(); // iOS không có thư mục Downloads công khai, dùng sandbox
      }
      // Đảm bảo thư mục tồn tại
      if (!await directory!.exists()) {
        await directory.create(recursive: true);
      }
      final file = File('${directory.path}/$filename');
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading file: $e')),
      );
      rethrow;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  // Hàm lưu file vào thư mục Downloads
  Future<void> _saveToDownloads() async {
    String fileName = path.basename(pdfUrl);
    final file = await _downloadFile(pdfUrl, fileName);
    if(Platform.isAndroid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File saved to ${file.path}')),
      );
    }
    else if(Platform.isIOS){
      await Share.shareXFiles([XFile(file.path)], text: 'Save to Files');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File saved and shared to Files')),
      );
    }
  }
  // Hàm chia sẻ file
  Future<void> _shareFile() async {
    final file = await _downloadFile(pdfUrl, 'shared_pdf.pdf');
    await Share.shareXFiles([XFile(file.path)], text: 'Check out this PDF!');
  }
  // Hàm in file
  Future<void> _printFile() async {
    final file = await _downloadFile(pdfUrl, 'print_pdf.pdf');
    await Printing.layoutPdf(
      onLayout: (format) async => file.readAsBytes(),
    );
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      isLoading = true;
      pdfUrl = widget.pathfile;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(path.basename(pdfUrl)),
        actions: [
          // ComboBox (PopupMenuButton) cho Download, Share, Print
          PopupMenuButton<String>(
            enabled: true, // Vô hiệu hóa khi đang tải
            onSelected: (value) {
              if (value == 'download') _saveToDownloads();
              if (value == 'share') _shareFile();
              if (value == 'print') _printFile();
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'download',
                child: Row(
                  children: [
                    Icon(Icons.download, color: Colors.black54),
                    SizedBox(width: 8),
                    Text('Download PDF'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'share',
                child: Row(
                  children: [
                    Icon(Icons.share, color: Colors.black54),
                    SizedBox(width: 8),
                    Text('Share PDF'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'print',
                child: Row(
                  children: [
                    Icon(Icons.print, color: Colors.black54),
                    SizedBox(width: 8),
                    Text('Print PDF'),
                  ],
                ),
              ),
            ],
            tooltip: 'More options',
          ),
          // // Nút Download
          // IconButton(
          //   icon: Icon(Icons.download),
          //   onPressed: _saveToDownloads,
          //   tooltip: 'Download PDF',
          // ),
          // // Nút Share
          // IconButton(
          //   icon: Icon(Icons.share),
          //   onPressed: _shareFile,
          //   tooltip: 'Share PDF',
          // ),
          // // Nút Print
          // IconButton(
          //   icon: Icon(Icons.print),
          //   onPressed: _printFile,
          //   tooltip: 'Print PDF',
          // ),
        ],
      ),
      body: Stack(
        children: [
          if(widget.action == 'network') SfPdfViewer.network(pdfUrl,)
          else if(widget.action == 'asset') SfPdfViewer.asset(pdfUrl,)
          else if(widget.action == 'file') SfPdfViewer.file(File(pdfUrl),)
          //else if(widget.action == 'memory') SfPdfViewer.memory(pdfUrl,)
          // if (isLoading)
          //   Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}