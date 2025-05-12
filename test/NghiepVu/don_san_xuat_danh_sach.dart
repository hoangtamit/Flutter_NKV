import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import '../../api/NghiepVu/donsanxuat_api.dart';
import '../../model/NghiepVu/tbdonsanxuat.dart';
import 'package:searchable_listview/searchable_listview.dart';
import '../../utilities/values/val_datetime.dart';

List<tbDonSanXuat> users = [];
class DonSanXuat_DanhSach extends StatefulWidget {
  const DonSanXuat_DanhSach({Key? key}) : super(key: key);
  @override
  _DonSanXuat_DanhSachState createState() => _DonSanXuat_DanhSachState();
}
class _DonSanXuat_DanhSachState extends State<DonSanXuat_DanhSach> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: DonSanXuatApi.LoadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState case ConnectionState.none || ConnectionState.waiting || ConnectionState.active) {
            return Container(
              alignment: Alignment.center,
              child: const Text("Loading"),
            );
          }
          else if (snapshot.connectionState case ConnectionState.done) {
            if (snapshot.hasError) {
              return Container(
                alignment: Alignment.center,
                child: const Text("Please Loading"),
              );
            }
          }
          var data = snapshot.data;
          users = data!;
          return const render();
        },
      ),
    );
  }
  Widget renderAsynchSearchableListview() {
    return Container(
      padding: const EdgeInsets.fromLTRB(5,0,5,5),
      child: SearchableList<tbDonSanXuat>.async(
        itemBuilder: (item) {
          return ActorItem(actor: item);
        },
        asyncListCallback: () async {
          await Future.delayed(const Duration(seconds: 1));
          return users;
        },
        asyncListFilter: (query, list) {
          return users.where((element) =>
              element.scd.contains(query)).toList();
        },
        // seperatorBuilder: (context, index) {
        //   return const Divider();
        // },
        //style: const TextStyle(fontSize: 25),
        //emptyWidget: const EmptyView(),
        inputDecoration: InputDecoration(
          labelText: "Search Actor",
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

}
class render extends StatelessWidget {
  const render ({super.key});
  @override
  Widget build(BuildContext context) {
  return  Container(
    padding: const EdgeInsets.fromLTRB(10,50,10,0),
    child: SearchableList<tbDonSanXuat>.async(
      itemBuilder: (item) {
        return ActorItem(actor: item);
      },
      asyncListCallback: () async {
        await Future.delayed(const Duration(seconds: 1));
        return users;
      },
      asyncListFilter: (query, list) {
        return users.where((element) =>
            element.scd.contains(query)).toList();
      },
      // seperatorBuilder: (context, index) {
      //   return const Divider();
      // },
      //style: const TextStyle(fontSize: 16),
      emptyWidget: const EmptyView(),
      inputDecoration: InputDecoration(
        labelText: "Search SCD",
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  );
  }
}
class ActorItem extends StatelessWidget {
  final tbDonSanXuat actor;
  const ActorItem({Key? key, required this.actor,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        DonSanXuatApi.ExportPdf(actor.scd.toString()).then((value)
        {
          //Navigator.push(context, MaterialPageRoute(builder: (context) => PinchPage(style: 'url', pathfile: value[0].url,)));
        });
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.fromLTRB(0,5,0,5),
          height: 110,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SizedBox(width: 60, child: Image.asset('assets/images/checklist-64.png')),
              const SizedBox(width: 5,),
              SizedBox(
                width: 280,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width:100,
                          child: Text('SCD: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(actor.scd.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width:100,
                          child: Text('Khách Hàng: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(actor.tenKhachHang.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width:100,
                          child: Text('Bộ Phận: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(actor.boPhan .toString()),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width:100,
                          child: Text('Số Lượng : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(actor.soLuong.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width:100,
                          child: Text('Giao Hàng : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(ValDateTime.DD_MM_YYYY(actor.ngayGiaoHang.toString())),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Colors.red,
        ),
        Text('no actor is found with this name'),
      ],
    );
  }
}


// Widget Scrollable() {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//               child: StreamBuilder<Object>(
//                 stream: null,
//                 builder: (context, snapshot) =>
//                 (
//                     const TextField(
//                       //onChanged: onChangeTexxt,
//                       //controller: _nameController,
//                       decoration: InputDecoration(
//                         // errorText: snapshot.hasError ? snapshot.error.toString() : null,
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey,
//                               width: 1),
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                         labelText: 'Nhập SCD để tìm đơn hàng',
//                       ),
//                     )
//                 ),),
//             ),
//             Container(
//               child: listviewScrollable(),
//             ),
//           ],
//         ),
//       ),
//     );
// }
//
// Widget listviewScrollable() {
//
//   return ListView.builder(
//     shrinkWrap: true,physics: const ClampingScrollPhysics(),
//     keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//     itemCount: users.length,
//     itemBuilder: (context, index) {
//       if(users.isNotEmpty) {
//         final user = users[index];
//         return  Card(
//           child: Padding(
//             padding: const EdgeInsets.all(5),
//             child: Container(
//               height: 100,
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 children: [
//                   SizedBox(width: 60, child: Image.asset('assets/images/checklist-64.png')),
//                   const SizedBox(                width: 5,              ),
//                   SizedBox(
//                     width: 280,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Row(
//                           children: [
//                             const SizedBox(width:100,
//                               child: Text('SCD: ',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             Text(user.scd.toString()),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             const SizedBox(width:100,
//                               child: Text('Khách Hàng: ',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             Text(user.tenKhachHang.toString()),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             const SizedBox(width:100,
//                               child: Text('Bộ Phận: ',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             Text(user.boPhan .toString()),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             const SizedBox(width:100,
//                               child: Text('Số Lượng : ',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             Text(user.soLuong.toString()),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             const SizedBox(width:100,
//                               child: Text('Giao Hàng : ',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             Text(ValDateTime.DD_MM_YYYY(user.ngayGiaoHang.toString())),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   //const SizedBox(                width: 10,              ),
//                   // SizedBox(
//                   //   child: Column(
//                   //     children: [
//                   //       Transform.scale(
//                   //         scale: 1.5,
//                   //         child: Checkbox(value: true, onChanged: (bool) {},
//                   //           activeColor: Colors.green, tristate: true,
//                   //           shape: RoundedRectangleBorder(
//                   //               borderRadius: BorderRadius.circular(10)),
//                   //         ),
//                   //       ),
//                   //       Transform.scale(
//                   //         scale: 1.5,
//                   //         child : SizedBox(
//                   //           child: Checkbox(
//                   //             value: false, onChanged: (bool) {}, activeColor: Colors.blue,
//                   //             shape: RoundedRectangleBorder(
//                   //                 borderRadius: BorderRadius.circular(10)),
//                   //           ),
//                   //         ),
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }
//       return  const Text('ók');
//     },
//   );
// }
// Future onChangeTexxt(String barcode) async {
//   RegExp exp = RegExp(r'(\b\w{3}\-\d{6}\-\d{4}\b)');
//   var match = exp.hasMatch(barcode);
//   if(match){
//     setState(() {
//       var isValid = authBloc.isValid(barcode);
//       if (isValid) {
//         _nameController.text = barcode;
//         debugPrint(users.length.toString());
//       }
//     });
//
// _outputController.text = barcode;
// }
// }






