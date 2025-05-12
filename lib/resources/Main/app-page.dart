import 'package:flutter/material.dart';
import 'package:nkv/resources/ThietKe/kich-thuoc-giay.dart';
import '../../model/NhanVien/tbl_nhanvien.dart';
import '../../utilities/globals.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ứng Dụng'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Container(
        //padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        color: Colors.grey[100], // Nền nhẹ để tăng độ tương phản
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 0, 0,0),
          children: [
          // Cụm Nghiệp Vụ
            _buildSection(
              title: 'Nghiệp Vụ',
              color: Colors.blue[700]!,
              items: [
                _buildMenuItem(
                  context,
                  title: 'Đơn Hàng',
                  icon: 'assets/images/checklist01-64.png',
                    onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'Nghiệp Vụ', page: const DonSanXuat_DanhSach(),),
                ),
                _buildMenuItem(
                  context,
                  title: 'Sản Phẩm',
                  icon: 'assets/images/checklist03-64.png',
                  onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'Nghiệp Vụ', page: const DonSanXuat_DanhSach(),),
                ),
                _buildMenuItem(
                  context,
                  title: 'AD Giao Hàng',
                  icon: 'assets/images/warehouse08_64.png',
                  onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'Nghiệp Vụ', page: const DemoScreen(),),
                ),
              ],
            ),
            //const SizedBox(height: 16),
// Cụm Thiết Kế
            _buildSection(
              title: 'Thiết Kế',
              color: Colors.green[700]!,
              items: [
                _buildMenuItem(
                  context,
                  title: 'Khổ Giấy In',
                  icon: 'assets/images/design01_64.png',
                  onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'THIẾT KẾ', page: const frmKhoGiayIn(),),
                ),
                _buildMenuItem(
                  context,
                  title: 'Tính Dàn Trang',
                  icon: 'assets/images/design03_64.png',
                  onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'THIẾT KẾ', page: frmKichThuocGiay(),),
                ),
                _buildMenuItem(
                  context,
                  title: 'Trục Tem Vải',
                  icon: 'assets/images/design02_64.png',
                  onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'THIẾT KẾ', page: frmKichThuocGiay(),),
                ),
              ],
            ),
            //const SizedBox(height: 16),
// Cụm Kho NVL
            _buildSection(
              title: 'Kho NVL',
              color: Colors.grey[700]!,
              items: [
                _buildMenuItem(
                  context,
                  title: 'Nhập Kho',
                  icon: 'assets/images/import01_64.png',
                  onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'KHONVL', page: frmKhoNVL_NhapKho(),),
                ),
                _buildMenuItem(
                  context,
                  title: 'Xuất Kho',
                  icon: 'assets/images/export01_64.png',
                  onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'KHONVL', page: frmKhoNVL_XuatKho(),),
                ),
                _buildMenuItem(
                  context,
                  title: 'Tồn Kho',
                  icon: 'assets/images/warehouse01_64.png',
                  onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'KHONVL', page: TonKho_ViTri_DanhSach(),),
                ),
                _buildMenuItem(
                  context,
                  title: 'Kiểm Kê',
                  icon: 'assets/images/checked02-64.png',
                  onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'KHONVL', page: KiemKeTonKho(MaVatLieu: '', ViTri: '', Kho: ''),),
                ),
                _buildMenuItem(
                  context,
                  title: 'AD Giao Hàng',
                  icon: 'assets/images/warehouse08_64.png',
                  onTap: () => _navigateWithPermission(context: context, allowedBoPhan: 'KHONVL', page: Avery_GiaoHang(),),
                ),
              ],
            ),
          ],
        ),
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

// Widget xây dựng cụm (section)
  Widget _buildSection({
    required String title,
    required Color color,
    required List<Widget> items,
  }) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16,0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tiêu đề cụm
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // GridView cho các mục
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: ScrollPhysics() ,//const NeverScrollableScrollView(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              //childAspectRatio: 0.8, // Tỷ lệ chiều rộng/chiều cao
              children: items,
            ),
          ],
        ),
      ),
    );
  }

// Widget xây dựng mục (menu item)
  Widget _buildMenuItem(
      BuildContext context, {
        required String title,
        required String icon,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                width: 50,
                height: 50,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}