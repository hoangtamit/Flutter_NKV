import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../api/KhoNVL/KhoNVL_api.dart';
import '../../model/KhoNVL/KhoNVL_TonKho.dart';
import '../../model/drop_list_model.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
//import 'package:qrscan/qrscan.dart' as scanner;
//import 'package:qr_code_scanner/qr_code_scanner.dart' as scanner;
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../services/show_Dialog.dart';

final TextEditingController _khoController = TextEditingController();
final TextEditingController _mavatlieuController = TextEditingController();
final TextEditingController _mavatlieu2Controller = TextEditingController();
final TextEditingController _tenhanghoaController = TextEditingController();
final TextEditingController _donvitinhController = TextEditingController();
final TextEditingController _quycachController = TextEditingController();
final TextEditingController _tondaukyController = TextEditingController();
final TextEditingController _tongnhapController = TextEditingController();
final TextEditingController _tongxuatController = TextEditingController();
final TextEditingController _toncuoikyController = TextEditingController();
final TextEditingController _vitriController = TextEditingController();
final TextEditingController _vitri2Controller = TextEditingController();
final TextEditingController _soluongthucteController = TextEditingController();
final TextEditingController _makiemkeController = TextEditingController();
final TextEditingController _isKiemKeController = TextEditingController();
DropListModel dropListModel = DropListModel([OptionItem(id: "1", title: "Option 1"), OptionItem(id: "2", title: "Option 2")]);
OptionItem optionItemSelected = OptionItem(id: '', title: "Chọn quyền truy cập");
const List<String> list = <String>['Long An', 'Bắc Ninh', 'Triết Giang'];
String dropdownValue = list.first;
bool Remember = true;
bool _showPass = true;
const barcode = '';
KhoNVL_TonKho? tonkho;
class KiemKeTonKho extends StatefulWidget {
  final MaVatLieu;
  final ViTri;
  final Kho;
  const KiemKeTonKho({Key? key,required this.MaVatLieu,required this.ViTri,required this.Kho}) : super(key: key);
  @override
  State<KiemKeTonKho> createState() => _KiemKeTonKhoState();
}
class _KiemKeTonKhoState extends State<KiemKeTonKho> {
  bool isChecked = false;
  @override
  void initState() {
    Clear();
    _mavatlieuController.text = widget.MaVatLieu;
    _vitriController.text = widget.ViTri;
    _khoController.text = widget.Kho;
    KiemTraTonKho(widget.MaVatLieu,widget.ViTri,widget.Kho);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        //constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/nkv.png'),
              //const Text("Welcome Back!", style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text("Thống Kê Tồn Kho",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextField(
                  //maxLength: 12,
                  readOnly: true,
                  controller: _khoController,
                  // onChanged: (text) async {
                  //   KiemTraTonKho(text,null);
                  // },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: 'Kho',
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: SizedBox(
                        width: (MediaQuery
                            .sizeOf(context)
                            .width - 30) * 0.4, height: 52,
                        child: TextField(
                          readOnly: true,
                          controller: _mavatlieuController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: 'Mã Vật Liệu',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: SizedBox(
                        width: (MediaQuery
                            .sizeOf(context)
                            .width - 30) * 0.4, height: 52,
                        child: TextField(
                          controller: _mavatlieu2Controller,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: 'Mã Vật Liệu Mới',

                          ),
                          //keyboardType: TextInputType.numberWithOptions(decimal: true),
                          //inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'\w{10}')),],
                          onChanged: (String value){
                            setState(() {
                              _mavatlieu2Controller.text = value.toUpperCase();
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: SizedBox(
                        width: (MediaQuery
                            .sizeOf(context)
                            .width - 30) * 0.2, height: 52,
                        child: InkWell(
                          splashColor: Colors.black26,
                          onTap: KiemKe_ChuyenDoiMaVatLieu,
                          child: Image.asset('assets/images/convert-32.png',
                              width: 50.0, height: 50.0),
                        ),
                      ),
                    ),
                  ]
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextField(
                  readOnly: true,
                  maxLines: 2,
                  controller: _tenhanghoaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: 'Tên Hàng Hoá',
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: SizedBox(
                        width: (MediaQuery
                            .sizeOf(context)
                            .width - 30) * 0.4, height: 52,
                        child: TextField(
                          readOnly: true,
                          controller: _vitriController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: 'Vị Trí',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: SizedBox(
                        width: (MediaQuery
                            .sizeOf(context)
                            .width - 30) * 0.4, height: 52,
                        child: TextField(
                          controller: _vitri2Controller,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: 'Vị Trí Mới',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: SizedBox(
                        width: (MediaQuery
                            .sizeOf(context)
                            .width - 30) * 0.2, height: 52,
                        child: InkWell(
                          splashColor: Colors.black26,
                          onTap: KiemKe_ChuyenDoiViTri,
                          child: Image.asset('assets/images/convert-32.png',
                              width: 50.0, height: 50.0),
                        ),
                      ),
                    ),
                  ]
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: SizedBox(
                  // width: (MediaQuery
                  //     .sizeOf(context)
                  //     .width - 30) * 0.8, height: 52,
                  child: TextField(
                    readOnly: true,
                    controller: _toncuoikyController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Tồn Cuối Kỳ',
                    ),
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: SizedBox(
                        width: (MediaQuery
                            .sizeOf(context)
                            .width - 30) * 0.8, height: 52,
                        child: TextField(
                          controller: _soluongthucteController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: 'Số Lượng Thực Tế',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: SizedBox(
                        width: (MediaQuery
                            .sizeOf(context)
                            .width - 30) * 0.2, height: 52,
                        child: InkWell(
                          splashColor: Colors.black26,
                          onTap: KiemKe_ChuyenDoiSoLuong,
                          child: Image.asset('assets/images/convert-32.png',
                              width: 50.0, height: 50.0),
                        ),
                      ),
                    ),
                  ]
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: SizedBox(
                  width: (MediaQuery
                      .sizeOf(context)
                      .width - 70) / 2, height: 52,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),),
                        backgroundColor: Colors.blue
                    ),
                    onPressed: _scanbarcode,
                    child: const Text('Quét Barcode',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _scanbarcode() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Quyền camera bị từ chối')),
        );
        return;
      }
    }
    try {
      // Mở màn hình quét và chờ kết quả
      final String? barcode = await Navigator.push(context, MaterialPageRoute(builder: (_) => QRScannerPage()),);
      //String? barcode = '';//await scanner.scan();
      Clear();
      if (barcode != null && barcode != '') {
        if (barcode.contains('/')) {
          var mavatlieu = barcode.split('/')[0];
          var vitri = barcode.split('/')[1];
          var kho = null;
          if (barcode
              .split('/')
              .length == 3)
            kho = barcode.split('/')[2];
          KiemTraTonKho(mavatlieu, vitri, kho);
        }
        else {
          KiemTraTonKho(barcode, null, null);
        }
      }
      else {
        print('nothing return.');
      }
    }
    catch (e) {
      print('Error scanning barcode: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi quét mã: $e')),
      );
    }
  }

  Future KiemKe_ChuyenDoiSoLuong() async {
    if(isChecked){
      ShowDialog.showAlertDialog(context, 'Mã Vật Liệu đã kiểm kê rồi !!!');return;
    }
    tonkho?.soLuongKiemKe = double.parse(_soluongthucteController.text);
    tonkho?.idKhuVuc = 'LAN';
    await KhoNVLApi.KhoNVL_DieuChinhKho(tonkho!).then((value) async {
      if (value.isNotEmpty && value[0].isKiemKe) {
        ShowDialog.showAlertDialog(context, 'Điều Chỉnh Kho Thành Công');
        isChecked = value[0].isKiemKe;
      }
      else {
        ShowDialog.showAlertDialog(context, 'Điều Chỉnh Kho Thất Bại');
      }
    });
  }
  Future KiemKe_ChuyenDoiMaVatLieu() async {
    if(isChecked){
      ShowDialog.showAlertDialog(context, 'Mã Vật Liệu đã kiểm kê rồi !!!');return;
    }
    if(_mavatlieu2Controller.text.length != 10){
      ShowDialog.showAlertDialog(context, 'Mã Vật liệu không đúng , vui lòng xem lại');return;
    }
    tonkho?.maVatLieuChuyenDoi =  _mavatlieu2Controller.text.toUpperCase();
    tonkho?.soLuongKiemKe = double.parse(_soluongthucteController.text);
    tonkho?.idKhuVuc = 'LAN';
    await KhoNVLApi.KhoNVL_ChuyenDoiMaVatLieu(tonkho!).then((value) async {
      if (value.isNotEmpty) {
        ShowDialog.showAlertDialog(context, 'Điều Chỉnh Kho Thành Công');
      }
      else {
        ShowDialog.showAlertDialog(context, 'Điều Chỉnh Kho Thất Bại');
      }
    });
  }
  Future KiemKe_ChuyenDoiViTri() async {
    if(_vitri2Controller.text.isEmpty){
      ShowDialog.showAlertDialog(context, 'Vui lòng nhập Vị Trí mới');return;
    }
    if(_vitri2Controller.text.length != 7){
      ShowDialog.showAlertDialog(context, 'Vị Trí không đúng , vui lòng xem lại');return;
    }
    // tonkho?.soLuongKiemKe = double.parse(_soluongthucteController.text);
    // tonkho?.idKhuVuc = 'LAN';
    // await KhoNVLApi.KhoNVL_DieuChinhKho(tonkho!).then((value) async {
    //   if (value.isNotEmpty) {
    //     ShowDialog.showAlertDialog(context, 'Điều Chỉnh Kho Thành Công');
    //   }
    //   else {
    //     ShowDialog.showAlertDialog(context, 'Điều Chỉnh Kho Thất Bại');
    //   }
    // });
  }
  void KiemTraTonKho(final barcode,final ViTri,final Kho) {
    if (barcode.toString().length != 10) return;
    if (barcode != ''  && ViTri != '' && ViTri != null  && Kho != '' && Kho != null ) {
      KhoNVLApi.TonKhoNVL_ViTri_GetMaVatLieu_GetViTri_GetKho(barcode,ViTri,Kho).then((value) async {
        if (value.isNotEmpty ) {
          tonkho = value[0];
          _khoController.text = value[0].kho;
          _mavatlieuController.text = value[0].maVatLieu;
          _tenhanghoaController.text = value[0].tenHangHoa;
          _donvitinhController.text = value[0].donViTinh;
          _quycachController.text = value[0].quyCach;
          _toncuoikyController.text =
              tonkho!.toncuoiky.toString() + ' ' + value[0].donViTinh + ' ( ' + value[0].quyCach + ' )';
          _vitriController.text = value[0].viTri;
          isChecked = value[0].isKiemKe;
          _soluongthucteController.text = value[0].soLuongKiemKe.toString();
        }
        else {
          ShowDialog.showAlertDialog(context, 'Không tìm thấy mã vật liệu');
        }
      });
    }
    else if (barcode != '' && ViTri != '' && ViTri != null ) {
      KhoNVLApi.TonKhoNVL_ViTri_GetMaVatLieu_GetViTri(barcode,ViTri).then((value) async {
        if (value.isNotEmpty) {
          if(value.length > 1)
          {
            ShowDialog.showAlertDialog(context, 'Có ' + value.length.toString() + ' Mã vật liệu !!!'); return;
          }
          Clear();
          tonkho = value[0];
          _khoController.text = value[0].kho;
          _mavatlieuController.text = value[0].maVatLieu;
          _tenhanghoaController.text = value[0].tenHangHoa;
          _donvitinhController.text = value[0].donViTinh;
          _quycachController.text = value[0].quyCach;
          _toncuoikyController.text =
              tonkho!.toncuoiky.toString() + ' ' + value[0].donViTinh + ' ( ' +
                  value[0].quyCach + ' )';
          _vitriController.text = value[0].viTri;
          isChecked = value[0].isKiemKe;
          _soluongthucteController.text = value[0].soLuongKiemKe.toString();
        }
        else {
          ShowDialog.showAlertDialog(context, 'Không tìm thấy mã vật liệu');
        }
      });
    }
    else if (barcode != '' && ViTri == '') {
      KhoNVLApi.TonKho_GetMaVatLieu(barcode).then((value) async {
        if (value.isNotEmpty) {
          Clear();
          tonkho = value[0];
          _khoController.text = value[0].kho;
          _mavatlieuController.text = value[0].maVatLieu;
          _tenhanghoaController.text = value[0].tenHangHoa;
          _donvitinhController.text = value[0].donViTinh;
          _quycachController.text = value[0].quyCach;
          _toncuoikyController.text =
              tonkho!.toncuoiky.toString() + ' ' + value[0].donViTinh + ' ( ' +
                  value[0].quyCach + ' )';
          _vitriController.text = value[0].viTri;
        }
        else {
          ShowDialog.showAlertDialog(context, 'Không tìm dc dữ liệu');
        }
      });
    }
  }
  void Clear() {
    _khoController.text = '';
    _mavatlieuController.text = '';
    _mavatlieu2Controller.text = '';
    _tenhanghoaController.text = '';
    _donvitinhController.text = '';
    _quycachController.text = '';
    _tondaukyController.text = '';
    _tongnhapController.text = '';
    _tongxuatController.text = '';
    _toncuoikyController.text = '';
    _vitriController.text = '';
    _vitri2Controller.text = '';
    _soluongthucteController.text = '0';
    isChecked = false;
  }
}
class QRScannerPage extends StatefulWidget {
  const QRScannerPage({Key? key}) : super(key: key);
  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}
class _QRScannerPageState extends State<QRScannerPage> {
  bool _isScanned = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileScanner(
        onDetect: (BarcodeCapture capture) async {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            final String? code = barcode.rawValue;
            // Tránh quét nhiều lần liên tục
            if (_isScanned) return;
            _isScanned = true;
            // Delay nhẹ nếu cần (để camera release trước khi pop)
            await Future.delayed(const Duration(milliseconds: 300));
            if (code != null && mounted) {
              Navigator.pop(context, code); // Trả mã về
              //break; // chỉ lấy 1 lần rồi thoát luôn
            }
          }
        },
      ),
    );
  }
}