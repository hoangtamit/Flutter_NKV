import 'package:flutter/material.dart';
import 'package:nkv/resources/Users/login_page.dart';
import '../../model/NhanVien/tbl_nhanvien.dart';
import '../../utilities/globals.dart';

const Color primaryColor = Colors.orange;
const double avatarSize = 80.0;
const double cardMargin = 16.0;
const double cardPadding = 0.0;
const double titleFontSize = 24.0;
const double subtitleFontSize = 16.0;
tbl_NhanVien? nhanVien;
bool _isVietnamese = true;
class EmployeeInfoPage extends StatefulWidget {
  const EmployeeInfoPage({super.key});
  @override
  _EmployeeInfoPageState createState() => _EmployeeInfoPageState();
}
class _EmployeeInfoPageState extends State<EmployeeInfoPage> {
  void _toggleLanguage() {
    setState(() {
      _isVietnamese = !_isVietnamese;
    });
// Trong ứng dụng thực tế, bạn có thể gọi hàm để thay đổi ngôn ngữ toàn ứng dụng
  }
  void _logout() {
// Điều hướng đến LoginPage và xóa toàn bộ stack điều hướng
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false, // Xóa toàn bộ stack
    );
  }
  @override
  void initState() {
    super.initState();
    // Lấy từ biến toàn cục
    nhanVien = Globals.NhanVien;

    // Nếu bạn muốn lấy từ SecureStorage:
    // _loadNhanVienFromStorage();
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
          child: Padding(
            padding: const EdgeInsets.all(cardMargin),
            child: Column(
              children: [
// Ảnh đại diện
                Container(
                  margin: const EdgeInsets.fromLTRB(0,0,0,8),
                  child: CircleAvatar(
                    radius: avatarSize / 2,
                    backgroundColor: Colors.grey,
                    child: Image.asset('assets/images/user01_128.png'),
                    // Icon(
                    //   Icons.person,
                    //   size: avatarSize / 2,
                    //   color: Colors.white,
                    // ),
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
                        Center(
                          child: Text(nhanVien?.tenNhanVien ?? '---',
                            style: const TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        //const SizedBox(height: 16),
// Mã nhân viên
                        ListTile(
                          leading: const Icon(Icons.badge, color: primaryColor),
                          title: const Text('Mã nhân viên'),
                          subtitle: Text(nhanVien?.maNhanVien),
                          subtitleTextStyle: TextStyle(
                            fontSize: subtitleFontSize,
                            color: Colors.black54,
                          ),
                        ),
// Phòng ban
                        ListTile(
                          leading: const Icon(Icons.business,
                              color: primaryColor),
                          title: const Text('Bộ Phận'),
                          subtitle: Text(nhanVien!.boPhan),
                          subtitleTextStyle: TextStyle(
                            fontSize: subtitleFontSize,
                            color: Colors.black54,
                          ),
                        ),
// Số điện thoại
                        ListTile(
                          leading: const Icon(Icons.phone, color: primaryColor),
                          title: const Text('Số điện thoại'),
                          subtitle: Text(nhanVien!.dienThoai),
                          subtitleTextStyle: TextStyle(
                            fontSize: subtitleFontSize,
                            color: Colors.black54,
                          ),
                        ),
// Email
                        ListTile(
                          leading: const Icon(Icons.email, color: primaryColor),
                          title: const Text('Email'),
                          subtitle: Text(nhanVien?.email),
                          subtitleTextStyle: TextStyle(
                            fontSize: subtitleFontSize,
                            color: Colors.black54,
                          ),
                        ),
                        _buildUtilityItem(Icons.account_balance, 'Trung Tâm Tài Chính'),
                        ListTile(
                          leading: const Icon(Icons.fingerprint, size: 24, color: primaryColor),
                          title: const Text(
                            'Vân Tay',
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildLanguageOption('Yes', !_isVietnamese),
                                _buildLanguageOption('No', _isVietnamese),
                              ],
                            ),
                          ),
                          onTap: _toggleLanguage,
                        ),
// Thêm mục Ngôn ngữ
                        ListTile(
                          leading: const Icon(Icons.language, size: 24,
                              color: primaryColor),
                          title: const Text(
                            'Ngôn ngữ',
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
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
                ),
                Padding(
                  padding:const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: SizedBox(
                    width: 110, height: 40,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),),
                          backgroundColor: Colors.orange
                      ),
                      onPressed: _logout,
                      child: const Text('Đăng Xuất',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
  Future logOut() async {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}