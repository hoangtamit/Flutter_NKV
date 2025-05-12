import 'package:flutter/material.dart';
import 'package:nkv/resources/ThietKe/kich-thuoc-giay.dart';
import '../KhoNVL/kiemketonkho.dart';
import 'package:flutter/material.dart';
import '../NghiepVu/don_san_xuat_danh_sach.dart';
import '../ThietKe/kho-giay-in.dart';
import '../Users/login_page.dart';

final fontSize = 20;
double imageWidth = 50;
double fontSize_State = 12;
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return //MySample02();
      SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,//color: const Color.fromARGB(255,37, 150, 190),
          //margin: const EdgeInsets.fromLTRB(0,20,0,0),
          padding: const EdgeInsets.fromLTRB(0,40,0,0),
          //constraints: const BoxConstraints.expand(),
          child: const Card(
            //color: Colors.transparent,
            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Nghiệp Vụ',textAlign:TextAlign.left,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                Padding(
                  padding: EdgeInsets.fromLTRB(12,20,12,10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _DonSanXuat_DanhSach(),
                      _DanhSachSanPham(),
                      ADGiaoHang_State(),
                    ],
                  ),
                ),
                Divider(),
                Text('Thiết Kế',textAlign:TextAlign.left,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                Padding(
                  padding: EdgeInsets.fromLTRB(12,20,12,10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      KhoGiayIn_State(),
                      KichThuocGiay_State(),
                      TrucTemVai_State(),
                    ],
                  ),
                ),
                Divider(),
                Text('Kho NVL',textAlign:TextAlign.left,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                Padding(
                  padding: EdgeInsets.fromLTRB(12,20,12,10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _KiemKeTonKho(),
                      _DanhSachSanPham(),
                      _KiemKeTonKho(),
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      );
  }
}
//------------------------------Nghiệp Vụ------------------------//
class _DonSanXuat_DanhSach extends StatelessWidget {
  const _DonSanXuat_DanhSach({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => DonSanXuat_DanhSach())); },
      child: Container(
        width: 100, height: 100,
        alignment: Alignment.center,
        child: Card(
          color: const Color.fromARGB(255,37, 150, 190),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset('assets/images/checklist01-64.png',width: imageWidth),
              Padding(padding: EdgeInsets.fromLTRB(0,10,0,0),),
              //const Divider(),
              Center(child: Text('Đơn Hàng', style: TextStyle(fontSize: fontSize_State), textAlign: TextAlign.center,)),
            ],
          ),
        ),
      ),
    );
  }
}
class _DanhSachSanPham extends StatelessWidget {
  const _DanhSachSanPham({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => DonSanXuat_DanhSach())); },
      child: Container(
        width: 100, height: 100,
        alignment: Alignment.center,
        child: Card(
          color: const Color.fromARGB(255,37, 150, 190),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset('assets/images/checklist03-64.png',width: imageWidth),
              Padding(padding: EdgeInsets.fromLTRB(0,10,0,0),),
              //const Divider(),
              Center(child: Text('Sản Phẩm', style: TextStyle(fontSize: fontSize_State), textAlign: TextAlign.center,)),
            ],
          ),
        ),
      ),
    );
  }
}
class ADGiaoHang_State extends StatelessWidget {
  const ADGiaoHang_State({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => DonSanXuat_DanhSach())); },
      child: Container(
        width: 100, height: 100,
        alignment: Alignment.center,
        child: Card(
          color: const Color.fromARGB(255,37, 150, 190),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset('assets/images/warehouse08_64.png',width: imageWidth),
              Padding(padding: EdgeInsets.fromLTRB(0,10,0,0),),
              //const Divider(),
              Center(child: Text('AD Giao Hàng', style: TextStyle(fontSize: fontSize_State), textAlign: TextAlign.center,)),
            ],
          ),
        ),
      ),
    );
  }
}
//------------------------------Thiết Kế------------------------//
class KhoGiayIn_State extends StatelessWidget {
  const KhoGiayIn_State({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => frmKhoGiayIn())); },
      child: Container(
        width: 100, height: 100,
        alignment: Alignment.center,
        child: Card(
          color: const Color.fromARGB(255,37, 150, 190),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset('assets/images/design01_64.png',width: imageWidth),
              Padding(padding: EdgeInsets.fromLTRB(0,10,0,0),),
              //const Divider(),
              Center(child: Text('Khổ Giấy In', style: TextStyle(fontSize: fontSize_State), textAlign: TextAlign.center,)),
            ],
          ),
        ),
      ),
    );
  }
}
class KichThuocGiay_State extends StatelessWidget {
  const KichThuocGiay_State({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => frmKichThuocGiay())); },
      child: Container(
        width: 100, height: 100,
        alignment: Alignment.center,
        child: Card(
          color: const Color.fromARGB(255,37, 150, 190),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset('assets/images/design03_64.png',width: imageWidth),
              Padding(padding: EdgeInsets.fromLTRB(0,10,0,0),),
              //const Divider(),
              Center(child: Text('Tính Dàn Trang', style: TextStyle(fontSize: fontSize_State), textAlign: TextAlign.center,)),
            ],
          ),
        ),
      ),
    );
  }
}
class TrucTemVai_State extends StatelessWidget {
  const TrucTemVai_State({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())); },
      child: Container(
        width: 100, height: 100,
        alignment: Alignment.center,
        child: Card(
          color: const Color.fromARGB(255,37, 150, 190),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset('assets/images/design02_64.png',width: imageWidth),
              Padding(padding: EdgeInsets.fromLTRB(0,10,0,0),),
              //const Divider(),
              Center(child: Text('Trục Tem Vải', style: TextStyle(fontSize: fontSize_State), textAlign: TextAlign.center,)),
            ],
          ),
        ),
      ),
    );
  }
}
//------------------------------Kho------------------------//
class _KiemKeTonKho extends StatelessWidget {
  const _KiemKeTonKho({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async { await
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const KiemKeTonKho(MaVatLieu:'',ViTri:'',Kho:'',))
      );
      },
      child: Container(
        width: 100, height: 100,
        alignment: Alignment.center,
        child: Card(
          color: const Color.fromARGB(255, 37, 150, 190),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset('assets/images/warehouse01_64.png', width: 50),
              Padding(padding: EdgeInsets.fromLTRB(0,10,0,0),),
              Center(child: Text(
                'Tồn Kho', style: TextStyle(fontSize: fontSize_State),
                textAlign: TextAlign.center,)),
            ],
          ),
        ),
      ),
    );
  }
}
