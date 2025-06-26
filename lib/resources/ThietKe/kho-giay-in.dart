import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nkv/utilities/CenterScreen.dart';
import '../../api/ThietKe/khogiayin_api.dart';
import '../../api/NghiepVu/donsanxuat_api.dart';
import 'package:searchable_listview/searchable_listview.dart';
import '../../model/ThietKe/tbKhoGiayIn.dart';
import '../../utilities/values/screen.dart';
import '../../widgets/wdatatable.dart';

List<tbKhoGiayIn> users = [];
class frmKhoGiayIn2 extends StatefulWidget {
  const frmKhoGiayIn2({Key? key}) : super(key: key);
  @override
  frmKhoGiayIn_State createState() => frmKhoGiayIn_State();
}
class frmKhoGiayIn_State extends State<frmKhoGiayIn2> {
  List<tbKhoGiayIn> filteredUsers = []; // Danh sách dữ liệu đã lọc
  TextEditingController searchController = TextEditingController(); // Controller cho TextField
  @override
  void initState() {
    super.initState();
    // Lắng nghe thay đổi trong TextField để lọc dữ liệu
    searchController.addListener(() {
      filterData();
    });
  }
  @override
  void dispose() {
    searchController.dispose(); // Giải phóng controller
    super.dispose();
  }
  // Hàm lọc dữ liệu dựa trên từ khóa
  void filterData() {
    final query = searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredUsers = users; // Nếu không có từ khóa, hiển thị toàn bộ dữ liệu
      } else {
        filteredUsers = users.where((item) {
          return item.giayLon.toLowerCase().contains(query) ||
              item.catGiay.toLowerCase().contains(query) ||
              item.khoGiayIn.toLowerCase().contains(query) ||
              (item.xoGiay ?? '').toLowerCase().contains(query) ||
              item.ID.toString().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: KhoGiayInApi.LoadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.active) {
            return Container(
              alignment: Alignment.center,
              child: const Text("Loading"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Container(
                alignment: Alignment.center,
                child: const Text("Please Loading"),
              );
            }
          }
          var data = snapshot.data;
          users = data!;
          // Khởi tạo filteredUsers khi dữ liệu được tải lần đầu
          if (filteredUsers.isEmpty && searchController.text.isEmpty) {
            filteredUsers = users;
          }

          // Định nghĩa danh sách columns chung
          final columns = [
            wDatatable.buildDataColumn('ID', width: screen.width(context, 1)),
            wDatatable.buildDataColumn('Giấy Lớn', width: screen.width(context, 2.5)),
            wDatatable.buildDataColumn('Cắt Giấy', width: screen.width(context, 2)),
            wDatatable.buildDataColumn('KGI', width: screen.width(context, 2.5)),
            wDatatable.buildDataColumn('Xớ Giấy', width: screen.width(context, 1.5)),
          ];
          return CenterScreen(
            title: 'Khổ Giấy In',
            child: Column(
              children: [
                // TextField tìm kiếm
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Tìm kiếm',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                  ),
                ),
                // Header cố định
                Container(
                  color: Colors.grey.shade200,
                  child: DataTable(
                    columnSpacing: 8,
                    headingRowHeight: 48,
                    dataRowHeight: 0,
                    border: TableBorder.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                    columns: columns,
                    rows: const [],
                  ),
                ),
                // Nội dung cuộn
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 8,
                        headingRowHeight: 0,
                        dataRowHeight: 48,
                        border: TableBorder.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                        columns: columns,
                        rows: [
                          ...List<DataRow>.generate(
                            filteredUsers.length, // Sử dụng filteredUsers thay vì data
                                (index) => DataRow(
                              color: WidgetStateProperty.resolveWith<Color?>(
                                    (states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                                  }
                                  return index.isEven ? Colors.grey.withOpacity(0.1) : null;
                                },
                              ),
                              cells: [
                                wDatatable.buildDataCell(filteredUsers[index].ID.toString(), width: screen.width(context, 1)),
                                wDatatable.buildDataCell(filteredUsers[index].giayLon.toString(), width: screen.width(context, 2.5)),
                                wDatatable.buildDataCell(filteredUsers[index].catGiay.toString(), width: screen.width(context, 2)),
                                wDatatable.buildDataCell(filteredUsers[index].khoGiayIn.toString(), width: screen.width(context, 2.5)),
                                wDatatable.buildDataCell((filteredUsers[index].xoGiay ?? '0').toString(), width: screen.width(context, 1.5)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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
      child: SearchableList<tbKhoGiayIn>.async(
        itemBuilder: (item) {
          return ActorItem(actor: item);
        },
        asyncListCallback: () async {
          await Future.delayed(const Duration(seconds: 1));
          return users;
        },
        asyncListFilter: (query, list) {
          return users.where((element) =>
              element.chiTietGiay.contains(query)).toList();
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
  final tbKhoGiayIn actor;
  const ActorItem({Key? key, required this.actor,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        DonSanXuatApi.OpenPdf(actor.chiTietGiay.toString()).then((value)
        {
          //Navigator.push(context, MaterialPageRoute(builder: (context) => PinchPage(style: 'url', pathfile: value[0].url,)));
        });
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.fromLTRB(0,5,0,5),
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const SizedBox(width:100,
                      child: Text('Giấy Lớn: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(actor.giayLon.toString()),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width:100,
                      child: Text('Cắt Giấy: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(actor.catGiay.toString()),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width:100,
                      child: Text('KGI: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(actor.khoGiayIn .toString()),
                  ],
                ),
              ],
            ),
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
