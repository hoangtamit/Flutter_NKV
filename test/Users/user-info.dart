import 'package:flutter/material.dart';

const Color primaryColor = Colors.orange;
const double avatarSize = 100.0;
const double cardMargin = 16.0;
const double cardPadding = 16.0;
const double titleFontSize = 24.0;
const double subtitleFontSize = 16.0;

class EmployeeInfoPage extends StatelessWidget {
  const EmployeeInfoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin nhân viên'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(cardMargin),
          child: Column(
            children: [
// Ảnh đại diện
              Container(
                margin: const EdgeInsets.symmetric(vertical: cardMargin),
                child: const CircleAvatar(
                  radius: avatarSize / 2,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    size: avatarSize / 2,
                    color: Colors.white,
                  ),
                ),
              ),
// Thông tin nhân viên
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
// Tên nhân viên
                      const Center(
                        child: Text(
                          'Nguyễn Văn A',
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
// Mã nhân viên
                      ListTile(
                        leading: const Icon(Icons.badge, color: primaryColor),
                        title: const Text('Mã nhân viên'),
                        subtitle: const Text('NV001'),
                        subtitleTextStyle: TextStyle(
                          fontSize: subtitleFontSize,
                          color: Colors.black54,
                        ),
                      ),
// Phòng ban
                      ListTile(
                        leading: const Icon(Icons.business, color: primaryColor),
                        title: const Text('Phòng ban'),
                        subtitle: const Text('Phòng Kế toán'),
                        subtitleTextStyle: TextStyle(
                          fontSize: subtitleFontSize,
                          color: Colors.black54,
                        ),
                      ),
// Số điện thoại
                      ListTile(
                        leading: const Icon(Icons.phone, color: primaryColor),
                        title: const Text('Số điện thoại'),
                        subtitle: const Text('0123 456 789'),
                        subtitleTextStyle: TextStyle(
                          fontSize: subtitleFontSize,
                          color: Colors.black54,
                        ),
                      ),
// Email
                      ListTile(
                        leading: const Icon(Icons.email, color: primaryColor),
                        title: const Text('Email'),
                        subtitle: const Text('nguyenvana@example.com'),
                        subtitleTextStyle: TextStyle(
                          fontSize: subtitleFontSize,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}