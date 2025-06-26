import 'package:flutter/material.dart';
import 'package:nkv/resources/KhoBTP_TP/frmKhoBTP_TP_Xuat.dart';
import 'package:nkv/resources/NghiepVu/frmDonSanXuat.dart';
import '../../resources/ThietKe/kich-thuoc-giay.dart';
import '../../services/Permission.dart';
import '../../utilities/CenterScreen.dart';
import '../../utilities/PrintRibbon.dart';
import '../../widgets/wAppBar.dart';
import '../../model/NhanVien/tbl_nhanvien.dart';
import '../../utilities/BuildMenuItem.dart';
import '../../utilities/globals.dart';
import '../../pdf/openpdf.dart';
import '../../utilities/values/screen.dart';
import '../Demo/demo3.dart';
import '../KhoBTP_TP/frmKhoBTP_TP_Nhap.dart';
import '../KhoBTP_TP/frmKhoBTP_TP_TonKho.dart';
import '../KhoNVL/avery_giaohang.dart';
import '../KhoNVL/frmKhoNVL_NhapKho.dart';
import '../KhoNVL/khonvl_xuatkho.dart';
import '../KhoNVL/kiemketonkho.dart';
import '../KhoNVL/tonkhonvl_vitri.dart';
import '../NghiepVu/don_san_xuat_danh_sach.dart';
import '../NghiepVu/frmDanhSachSanPham.dart';
import '../SanXuat/baocao_sanxuat.dart';
import '../SanXuat/frmQuanLyDonHang.dart';
import '../ThietKe/frmKhoGiayIn.dart';
import '../ThietKe/frmThietKe_TemVai_TiLeTruc.dart';
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
      title:'Ứng Dụng',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(8, 4, 8,4),
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
                  onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'bbiDonSanXuat', page: const frmDonSanXuat(),),
              ),
              buildMenuItem(
                context,
                title: 'Sản Phẩm',
                icon: 'assets/images/checklist04-64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'bbiSanPham', page: const frmDanhSachSanPham(),),
              ),
              buildMenuItem(
                context,
                title: 'AD Giao Hàng',
                icon: 'assets/images/warehouse02_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'bbiAvery_GiaoHang', page: Avery_GiaoHang(),),
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
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'bbiKhoGiayIn', page: const frmKhoGiayIn(),),
              ),
              buildMenuItem(
                context,
                title: 'Tính Dàn Trang',
                icon: 'assets/images/design03_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'bbiTinhDanTrang', page: frmKichThuocGiay(),),
              ),
              buildMenuItem(
                context,
                title: 'Trục Tem Vải',
                icon: 'assets/images/design02_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'bbiThietKe_TemVai_TiLeTruc', page: frmThietKe_TemVai_TiLeTruc(),),
              ),
            ],
          ),
          // Cụm Sản Xuất
          buildSection(
            title: 'Sản Xuất',
            color: Colors.purpleAccent[700]!,
            items: [
              buildMenuItem(
                context,
                title: 'Xác Nhận Đơn Hàng',
                icon: 'assets/images/accept02_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'bbiSanXuat_QuanLyDonHang', page: frmQuanLyDonHang(),)
              ),
              buildMenuItem(
                context,
                title: 'Báo Cáo  Sản Xuất',
                icon: 'assets/images/checklist03-64.png',
                  onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'bbiThietKe_TemVai_TiLeTruc', page: BaoCaoSanXuat(SCD: '',),)
              ),
              buildMenuItem(
                context,
                title: 'Trục Tem Vải',
                icon: 'assets/images/design02_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'bbiThietKe_TemVai_TiLeTruc', page: frmThietKe_TemVai_TiLeTruc(),),
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
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'bbiKhoNVL_Nhap', page: frmKhoNVL_NhapKho(),),
              ),
              buildMenuItem(
                context,
                title: 'Xuất Kho',
                icon: 'assets/images/export01_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'bbiKhoNVL_Xuat', page: frmKhoNVL_XuatKho(),),
              ),
              buildMenuItem(
                context,
                title: 'Tồn Kho',
                icon: 'assets/images/warehouse01_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'bbiKhoNVL_TonKho', page: TonKho_ViTri_DanhSach(),),
              ),
              buildMenuItem(
                context,
                title: 'Quản Lý PO',
                icon: 'assets/images/warehouse06_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'bbiKho_QuanLyPO', page: Avery_GiaoHang(),),
              ),
              buildMenuItem(
                context,
                title: 'AD Giao Hàng',
                icon: 'assets/images/warehouse08_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'bbiAvery_GiaoHang_Kho', page: Avery_GiaoHang(),),
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
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'bbiKhoBTP_TP_Nhap', page: frmKhoBTP_TP_Nhap(),),
              ),
              buildMenuItem(
                context,
                title: 'Xuất Kho',
                icon: 'assets/images/export01_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'bbiKhoBTP_TP_Xuat', page: frmKhoBTP_TP_Xuat(),),
              ),
              buildMenuItem(
                context,
                title: 'Tồn Kho',
                icon: 'assets/images/warehouse01_64.png',
                onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'bbiKhoBTP_TP_TonKho', page: frmKhoBTP_TP_TonKho(),),
              ),
            ],
          ),
        ],
      ),
      //color: Colors.white,
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
  Future<void> _navigateWithPermission({
    required BuildContext context,
    required String allowedBoPhan,
    required Widget page,
  }) async {
    //if (nhanVien?.boPhan == allowedBoPhan || nhanVien?.taiKhoan == 'admin')
    var permission = await Permission.isPermission(allowedBoPhan);
    if(permission){
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    } else {
      _showAccessDenied(context, 'Bạn không có quyền truy cập');
    }
  }
}