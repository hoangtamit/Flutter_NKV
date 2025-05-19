import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api/NghiepVu/donsanxuat_api.dart';
import '../../model/NghiepVu/tbdonsanxuat.dart';
import '../../pdf/openpdf.dart';
import '../../pdf/pinch.dart';
import '../../utilities/loading_dialog.dart';
import '../../utilities/values/format.dart';
import 'package:open_file/open_file.dart';


// Hằng số cho màu sắc, kích thước, và khoảng cách
const Color primaryColor = Colors.blue;
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
List<tbDonSanXuat> dsDonSanXuat = [];

class DonSanXuat_DanhSach extends StatefulWidget {
  const DonSanXuat_DanhSach({super.key});
  @override
  _DonSanXuat_DanhSachState createState() => _DonSanXuat_DanhSachState();
}
class _DonSanXuat_DanhSachState extends State<DonSanXuat_DanhSach> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách đơn sản xuất'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<tbDonSanXuat>>(
        future: DonSanXuatApi.LoadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Đã có lỗi xảy ra, vui lòng thử lại'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có dữ liệu đơn sản xuất'));
          }
          dsDonSanXuat = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(cardMargin),
            child: SearchableList<tbDonSanXuat>(
              itemBuilder: (item) => ActorItem(actor: item),
              //: () async => dsDonSanXuat,
              initialList: dsDonSanXuat,
              filter: (query) => dsDonSanXuat.where((element) => element.scd.contains(query)).toList(),
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
          );
        },
      ),
    );
  }
}

class ActorItem extends StatelessWidget {
  final tbDonSanXuat actor;
  const ActorItem({super.key, required this.actor});
  Future<void> _openPdf(BuildContext context) async {
    //LoadingDialog.showLoadingDialog(context, "");
    try {
      final result = await DonSanXuatApi.ExportPdf(actor.scd.toString());
      if (result.isNotEmpty && result[0].url != null) {
        final String pathfile = result[0].url; // Đường dẫn cục bộ
        Navigator.push(context, MaterialPageRoute(builder: (context) => PdfViewer(pathfile: pathfile, action: 'network',)));
        // final openResult = await OpenFile.open(pathfile);
        // if (openResult.type != ResultType.done) {
        //   _showErrorSnackBar(context, 'Không thể mở file PDF: ${openResult.message}');
        // }
      } else {
        _showErrorSnackBar(context, 'Không tìm thấy file PDF');
      }
    } catch (e) {
      _showErrorSnackBar(context, 'Lỗi khi mở file PDF: $e');
    }finally {
      //LoadingDialog.hideLoadingDialog(context);
    }
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
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: cardElevation,
      margin: const EdgeInsets.symmetric(vertical: cardMargin),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      color: cardColor,
      child: ListTile(
        contentPadding: const EdgeInsets.all(cardPadding),
        leading: Image.asset('assets/images/checklist-64.png', width: iconSize, height: iconSize,),
        title: Text(
          'SCD: ${actor.scd}',
          style: const TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(children: [
              const SizedBox(width: 100, child: Text('Khách Hàng:',style: TextStyle(fontWeight: FontWeight.bold, color: color,),),),
              Text(actor.tenKhachHang.toString(), style: const TextStyle(color: color, fontSize: fontSize,),),
            ],),
            Row(children: [
              const SizedBox(width: 100, child: Text('Bộ Phận:',style: TextStyle(fontWeight: FontWeight.bold, color: color,),),),
              Text(actor.boPhan.toString(), style: const TextStyle(color: color, fontSize: fontSize,),),
            ],),
            Row(children: [
              const SizedBox(width: 100, child: Text('Số Lượng:',style: TextStyle(fontWeight: FontWeight.bold, color: color,),),),
              Text(actor.soLuong.toString(), style: const TextStyle(color: color, fontSize: fontSize,),),
            ],),
            Row(children: [
              const SizedBox(width: 100, child: Text('Giao Hàng:',style: TextStyle(fontWeight: FontWeight.bold, color: color,),),),
              Text(fDateTime.DD_MM_YYYY(actor.ngayGiaoHang.toString()), style: const TextStyle(color: color, fontSize: fontSize,),),
            ],),
            // Text('Bộ Phận   : ${actor.boPhan}', style: const TextStyle(fontSize: labelFontSize)),
            // Text('Số Lượng  : ${actor.soLuong}', style: const TextStyle(fontSize: labelFontSize)),
            // Text('Giao Hàng : ${fDateTime.DD_MM_YYYY(actor.ngayGiaoHang.toString())}',style: const TextStyle(fontSize: labelFontSize),),
          ],
        ),
        onTap: () => _openPdf(context),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error, color: Colors.red, size: 48),
        SizedBox(height: 8),
        Text('Không tìm thấy đơn sản xuất nào'),
      ],
    );
  }
}