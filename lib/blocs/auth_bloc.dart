import 'dart:async';

import '../../api/NhanVien/authorize_api.dart';

class AuthBloc {

  //final StreamController _khuvucController = StreamController();
  final StreamController _msnvController = StreamController();
  final StreamController _phoneController = StreamController();
  final StreamController _usernameController = StreamController();
  final StreamController _passController = StreamController();

  //Stream get khuvucStream   => _khuvucController.stream;
  Stream get msnvStream     => _msnvController.stream;
  Stream get phoneStream    => _phoneController.stream;
  Stream get usernameStream => _usernameController.stream;
  Stream get passStream     => _passController.stream;

  bool isValid(String msnv,String phone,String username,String password) {
    if (msnv.length < 4 || msnv.length > 5) {
      _msnvController.sink.addError("Vui lòng nhập đúng Mã Nhân Viên !!!");
      return false;
    }
    _msnvController.sink.add("");

    // if(phone.length < 10 || phone.length > 11){
    //   _phoneController.sink.addError("Vui lòng nhập đúng số điện thoại !!!");
    //   return false;
    // }
    // _phoneController.sink.add("");

    if(username.length < 5 || username.length > 15){
      _usernameController.sink.addError("Độ dài mật khẩu từ 8 đến 15 !!!");
      return false;
    }
    _usernameController.sink.add("");

    if(password.length < 8 || phone.length > 15){
      _passController.sink.addError("Độ dài mật khẩu từ 8 đến 15 !!!");
      return false;
    }
    _passController.sink.add("");

    return true;
  }

  void signUp(String khuvuc, String MaNhanVien, String username, String password,String phone,
      Function onSuccess, Function(String) onError) {
    AuthorizeApi.Register(khuvuc, MaNhanVien, username, password, phone);
  }

  void dispose() {
    //_khuvucController.close();
    _msnvController.close();
    _phoneController.close();
    _usernameController.close();
    _passController.close();
  }
}
