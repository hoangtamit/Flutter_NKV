import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:nkv/api/QuanLyDonHangApi/QuanLyDonHangApi.dart';
import '../../api/NghiepVu/donsanxuat_api.dart';
import '../../model/QuanLyDonHang/QuanLyDonHang_HoanThanhNull_Unpivoted.dart';
import '../../utilities/fDateTime.dart';
import '../../utilities/globals.dart';
import '../../utilities/values/colors.dart';
import '../../widgets/wAppBar.dart';
import '../KhoNVL/avery_giaohang.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

// Hằng số cho màu sắc, kích thước, và khoảng cách
//const Color primaryColor = Colors.blue;
const Color cardColor = Colors.white;
const double cardMargin = 8.0;
const double cardPadding = 0.0;
const double cardElevation = 4.0;
const double borderRadius = 12.0;
const double iconSize = 50.0;
const double labelFontSize = 16.0;
const double titleFontSize = 16.0;
const color = Colors.black87;
const double fontSize = 14;
List<QuanLyDonHang_HoanThanhNull_Unpivoted> dsDonHang = [];

class frmQuanLyDonHang extends StatefulWidget {
  const frmQuanLyDonHang({super.key});
  @override
  _frmQuanLyDonHangState createState() => _frmQuanLyDonHangState();
}
class _frmQuanLyDonHangState extends State<frmQuanLyDonHang> {
  bool _isLoading = false; // Biến trạng thái loading
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _getDonSanXuat();
    // searchController.addListener(() {
    //   filterData();
    // });
  }
  @override
  void dispose() {
    super.dispose();
  }
  Future<void> _getDonSanXuat() async {
    setState(() {
      _isLoading = true;
    });
    try {
      dsDonHang = [];
      final KhachHangData = await QuanLyDonHangApi.QuanLyDonHang_HoanThanhNull_Unpivoted_GetCongDoan();
      setState(() {
        dsDonHang = KhachHangData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      //_showErrorSnackBar(context, 'Lỗi khi tải danh sách đơn hàng: $e');
    }
  }
  // Hàm quét mã QR
  Future<void> _scanQRCode() async {
    try {
      if (kIsWeb) {
        //_showErrorSnackBar(context, 'Quét mã QR không được hỗ trợ trên web');
        return;
      }
      final result = await BarcodeScanner.scan();
      if (result.rawContent.isNotEmpty) {
        final scd = result.rawContent;
        developer.log('Scanned SCD: $scd', name: 'QRScan');
        _focusOnDonHang(scd);
      } else {
        //_showErrorSnackBar(context, 'Mã QR không hợp lệ');
      }
    } catch (e) {
      //_showErrorSnackBar(context, 'Lỗi khi quét mã QR: $e');
    }
  }
  // Hàm tìm và focus đơn hàng
  void _focusOnDonHang(String scd) {
    final index = dsDonHang.indexWhere((donHang) => donHang.SCD == scd);
    if (index != -1) {
      // Tìm thấy đơn hàng
      final itemHeight = 128.0; // Chiều cao mỗi mục (120 + padding 8)
      final offset = index * itemHeight;
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      //_showErrorSnackBar(context, 'Đã tìm thấy đơn hàng: $scd');
    } else {
      //_showErrorSnackBar(context, 'Không tìm thấy đơn hàng với SCD: $scd');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: wAppBar.buildAppBar('Danh Sách Đơn Hàng', onRefresh: () {_getDonSanXuat();},),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _scanQRCode(),
          tooltip: 'Take a Photo',
          child: const Icon(Icons.barcode_reader),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(16,8,16,0),
          child: Column(
            children: [
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else if (dsDonHang.isNotEmpty)
                Expanded(
                  child: SearchableList<QuanLyDonHang_HoanThanhNull_Unpivoted>(
                    itemBuilder: (item) => _SearchableList(actor: item,),
                    initialList: dsDonHang,
                    filter: (query) => dsDonHang.where((element) => element.SCD!.contains(query)).toList(),
                    emptyWidget: const EmptyView(),
                    inputDecoration: InputDecoration(
                      labelText: "Tìm kiếm SCD",
                      prefixIcon: const Icon(Icons.search, color: primaryColor),
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: primaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                  ),
                )
            ],
          ),
        )
    );
  }
// Hàm quét mã QR

  void _openScanner() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Khởi tạo mới MobileScannerController cho mỗi lần mở trình quét
      // final controller = MobileScannerController(
      //   detectionSpeed: DetectionSpeed.noDuplicates,
      // );
      final controller = MobileScannerController(
        detectionSpeed: DetectionSpeed.normal,
        detectionTimeoutMs: 100, // Giới hạn thời gian xử lý
        //facing: CameraFacing.back,
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
            validator: (value) {
              if (value.barcodes.isEmpty) {
                return false;
              }
              var barcode = value.barcodes.first.rawValue;
              if (barcode != null && barcode.length == 15) {
                for(var tb in dsDonHang){
                  if(tb.SCD == barcode){
                    tb.IDTo = Globals.NhanVien.IDTo;
                    QuanLyDonHangApi.QuanLyDonHang_XacNhan(tb).then((value) {
                      setState(() {
                        tb.Nhan = value[0].Nhan;
                        tb.HoanThanh = value[0].HoanThanh;
                        // if(tb.Nhan == false) {
                        //                          //   tb.Nhan = true;
                        //                          // } else {
                        //                          //   tb.HoanThanh = true;
                        //                          // }
                      });
                    });
                  }
                }
              }
              return true;
            },
          ),
        ),
      );
    });
  }
  void GetBarcode() {
    String value = "LAN-250614-0029";
    if (value.isEmpty) {

    }
    var barcode = value;
    if (barcode != null && barcode.length == 15) {
      for(var tb in dsDonHang){
        if(tb.SCD == barcode){
          tb.IDTo = Globals.NhanVien.IDTo;
          QuanLyDonHangApi.QuanLyDonHang_XacNhan(tb).then((value) {
            setState(() {
              tb.Nhan = value[0].Nhan;
              tb.HoanThanh = value[0].HoanThanh;
            });
          });
        }
      }
    }
  }
}

class _SearchableList extends StatelessWidget {
  final QuanLyDonHang_HoanThanhNull_Unpivoted actor;
  const _SearchableList({super.key, required this.actor});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black38,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Row(
              children: [
                SizedBox(width: 60, child: Image.asset('assets/images/checklist-64.png')),
                const SizedBox(width: 5),
                SizedBox(
                  //width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              '${dsDonHang.indexOf(actor) + 1}.SCD: ',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(actor.SCD.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              'Khách Hàng: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(actor.TenKhachHang.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              'Số Lượng: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(actor.SoLuong.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              'Ngày Giao: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(fDateTime.DD_MM_YYYY(actor.NgayGiaoHang.toString())),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              child: Column(
                children: [
                  Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      value: actor.Nhan,
                      onChanged: (bool) {},
                      activeColor: Colors.green,
                      tristate: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      value: actor.HoanThanh,
                      onChanged: (bool) {},
                      activeColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  Future<void> _openPdf(BuildContext context, QuanLyDonHang_HoanThanhNull_Unpivoted actor) async {
    // try {
    //   final result;
    //   if(Platform.isAndroid) {
    //     result = await DonSanXuatApi.DownloadPdf(actor.SCD.toString());
    //   }
    //   else{
    //     result = await DonSanXuatApi.OpenPdf(actor.SCD.toString());
    //   }
    //   if (result.isNotEmpty) {
    //     final String pathfile = result[0].url;
    //     print('Đường dẫn file PDF: $pathfile');
    //     if (await File (pathfile).exists()) {
    //       final openResult;
    //       openResult = await OpenFile.open(pathfile);
    //
    //       if (openResult.type != ResultType.done) {
    //         _showErrorSnackBar(context, 'Không thể mở file PDF: ${openResult.message}');
    //       }
    //     } else {
    //       _showErrorSnackBar(context, 'File PDF không tồn tại tại đường dẫn: $pathfile');
    //     }
    //   } else {
    //     _showErrorSnackBar(context, 'Không tìm thấy file PDF');
    //   }
    // } catch (e) {
    //   _showErrorSnackBar(context, 'Lỗi khi mở file PDF: $e');
    // }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}