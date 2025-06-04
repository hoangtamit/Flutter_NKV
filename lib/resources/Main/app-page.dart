import 'package:flutter/material.dart';
import 'package:qlsx/resources/ThietKe/kich-thuoc-giay.dart';
import 'package:qlsx/utilities/CenterScreen.dart';
import 'package:qlsx/widgets/wAppBar.dart';
import '../../model/NhanVien/tbl_nhanvien.dart';
import '../../utilities/BuildMenuItem.dart';
import '../../utilities/globals.dart';
import '../../pdf/openpdf.dart';
import '../../utilities/values/screen.dart';
import '../KhoNVL/avery_giaohang.dart';
import '../KhoNVL/khonvl_nhapkho.dart';
import '../KhoNVL/khonvl_xuatkho.dart';
import '../KhoNVL/kiemketonkho.dart';
import '../KhoNVL/tonkhonvl_vitri.dart';
import '../NghiepVu/don_san_xuat_danh_sach.dart';
import '../ThietKe/kho-giay-in.dart';
import '../Demo/demo.dart';

tbl_NhanVien? nhanVien;

class AppPage extends StatefulWidget {
  const AppPage({super.key});
  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  void initState() {
    super.initState();
    // Lấy từ biến toàn cục
    nhanVien = Globals.NhanVien;
  }
  @override
  Widget build(BuildContext context) {
    return CenterScreen(
      title:'ỨNG DỤNG',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0,0),
        children: [
        // Cụm Nghiệp Vụ
          buildSection(
            title: 'Nghiệp Vụ',
            color: Colors.blue[700]!,
            items: [
              buildMenuItem(
                context,
                title: 'Đơn Hàng',
                icon: 'assets/images/checklist01-64.png',
                  onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'Nghiệp Vụ', page: const DonSanXuat_DanhSach(),),
              ),
              buildMenuItem(
                context,
                title: 'Sản Phẩm',
                icon: 'assets/images/checklist03-64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'Nghiệp Vụ', page: const DonSanXuat_DanhSach(),),
              ),
              buildMenuItem(
                context,
                title: 'AD Giao Hàng',
                icon: 'assets/images/warehouse02_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'Nghiệp Vụ', page: const DemoScreen(),),
              ),
            ],
          ),
          //const SizedBox(height: 16),
              // Cụm Thiết Kế
          buildSection(
            title: 'Thiết Kế',
            color: Colors.green[700]!,
            items: [
              buildMenuItem(
                context,
                title: 'Khổ Giấy In',
                icon: 'assets/images/design01_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'THIẾT KẾ', page: const frmKhoGiayIn(),),
              ),
              buildMenuItem(
                context,
                title: 'Tính Dàn Trang',
                icon: 'assets/images/design03_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'THIẾT KẾ', page: frmKichThuocGiay(),),
              ),
              buildMenuItem(
                context,
                title: 'Trục Tem Vải',
                icon: 'assets/images/design02_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'THIẾT KẾ', page: frmKichThuocGiay(),),
              ),
            ],
          ),
          //const SizedBox(height: 16),
              // Cụm Kho NVL
          buildSection(
            title: 'Kho NVL',
            color: Colors.grey[700]!,
            items: [
              buildMenuItem(
                context,
                title: 'Nhập Kho',
                icon: 'assets/images/import01_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'KHONVL', page: frmKhoNVL_NhapKho(),),
              ),
              buildMenuItem(
                context,
                title: 'Xuất Kho',
                icon: 'assets/images/export01_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'KHONVL', page: frmKhoNVL_XuatKho(),),
              ),
              buildMenuItem(
                context,
                title: 'Tồn Kho',
                icon: 'assets/images/warehouse01_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'KHONVL', page: TonKho_ViTri_DanhSach(),),
              ),
              buildMenuItem(
                context,
                title: 'Quản Lý PO',
                icon: 'assets/images/warehouse06_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'KHONVL', page: Avery_GiaoHang(),),
              ),
              buildMenuItem(
                context,
                title: 'AD Giao Hàng',
                icon: 'assets/images/warehouse08_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'KHONVL', page: Avery_GiaoHang(),),
              ),
              buildMenuItem(
                context,
                title: 'Kiểm Kê',
                icon: 'assets/images/checked02-64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'KHONVL', page: KiemKeTonKho(MaVatLieu: '', ViTri: '', Kho: ''),),
              ),
            ],
          ),
          buildSection(
            title: 'Kho BTP-TP',
            color: Colors.yellow[700]!,
            items: [
              buildMenuItem(
                context,
                title: 'Nhập Kho',
                icon: 'assets/images/import01_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'KHOBTP-TP', page: frmKhoNVL_NhapKho(),),
              ),
              buildMenuItem(
                context,
                title: 'Xuất Kho',
                icon: 'assets/images/export01_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'KHOBTP-TP', page: frmKhoNVL_XuatKho(),),
              ),
              buildMenuItem(
                context,
                title: 'Tồn Kho',
                icon: 'assets/images/warehouse01_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'KHOBTP-TP', page: TonKho_ViTri_DanhSach(),),
              ),
            ],
          ),
        ],
      ),
    );
  }
  void _showAccessDenied(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }
  void _navigateWithPermission({
    required BuildContext context,
    required String allowedBoPhan,
    required Widget page,
  }) {
    if (nhanVien?.boPhan == allowedBoPhan || nhanVien?.taiKhoan == 'admin') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    } else {
      _showAccessDenied(context, 'Chỉ bộ phận $allowedBoPhan mới được truy cập');
    }
  }
}