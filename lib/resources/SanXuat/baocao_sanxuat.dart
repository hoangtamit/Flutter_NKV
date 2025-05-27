import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:qlsx/api/SanXuat/sanxuat_api.dart';
import 'package:qlsx/model/SanXuat/tbl_BaoCaoSanXuat_V2.dart';
import 'package:qlsx/resources/SanXuat/baocao_sanxuat_chitiet.dart';
import 'package:qlsx/utilities/PrintRibbon.dart';
import 'package:qlsx/utilities/globals.dart';
import 'package:qlsx/widgets/wDateTime.dart';
import 'package:qlsx/widgets/wDropdownField.dart';
import 'package:qlsx/widgets/wTextField.dart';
import 'package:uuid/uuid.dart';
import '../../utilities/fDateTime.dart';
import '../../utilities/message.dart';
import '../../utilities/values/screen.dart';
import '../../widgets/wAppBar.dart';

double spacingHeight = 16;
String  soluongdat_text       = 'Số Lượng Đạt';
String  soluongloi_text       = 'Số Lượng Lỗi';
String  soluongdonhang_text   = 'Đơn Hàng';
String  soluonglanhlieu_text  = 'Lãnh Liệu';
String  soluongconlai_text  = 'Số Lượng Còn Lại:';
String  donvitinh  = '';

class frmBaoCaoSanXuat extends StatelessWidget {
  final SCD;
  frmBaoCaoSanXuat({super.key, required this.SCD});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SanXuatApi.BaoCaoSanXuat_V2_GetSCD_GetCongDoan_GroupBy(SCD, 'In'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Lỗi: ${snapshot.error}'));
        } else {
          return BaoCaoSanXuat(BaoCao: snapshot.data?[0]);
        }
      },
    );
  }
}

class BaoCaoSanXuat extends StatefulWidget {
  final BaoCao;
  const BaoCaoSanXuat({super.key, required this.BaoCao});
  @override
  _BaoCaoSanXuatState createState() => _BaoCaoSanXuatState();
}

class _BaoCaoSanXuatState extends State<BaoCaoSanXuat>  {
  TextEditingController msnvController = TextEditingController();
  TextEditingController tenNhanVienController = TextEditingController();
  TextEditingController scdController = TextEditingController();
  TextEditingController bophanController = TextEditingController();
  TextEditingController khachangController = TextEditingController();
  TextEditingController tensanphamController = TextEditingController();
  TextEditingController soluongController = TextEditingController();
  TextEditingController lanhlieuController = TextEditingController();
  TextEditingController soluongconlaiController = TextEditingController();
  TextEditingController thoigianbatdauController = TextEditingController();
  TextEditingController thoigianketthucController = TextEditingController();
  TextEditingController thoigianchaymayController = TextEditingController();
  TextEditingController soluongdatController = TextEditingController();
  TextEditingController soluongloiController = TextEditingController();
  TextEditingController ghichuController = TextEditingController();
  String? selectedCongDoan; String? selectedThaoTac;
  List<String> dsCongDoan = [];
  List<String> dsThaoTac = ['Chạy Máy','Canh Chỉnh','Phụ Trợ','Vệ Sinh Máy','Máy Hư','Họp'];
  @override
  void initState() {
    super.initState();
    var tb = widget.BaoCao;
    msnvController.text = Globals.NhanVien.maNhanVien;
    tenNhanVienController.text = Globals.NhanVien.tenNhanVien;
    bophanController.text = tb.BoPhan;
    scdController.text = tb.SCD;
    selectedThaoTac   = dsThaoTac.isNotEmpty ? dsThaoTac.first : null;
    getCongDoan(tb);
  }
  @override
  void dispose() {
    msnvController.dispose();
    tenNhanVienController.dispose();
    scdController.dispose();
    bophanController.dispose();
    khachangController.dispose();
    tensanphamController.dispose();
    soluongController.dispose();
    lanhlieuController.dispose();
    thoigianbatdauController.dispose();
    thoigianketthucController.dispose();
    thoigianchaymayController.dispose();
    soluongdatController.dispose();
    soluongdat_text       = 'Số Lượng Đạt';
    soluongloi_text       = 'Số Lượng Lỗi';
    soluongdonhang_text   = 'Đơn Hàng';
    soluonglanhlieu_text  = 'Lãnh Liệu';
    soluongconlai_text  = 'Số Lượng Còn Lại:';
    super.dispose();
  }
  Future<void> getCongDoan(tbl_BaoCaoSanXuat_V2 tb) async {
    try {
      if (tb != null && tb.CongDoanSanXuat != "" ) {
        //CTP => OFFSET => Vecni => Bế => Kiểm Phẩm
        var CongDoanSanXuat = tb.CongDoanSanXuat.toString().replaceAll('CTP => ', '').replaceAll('CTF => ', '').trim().split(' => ');
        setState(() {
          dsCongDoan = CongDoanSanXuat;
          // Gán mặc định công đoạn đầu tiên nếu danh sách không rỗng
          selectedCongDoan = CongDoanSanXuat.isNotEmpty ? CongDoanSanXuat.first : null;
        });
        print('dsCongDoan: $dsCongDoan'); // Debug danh sách công đoạn
        print('selectedCongDoan (initial): $selectedCongDoan'); // Debug giá trị ban đầu
        for (var item in CongDoanSanXuat) {
          var GetisHoanThanh = await SanXuatApi.BaoCaoSanXuat_V2_GetSCD_GetCongDoan_GroupBy(scdController.text, item);
          if (GetisHoanThanh.isNotEmpty && GetisHoanThanh[0].isHoanThanh == 'false') {
            setState(() {
              selectedCongDoan = item;
              print('selectedCongDoan view: $selectedCongDoan');
            });
            print('selectedCongDoan updated: $selectedCongDoan');
            break;

          }
        }
        if(selectedCongDoan != null) {
          getData(selectedCongDoan!);
        }
      }
    } catch (e) {
      // Xử lý lỗi khi gọi API
      showMessage.TopSnackBar(context,'Lỗi khi lấy dữ liệu: $e',Colors.red);
    }
  }
  Future<void> getData(String value) async {
    try {
      // Gọi API để lấy danh sách báo cáo
      var response = await SanXuatApi.BaoCaoSanXuat_V2_GetSCD_GetCongDoan_GroupBy(scdController.text, value);

      if (response != null && response.isNotEmpty) {
        var tb = response[0]; // Giả sử API trả về danh sách và lấy phần tử đầu tiên
        setState(() {
          //tensanphamController.text = tb.TenSanPham ?? '';
          //khachangController.text = tb.TenKhachHang ?? '';
          tb.SoLuongDat ??= 0;
          tb.SoLuongLoi ??= 0;
          soluongController.text = "${tb.SoLuong ?? 0}";
          lanhlieuController.text = "${tb.LanhLieu ?? 0}";
          var format = DateFormat('dd/MM/yyyy HH:mm');
          thoigianbatdauController.text = tb.ThoiGian_KetThuc != null ? format.format(DateTime.parse(tb.ThoiGian_KetThuc.toString())): format.format(DateTime.now());
          thoigianketthucController.text = format.format(DateTime.now());
          if(tb.ThoiGian_KetThuc != null){
            try{
            DateTime start = format.parse(thoigianbatdauController.text);
            DateTime end = format.parse(thoigianketthucController.text);
            Duration diff = end.difference(start);
            int minutes = diff.inMinutes;
            thoigianchaymayController.text = minutes.toString();
            } catch (e) {
              print("Lỗi parse thời gian: $e");
            }
          }
          if (selectedCongDoan == printRibbon.XaGiay || selectedCongDoan == printRibbon.OFFSET || selectedCongDoan == printRibbon.Vecni
              || selectedCongDoan == printRibbon.UV  || selectedCongDoan == printRibbon.CanMang
              || selectedCongDoan == printRibbon.BoiGiay || selectedCongDoan == printRibbon.Be
               ) {
            donvitinh = tb.DonViTinh;
            soluonglanhlieu_text = "Lãnh Liệu ( ${donvitinh ?? ''} )";
          }
          else if(tb.BoPhan  == printRibbon.TEMVAI) {
            donvitinh = printRibbon.PCS;
            soluonglanhlieu_text = "Lãnh Liệu ( ${tb.DonViTinh ?? ''} )";
          }
          else {
            donvitinh = printRibbon.PCS;
            soluonglanhlieu_text = "Lãnh Liệu ( ${donvitinh ?? ''} )";
          }


          soluongdonhang_text = "Đơn Hàng PCS";
          soluongdat_text     = "Số Lượng Đạt ( ${donvitinh ?? ''} )";
          soluongloi_text     = "Số Lượng Lỗi ( ${donvitinh ?? ''} )";
          soluongconlai_text  = "Còn Lại ( ${donvitinh ?? ''} )";

          if(donvitinh == printRibbon.PCS || Globals.NhanVien.boPhan  == printRibbon.TEMVAI)
            soluongconlaiController.text = (tb.SoLuong! - tb.SoLuongDat! - tb.SoLuongLoi!).toString();
          else
            soluongconlaiController.text = (tb.LanhLieu! - tb.SoLuongDat! - tb.SoLuongLoi!).toString();
          soluongdatController.text = soluongconlaiController.text;
          soluongloiController.text = '0';
        });
      }
    } catch (e) {
      // Xử lý lỗi khi gọi API
      showMessage.TopSnackBar(context,'Lỗi khi lấy dữ liệu: $e',Colors.red);
    }
  }
  Future<tbl_BaoCaoSanXuat_V2?> _saveForm(tbl_BaoCaoSanXuat_V2 tb, {isHoanthanh = false}) async {
    try {
    if (!fDateTime.isValidDateTime(thoigianbatdauController.text) || !fDateTime.isValidDateTime(thoigianketthucController.text)) {
      throw Exception('Định dạng ngày giờ không hợp lệ');
    }
    int sanLuongDat   = int.tryParse(soluongdatController.text) ?? 0;
    int sanLuongLoi     = int.tryParse(soluongloiController.text) ?? 0;
    int soLuongConLai   = int.tryParse(soluongconlaiController.text) ?? 0;
    int thoigianchaymay = int.tryParse(thoigianchaymayController.text) ?? 0;
    if (sanLuongDat <= 0) {
      showMessage.TopSnackBar(context,'Số lượng đạt không được nhỏ hơn 0: ',Colors.red);
      return null;
    }
    if (sanLuongDat + sanLuongLoi > soLuongConLai) {
      showMessage.TopSnackBar(context,'Số lượng đạt và lỗi không được lớn hơn số lượng còn lại: ',Colors.red);
      return null;
    }
    if ( thoigianchaymay <= 0) {
      showMessage.TopSnackBar(context,'Thời gian chạy máy không được nhỏ hơn 0: ',Colors.red);
      return null;
    }
    if ( thoigianchaymay > 1000) {
      showMessage.TopSnackBar(context,'Thời gian chạy máy không được lớn hơn 1000 phút: ',Colors.red);
      return null;
    }
    var checkID = await SanXuatApi.BaoCaoSanXuat_V2_GetIDBaoCaoSanXuat(tb);
    if(checkID.length > 0){
      showMessage.TopSnackBar(context,'Dữ liệu đã thêm rồi !!!',Colors.red);
      return null;
    }
    if(sanLuongDat + sanLuongLoi == soLuongConLai) {
      tb.isHoanThanh = 'true';
    }
    const uuid = Uuid();
    tb.IDBaoCaoSanXuat = uuid.v4();
    tb.MSNV             = msnvController.text;
    tb.TenNhanVien      = tenNhanVienController.text;
    DateFormat format   = DateFormat("dd/MM/yyyy HH:mm");
    tb.ThoiGian_BatDau  = format.parse(thoigianbatdauController.text).toString();
    tb.ThoiGian_KetThuc = format.parse(thoigianketthucController.text).toString();
    tb.ThoiGianChayMay  = int.tryParse(thoigianchaymayController.text);
    tb.SoLuongDat       = int.tryParse(soluongdatController.text);
    tb.SoLuongLoi       = int.tryParse(soluongloiController.text);
    tb.CongDoan         = selectedCongDoan!; // Gán công đoạn được chọn
    tb.ThaoTac          = selectedThaoTac;
    tb.GhiChu           = ghichuController.text;
    if(isHoanthanh)
      tb.isHoanThanh = 'true';
      // Chuyển đối tượng thành JSON
      final jsons = json.encode(tb.toJson());
      // Gọi API
      final result = await SanXuatApi.BaoCaoSanXuat_V2_Insert_Json(jsons);
      // Kiểm tra kết quả API (giả định result là boolean hoặc null)
      if (result) {
        showMessage.TopSnackBar(context,'Lưu báo cáo thành công',Colors.green);
      }
      else{
        showMessage.TopSnackBar(context,'Lưu báo cáo thất bại',Colors.red);
      }
      return tb;
    } catch (e) {
      throw Exception('Lỗi khi lưu báo cáo: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    double formWidth = screen.widthForm(context);
    return Scaffold(
      appBar: wAppBar.buildAppBar('BÁO CÁO SẢN XUẤT',onRefresh: () {setState(() {});},),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(4, 16, 4, 0),
        child: Container(
          alignment: Alignment.topCenter,
          width: formWidth,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.lightBlueAccent, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 70, child:wTextField.buildNumberTextField(msnvController, 'MSNV:', readOnly: true)),
                            SizedBox(width: 16),
                            Expanded(child: wTextField.buildNumberTextField(tenNhanVienController, 'Tên Nhân Viên:', readOnly: true)),
                          ],
                        ),
                        //_buildNumberTextField(khachangController, 'Tên Khách Hàng:', readOnly: true),
                        Row(
                            children: [
                          Expanded(child: wTextField.buildNumberTextField(scdController, 'SCD:', readOnly: true)),
                          SizedBox(width: 16),
                             // if (soluongController.text.isNotEmpty && int.parse(soluongController.text) >= 0)
                          //Expanded(child: AnimatedTextFieldCounter(label: soluongdonhang_text, targetNumber: int.parse(soluongController.text),)),
                          Expanded(child: wTextField.buildNumberTextField(soluongController,soluongdonhang_text, readOnly: true)),
                        ]),
                        Row(
                          children: [
                            Expanded(child: wTextField.buildNumberTextField(lanhlieuController,soluonglanhlieu_text, readOnly: true)),
                            SizedBox(width: 16),
                            //if (soluongconlaiController.text.isNotEmpty && int.parse(soluongconlaiController.text) >= 0)
                            //Expanded(child: AnimatedTextFieldCounter(label: 'Số Lượng Đạt:', targetNumber: int.parse(soluongconlaiController.text),)),

                            Expanded(child: wTextField.buildNumberTextField(soluongconlaiController,soluongconlai_text,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold), readOnly: true)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: spacingHeight / 2),
                Card(
                  elevation: 6,
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.lightBlue, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Expanded(
                              flex: 2,
                              child: wDropdownField.buildDropdownField(dsCongDoan, (value) {setState(() {selectedCongDoan = value;getData(value!);});}, selectedValue: selectedCongDoan)),
                          SizedBox(width: 16),
                          Expanded(
                              flex: 2,
                              child: wDropdownField.buildDropdownField(dsThaoTac, (value) {setState(() {selectedThaoTac = value;});}, selectedValue: selectedThaoTac)),
                        ],),

                        Row(
                          children:[
                            Expanded(
                              flex: 3,
                              child: wDateTime.buildDateTimeField(context,'Thời Gian Bắt Đầu:', thoigianbatdauController,
                                  (value) {try {DateFormat('dd/MM/yyyy HH:mm').parseStrict(value!);} catch (e) {}},),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                                flex: 2,
                                child:
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => BaoCao_SanXuat_ChiTiet(SCD: scdController.text,CongDoan: selectedCongDoan!)));
                                  },
                                  icon: const Icon(Icons.list, size: 36),
                                  label: const Text('Chi Tiết'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.indigo,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  ),
                                ),
                            ),
                        ]),

                        Row(children: [
                          Expanded(
                            flex: 3,
                              child: wDateTime.buildDateTimeField(context,'Thời Gian Kết Thúc:', thoigianketthucController,
                              (value) {try {DateFormat('dd/MM/yyyy HH:mm').parseStrict(value!);} catch (e) {}}, readonly: true)),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Thời Gian(Phút):',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                controller: thoigianchaymayController,
                                onChanged: (value) {
                                  try {
                                    if (value.isNotEmpty) {
                                      DateFormat format = DateFormat("dd/MM/yyyy HH:mm");
                                      var thoigianbatdau = format.parse(thoigianbatdauController.text);
                                      int thoigianchaymay = int.parse(thoigianchaymayController.text);
                                      var thoigianketthuc = thoigianbatdau.add(Duration(minutes: thoigianchaymay));
                                      thoigianketthucController.text = DateFormat("dd/MM/yyyy HH:mm").format(thoigianketthuc).toString();
                                    }
                                  } catch (e) {
                                    showMessage.TopSnackBar(context,'Lỗi: $e',Colors.red);
                                  }
                                },
                              ),
                            ),
                          )
                        ],),

                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: wTextField.buildTextField_Number(context,soluongdatController,soluongdat_text),),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: wTextField.buildTextField_Number(context,soluongloiController,soluongloi_text),),
                            ),
                          ],
                        ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Ghi Chú:',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        controller: ghichuController,
                      ),
                    ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: spacingHeight / 2),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () async {
                          await _saveForm(widget.BaoCao);
                        },
                        child: const Text(
                          'Xác Nhận',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spacingHeight * 2),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: () async {
                          await _saveForm(widget.BaoCao,isHoanthanh: true);
                        },
                        child: const Text(
                          'Hoàn Thành',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // AnimatedTextFieldCounter(
                //   label: 'Số Lượng Đạt:',
                //   targetNumber: int.parse(soluongController.text),
                //   duration: Duration(seconds: 0),
                // ),



              ],
            ),
          ),
        ),
      ),
    );
  }

}

class DateTimeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (text.length == 2 && oldValue.text.length == 1 && !text.contains('/')) {
      text += '/';
    } else if (text.length == 5 && oldValue.text.length == 4 && !text.substring(3).contains('/')) {
      text += '/';
    } else if (text.length == 10 && oldValue.text.length == 9 && !text.substring(6).contains(' ')) {
      text += ' ';
    } else if (text.length == 13 && oldValue.text.length == 12 && !text.substring(11).contains(':')) {
      text += ':';
    }
    if (text.length > 16) {
      text = text.substring(0, 16);
    }
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}