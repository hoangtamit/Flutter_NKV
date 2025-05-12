// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:qlsx/nkv/services/sql_conn.dart';
//
// // void main() {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   runApp(MyApp());
// // }
//
// class db extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: "Test",
//       home: TestPage(),
//     );
//   }
// }
//
// class TestPage extends StatefulWidget {
//   const TestPage({Key? key}) : super(key: key);
//
//   @override
//   _TestPageState createState() => _TestPageState();
// }
//
// class _TestPageState extends State<TestPage> {
//    String result = 'disconnect';
//       Future<void> connect(BuildContext ctx) async {
//     debugPrint("Connecting...");
//     debugPrint(SqlConn.isConnected.toString());
//     await SqlConn.connect(ip: '172.16.88.50', port: '1433', databaseName: 'NKV', username: 'sa', password: 'Ngochoa123');
//     debugPrint(SqlConn.isConnected.toString());
//     //result = SqlConn.isConnected.toString();
//   }
//   Future<void> read(String query) async {
//     var res = await SqlConn.readData(query);
//     print(SqlConn.isConnected);
//     result = res.toString();
//     //debugPrint(res.toString());
//   }
//
//   Future<void> write(String query) async {
//     var res = await SqlConn.writeData(query);
//     debugPrint(res.toString());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: result.isEmpty ? Text('ok') : Text(result),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                   onPressed: () => connect(context),
//                   child: const Text("Connect")),
//               ElevatedButton(
//                   onPressed: () => read("SELECT * FROM tbDonViTinh"),
//                   child: const Text("Read")),
//               ElevatedButton(
//                   onPressed: () => write("DELETE FROM IP_List WHERE LOC='vv1'"),
//                   child: const Text("Write")),
//               ElevatedButton(
//                   onPressed: () => write(
//                       "CREATE TABLE Persons (PersonID int, LastName varchar(255), FirstName varchar(255), Address varchar(255),City varchar(255))"),
//                   child: const Text("Create Table")),
//               ElevatedButton(
//                   onPressed: () => write(
//                       "DROP TABLE Persons"),
//                   child: const Text("Delete Table")),
//               ElevatedButton(
//                   onPressed: () => SqlConn.disconnect(),
//                   child: const Text("Disconnect"))
//             ],
//           ),
//         ));
//   }
// }