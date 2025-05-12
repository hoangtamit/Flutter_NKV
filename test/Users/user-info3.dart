import 'package:flutter/material.dart';
//import 'custom_bottom_navigation.dart';
const Color primaryColor = Colors.orange;

class EmployeeInfoPage extends StatefulWidget {
  const EmployeeInfoPage({super.key});
  @override
  _EmployeeInfoPageState createState() => _EmployeeInfoPageState();
}

class _EmployeeInfoPageState extends State<EmployeeInfoPage> {
  int _currentIndex = 4; // Mục "TÔI" được chọn
  bool _isVietnamese = true; // Trạng thái ngôn ngữ: true = VI, false = EN
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
// Xử lý điều hướng nếu cần
  }

  void _toggleLanguage() {
    setState(() {
      _isVietnamese = !_isVietnamese;
    });
// Trong ứng dụng thực tế, bạn có thể gọi hàm để thay đổi ngôn ngữ toàn ứng dụng
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin nhân viên'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
// Header
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: [
// Avatar
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 80, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
// Thông tin nhân viên
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nguyễn Hoàng Tâm',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '0909900120',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.check_circle, size: 16, color: Colors.green),
                            const SizedBox(width: 4),
                            Text(
                              'Đã sinh trắc học',
                              style: TextStyle(fontSize: 14, color: Colors.green),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
// Nút QR
                  IconButton(
                    icon: const Icon(Icons.qr_code, size: 60),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
// Menu chính
            Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuItem(Icons.credit_card, 'Quản lý thẻ'),
                  _buildMenuItem(Icons.settings, 'Cài đặt thông tin'),
                  _buildMenuItem(Icons.lock, 'Đăng nhập và bảo mật'),
                  _buildMenuItem(Icons.notifications, 'Thông báo'),
                ],
              ),
            ),
// Tiện ích
            Padding(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Tiện ích',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  _buildUtilityItem(Icons.account_balance, 'Trung Tâm Tài Chính'),
                  _buildUtilityItem(Icons.pie_chart, 'Quản Lý Chi Tiêu'),
                  _buildUtilityItem(Icons.card_giftcard, 'Quà của tui'),
                  _buildUtilityItem(Icons.verified, 'Điểm Tín Cậy'),
                  _buildUtilityItem(Icons.receipt, 'Thanh toán hóa đơn'),
                  ListTile(
                    leading: const Icon(Icons.fingerprint, size: 24, color:Colors.purple),
                    title: const Text(
                      'Vân Tay',
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildLanguageOption('EN', !_isVietnamese),
                          _buildLanguageOption('VI', _isVietnamese),
                        ],
                      ),
                    ),
                    onTap: _toggleLanguage,
                  ),
// Thêm mục Ngôn ngữ
                  ListTile(
                    leading: const Icon(Icons.language, size: 24, color: Colors.purple),
                    title: const Text(
                      'Ngôn ngữ',
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildLanguageOption('EN', !_isVietnamese),
                          _buildLanguageOption('VI', _isVietnamese),
                        ],
                      ),
                    ),
                    onTap: _toggleLanguage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: CustomBottomNavigation(
      //   currentIndex: _currentIndex,
      //   onTap: _onItemTapped,
      // ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return Column(
      children: [
        Icon(icon, size: 24, color: primaryColor),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildUtilityItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, size: 24, color: primaryColor),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {},
    );
  }

  Widget _buildLanguageOption(String language, bool isSelected) {
    return GestureDetector(
      onTap: _toggleLanguage,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          language,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}