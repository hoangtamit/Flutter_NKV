import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nkv/resources/Main/home-page.dart';
import 'barcode_home.dart';

// Widget HomeScreen(){
//   return Scaffold(
//     backgroundColor: Colors.white,
//     body: SizedBox(
//         child: FutureBuilder<bool>(
//             future:  AuthorizeApi.checkToken(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState case ConnectionState.none || ConnectionState.waiting){
//                 return Container(
//                   color: Colors.blueGrey,
//                   child: const Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 );
//               }
//               else if (snapshot.connectionState case ConnectionState.done) {
//                 if (snapshot.hasError) {
//                   return Container(
//                     alignment: Alignment.center,
//                     child: const Text('Loading'),
//                   );
//                 }
//               }
//               if (snapshot.hasData && snapshot.data.toString() == 'true') {
//                 return const NKVHomePage();
//               }
//                 return LoginPage();
//             }
//         )
//     ),
//   );
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//   @override
//   State<HomeScreen> createState() => _HomeScreenState2();
// }
// class _HomeScreenState2 extends State<HomeScreen> async {
// bool result = await AuthorizeApi.checkToken();
//   @override
//   Widget build(BuildContext context) {
//     AuthorizeApi.checkToken().then((value){
//       if(value) {
//         return const NKVHomePage();
//       }
//       return LoginPage();
//     });
//   }
// }
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SizedBox(
//           width: size.width,
//           height: size.height,
//           child: FutureBuilder<bool>(
//               future:  AuthorizeApi.checkToken(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState case ConnectionState.none || ConnectionState.waiting){
//                   return Container(
//                     height: size.height,
//                     width: size.width,
//                     color: Colors.blueGrey,
//                     child: const Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   );
//                 }
//                 else if (snapshot.connectionState case ConnectionState.done) {
//                   if (snapshot.hasError) {
//                     return Container(
//                       alignment: Alignment.center,
//                       child: const Text('Loading Login'),
//                     );
//                   }
//                 }
//                 if (snapshot.hasData && snapshot.data.toString() == 'true') {
//                   return const NKVHomePage();
//                 }
//                 //return Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
//                 return LoginPage();
//               }
//           )
//       ),
//     );
//   }
// }

class NKVHomePage extends StatefulWidget {
  const NKVHomePage({super.key});
  @override
  State<NKVHomePage> createState() => _NKVHomePageState();
}
class _NKVHomePageState extends State<NKVHomePage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber[800],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Trang Chủ',
          ),
          NavigationDestination(
            icon: Icon(Icons.business),
            label: 'Tiện Ích',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.school),
            icon: Icon(Icons.calendar_view_month_outlined),
            label: 'Đơn Hàng',
          ),
          // NavigationDestination(
          //   selectedIcon: Icon(Icons.dashboard),
          //   icon: Icon(Icons.school_outlined),
          //   label: 'Thống Kê',
          // ),
          // NavigationDestination(
          //   selectedIcon: Icon(Icons.dashboard),
          //   icon: Icon(Icons.person_rounded),
          //   label: 'Tôi',
          // ),
        ],
      ),
      body: <Widget>[
        const HomePage(),
        const BarcodeHome(),
        const BarcodeHome(),
        //const DonSanXuat_DanhSach(),
        //const demo(),
      ][currentPageIndex],
      // appBar: AppBar(
      //   title: const Text("NKV"),
      // ),
    );
  }
}

// AndroidSettingsScreen(),

