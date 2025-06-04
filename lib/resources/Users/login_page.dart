import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:qlsx/api/NhanVien/authorize_api.dart';
import 'package:qlsx/resources/Users/register_page.dart';
import 'package:qlsx/services/show_Dialog.dart';
import 'package:qlsx/resources/Users/register_page.dart';
import 'package:qlsx/utilities/values/screen.dart';
import '../../model/drop_list_model.dart';
import '../../utilities/loading_dialog.dart';
import '../home.dart';

final TextEditingController _khuvucController = TextEditingController();
final TextEditingController _usernameController = TextEditingController();
final TextEditingController _passController = TextEditingController();
DropListModel dropListModel = DropListModel([OptionItem(id: "1", title: "Option 1"), OptionItem(id: "2", title: "Option 2")]);
OptionItem optionItemSelected = OptionItem(id: '', title: "Chọn quyền truy cập");
const List<String> list = <String>['Long An', 'Bắc Ninh', 'Triết Giang'];
String dropdownValue = list.first;
bool Remember = true;
bool _showPass = true;

class LoginPage extends StatelessWidget {
  final AuthorizeApi auth = AuthorizeApi();

  static Future<Map<String, dynamic>> getUserProfile() async {
    var profile = await AuthorizeApi.getUserProfileData();
    return profile;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserProfile(),
      builder: (context, snapshot) {
        try {
          _khuvucController.text = '';
          _usernameController.text = '';
          _passController.text = '';
          if (snapshot.hasData && snapshot.data?['success'] == 'true') {
            var data = snapshot.data;
            var remember = data?['rememberMe'];
            if (bool.parse(remember) == true) {
              _khuvucController.text = snapshot.data!['khuvuc'];
              _usernameController.text = snapshot.data!['username'];
              _passController.text = snapshot.data!['password'];
              Remember = bool.parse(snapshot.data!['rememberMe']);
            }
          }
        } catch (ex) {
          ShowDialog.showAlertDialog(context, 'Lỗi $ex');
        }
        return const Login();
      },
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    // Xác định chiều rộng dựa trên nền tảng
    double formWidth = screen.widthForm(context);
    return Scaffold(
      body: Center(
        child: Container(
          width: formWidth, // Áp dụng chiều rộng động
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/nkv.png'),
                const Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Text(
                    "Login to continue",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                  alignment: Alignment.centerLeft,
                  child: const Text('Company:'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: DropdownMenu<String>(
                    controller: _khuvucController,
                    width: formWidth - 60, // Trừ padding
                    initialSelection: list.first,
                    onSelected: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(value: value, label: value);
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      prefixIcon: SizedBox(
                        width: 50,
                        child: Image.asset('assets/images/user01-16.png'),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'UserName',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: [
                      TextField(
                        controller: _passController,
                        obscureText: _showPass,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: SizedBox(
                            width: 50,
                            child: Image.asset("assets/images/password02-16.png"),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                        ),
                        onSubmitted: (value) {
                          loginUsers(); // Gọi hàm đăng nhập khi nhấn Enter
                        },
                      ),
                      GestureDetector(
                        onTap: onShowPass,
                        child: Text(
                          _showPass ? 'Show  ' : 'Hide  ',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: const Text('Forget password?'),
                      ),
                      Row(
                        children: [
                          const Text('Remember Me'),
                          Checkbox(
                            activeColor: Colors.blue,
                            value: Remember,
                            onChanged: (value) {
                              setState(() {
                                Remember = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: loginUsers,
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage()),
                          );
                        },
                        child: const Text(
                          'Sign up for a new account',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future loginUsers() async {
    LoadingDialog.showLoadingDialog(context, "Loading...");
    String khuvuc = _khuvucController.text;
    String username = _usernameController.text;
    String password = _passController.text;
    AuthorizeApi.Login(khuvuc, username, password, Remember).then((value) async {
      LoadingDialog.hideLoadingDialog(context);
      if (value == 'true') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const qlsxHomePage()));
      } else {
        ShowDialog.showAlertDialog(context, value);
      }
    });
  }

  void onShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }
}