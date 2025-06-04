import 'package:flutter/material.dart';
import '../../resources/ThietKe/kich-thuoc-giay.dart';
import '../../utilities/CenterScreen.dart';
import '../../utilities/BuildMenuItem.dart';
import '../KhoNVL/kiemketonkho.dart';
import '../NghiepVu/don_san_xuat_danh_sach.dart';
import '../SanXuat/baocao_sanxuat.dart';
import '../ThietKe/kho-giay-in.dart';
import '../Users/login_page.dart';
//const Color primaryColor = Colors.orange;

class XacNhanPage extends StatefulWidget {
  const XacNhanPage({super.key});
  @override
  State<XacNhanPage> createState() => _XacNhanPageState();
}

class _XacNhanPageState extends State<XacNhanPage> {
  @override
  Widget build(BuildContext context) {
    return CenterScreen(
      title: 'Ứng Dụng',
      child: Container(
        //padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        color: Colors.grey[100], // Nền nhẹ để tăng độ tương phản
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 16, 0,0),
          children: [
            // Cụm Nghiệp Vụ
            buildSection(
              title: 'Barcode',
              color: Colors.blue[700]!,
              items: [
                buildMenuItem(
                  context,
                  title: 'Xác Nhận Đơn Hàng',
                  icon: 'assets/images/accept02_64.png',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DonSanXuat_DanhSach())),
                ),
                buildMenuItem(
                  context,
                  title: 'Báo Cáo Sản Xuất',
                  icon: 'assets/images/checklist03-64.png',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BaoCaoSanXuat(SCD: '',))),
                ),
                buildMenuItem(
                  context,
                  title: 'Kiểm Kê Tồn Kho',
                  icon: 'assets/images/checked03-64.png',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const KiemKeTonKho(MaVatLieu: '', ViTri: '', Kho: ''))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  
}