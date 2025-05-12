import 'package:flutter/material.dart';
import 'package:nkv/resources/ThietKe/kich-thuoc-giay.dart';
import '../KhoNVL/kiemketonkho.dart';
import '../NghiepVu/don_san_xuat_danh_sach.dart';
import '../ThietKe/kho-giay-in.dart';
import '../Users/login_page.dart';
const Color primaryColor = Colors.orange;

class XacNhanPage extends StatefulWidget {
  const XacNhanPage({super.key});
  @override
  State<XacNhanPage> createState() => _XacNhanPageState();
}

class _XacNhanPageState extends State<XacNhanPage> {
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
          padding: const EdgeInsets.fromLTRB(10, 16, 10,16),
          children: [
            // Cụm Nghiệp Vụ
            _buildSection(
              title: 'Barcode',
              color: Colors.blue[700]!,
              items: [
                _buildMenuItem(
                  context,
                  title: 'Xác Nhận Đơn Hàng',
                  icon: 'assets/images/accept02_64.png',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DonSanXuat_DanhSach())),
                ),
                _buildMenuItem(
                  context,
                  title: 'Báo Cáo Sản Xuất',
                  icon: 'assets/images/checklist03-64.png',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DonSanXuat_DanhSach())),
                ),
                _buildMenuItem(
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