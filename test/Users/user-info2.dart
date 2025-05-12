import 'package:flutter/material.dart';
//import 'custom_bottom_navigation.dart';

class EmployeeInfo extends StatefulWidget {
  const EmployeeInfo({super.key});

  @override
  _EmployeeInfoState createState() => _EmployeeInfoState();
}

class _EmployeeInfoState extends State<EmployeeInfo> {
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
                    radius: 30,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 40, color: Colors.white),
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
                            fontSize: 20,
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
                    icon: const Icon(Icons.qr_code, size: 24),
                    onPressed: () {},
                  ),
// Nút Trang cá nhân
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, size: 24),
                    onPressed: () {},
                  ),
// Nút Giới thiệu MoMo
                  IconButton(
                    icon: const Icon(Icons.card_giftcard, size: 24, color: Colors.orange),
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
// Banner khuyến mãi
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.pink.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Lần đầu mời bạn nhận tiền 50K và quà 200K',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
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
                  _buildUtilityItem(Icons.verified, 'Điểm Tín Cậy MoMo'),
                  _buildUtilityItem(Icons.receipt, 'Thanh toán hóa đơn'),
                  _buildUtilityItem(Icons.star, 'MoMo Re'),
// Thêm mục Ngôn ngữ
                  ListTile(
                    leading: const Icon(Icons.language, size: 24, color: Colors.grey),
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
        Icon(icon, size: 24, color: Colors.grey),
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
      leading: Icon(icon, size: 24, color: Colors.grey),
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