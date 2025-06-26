import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nkv/api/NhanVien/authorize_api.dart';
import 'package:nkv/blocs/auth_bloc.dart';
import 'package:nkv/model/drop_list_model.dart';
import 'package:nkv/services/show_Dialog.dart';
import 'package:nkv/utilities/loading_dialog.dart';
import '../home.dart';
import 'login_page.dart';

DropListModel dropListModel = DropListModel([OptionItem(id: "1", title: "Option 1"), OptionItem(id: "2", title: "Option 2")]);
OptionItem optionItemSelected = OptionItem(id: '', title: "Chọn quyền truy cập");
const List<String> list = <String>['Long An', 'Bắc Ninh', 'Triết Giang'];
List<String> dsBoPhan = <String>[] ;
String dropdownValue = list.first;
String select_BoPhan = dsBoPhan.first;
bool _showPass = true;


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {
  AuthBloc authBloc = new AuthBloc();
  final TextEditingController _khuvucController = TextEditingController();
  //final TextEditingController _bophanController = TextEditingController();
  final TextEditingController _msnvController  = TextEditingController();
  final TextEditingController _phoneController  = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        //constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child:  SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/nkv.png'),
              const Text("Welcome!", style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: Text("Signup with NKV in simple steps",
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                  alignment: Alignment.centerLeft,
                  child: const Text('Company:')
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: DropdownMenu<String>(
                  controller: _khuvucController,
                  width: 350,
                  initialSelection: list.first,
                  onSelected: (String? value) {
                    setState(() { dropdownValue = value!;});
                  },
                  dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(value: value, label: value);
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: StreamBuilder<dynamic>(
                  stream: authBloc.msnvStream,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: _msnvController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ], // Only numbers can be entered
                      decoration: InputDecoration(
                        errorText: snapshot.hasError ? snapshot.error.toString():"",
                        prefixIcon: SizedBox(
                          width: 50,child: Image.asset('assets/images/coding-16.png'),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey,width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'MSNV',
                      ),
                    );
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: StreamBuilder<dynamic>(
                  stream: authBloc.phoneStream,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        errorText: snapshot.hasError ? snapshot.error.toString(): "",
                        prefixIcon: SizedBox(
                          width: 50,child: Image.asset('assets/images/phone-16.png'),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey,width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Phone',
                      ),
                    );
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: StreamBuilder<dynamic>(
                  stream: authBloc.usernameStream,
                  builder: (context, snapshot) {
                    return TextField(
                      //maxLength: 12,
                      controller: _usernameController,
                      decoration: InputDecoration(
                        errorText: snapshot.hasError ? snapshot.error.toString():'',
                        prefixIcon: SizedBox(
                          width: 50,child: Image.asset('assets/images/user01-16.png'),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey,width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'UserName',
                      ),
                    );
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    StreamBuilder<dynamic>(
                      stream: authBloc.passStream,
                      builder: (context, snapshot) {
                        return TextField(
                          controller: _passController,
                          obscureText: _showPass,
                          decoration: InputDecoration(
                            errorText: snapshot.hasError?snapshot.error.toString():'',
                              labelText: "Password",
                              prefixIcon: SizedBox(
                                width: 50,
                                child: Image.asset("assets/images/password02-16.png",),
                              ),
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: Colors.grey,width: 1,
                                  )
                              )
                          ),
                        );
                      }
                    ),
                    GestureDetector(
                      onTap: onShowPass,
                      child: Text( _showPass ? 'Show  ' : 'Hide  ',
                          style: const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 12)
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: SizedBox(
                  width: double.infinity, height: 52,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),),
                        backgroundColor: Colors.blue
                    ),
                    onPressed: _onSignUpClicked,
                    child: const Text('Signup',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
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

  _onSignUpClicked() {
    var isValid = authBloc.isValid(_msnvController.text,_phoneController.text,_usernameController.text,_passController.text);
    if (isValid) {
      LoadingDialog.showLoadingDialog(context, 'Loading...');
      // authBloc.signUp(_khuvucController.text,_msnvController.text,_usernameController.text, _passController.text,
      //     _phoneController.text, () {
      //       LoadingDialog.hideLoadingDialog(context);
      //       Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      //     }, (msg) {
      //       LoadingDialog.hideLoadingDialog(context);
      //       //MsgDialog.showMsgDialog(context, "Sign-In", msg);
      //       // show msg dialog
      //     });
      AuthorizeApi.Register(_khuvucController.text,_msnvController.text,_usernameController.text, _passController.text, _phoneController.text)
          .then((value) {
        LoadingDialog.hideLoadingDialog(context);
        if(value) {
          ShowDialog.showAlertDialog(context,'Đăng Ký Thành Công !');
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NKVHomePage()));
        }
      }).catchError((onError){
        LoadingDialog.hideLoadingDialog(context);
      });
    }
  }
  void onShowPass()  {
    setState(() {
      _showPass = !_showPass;
    });
  }
}
// Widget build(BuildContext context) {
//   return Scaffold(
//     resizeToAvoidBottomInset: false,
//     body: FutureBuilder(
//       future: BoPhanApi.Get1C(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState case ConnectionState.none || ConnectionState.waiting || ConnectionState.active) {
//           return Container(
//             alignment: Alignment.center,
//             child: const Text("Loading"),
//           );
//         }
//         else if (snapshot.connectionState case ConnectionState.done) {
//           if (snapshot.hasError) {
//             return Container(
//               alignment: Alignment.center,
//               child: const Text("Please Loading"),
//             );
//           }
//         }
//         //dsBoPhan = snapshot.data!;
//         for(var i = 0 ; i < snapshot.data!.length;i++)
//         {
//           var item = snapshot.data![i].id;
//           dsBoPhan.add(item);
//         }
//         return registerPageForm();
//       },
//     ),
//   );
// }
// void _onLoginClick() {
//   String email = _emailController.text;
//   String pass = _passController.text;
//   //var authBloc = NKVHomeScreen.of(context)?.authBloc;
//   //var authBloc = MyApp.of(context).authBloc;
//   //LoadingDialog.showLoadingDialog(context, "Loading...");
//   authBloc?.signIn(email, pass, () {
//     LoadingDialog.hideLoadingDialog(context);
//     Navigator.of(context)
//         .push(MaterialPageRoute(builder: (context) => NKVHomePage()));
//   }, (msg) {
//     LoadingDialog.hideLoadingDialog(context);
//     MsgDialog.showMsgDialog(context, "Sign-In", msg);
//   });
// }

// Future<void> loginUsers() async {
//   if (_formKey.currentState!.validate()) {
//    // show snackbar to indicate loading
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: const Text('Processing Data'),
//       backgroundColor: Colors.green.shade300,
//     ));
//     //get response from ApiClient
//     dynamic res = await authBloc.login(
//       _emailController.text,
//       _passController.text,
//     );
//     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//     //if there is no error, get the user's accesstoken and pass it to HomeScreen
//     if (res['ErrorCode'] == null) {
//       String accessToken = res['access_token'];
//       Navigator.push(context,MaterialPageRoute(builder: (context) => NKVHomePage(accesstoken: accessToken)));
//     } else {
//       //if an error occurs, show snackbar with error message
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Error: ${res['Message']}'),
//         backgroundColor: Colors.red.shade300,
//       ));
//     }
//   }
// }
// void _onLoginClick() {
//   String email = _emailController.text;
//   String pass = _passController.text;
//   var authBloc = NKVHomeScreen.of(context)?.authBloc;
//   //var authBloc = MyApp.of(context).authBloc;
//   LoadingDialog.showLoadingDialog(context, "Loading...");
//   authBloc?.signIn(email, pass, () {
//     LoadingDialog.hideLoadingDialog(context);
//     Navigator.of(context)
//         .push(MaterialPageRoute(builder: (context) => NKVHomePage()));
//   }, (msg) {
//     LoadingDialog.hideLoadingDialog(context);
//     MsgDialog.showMsgDialog(context, "Sign-In", msg);
//   });
// }