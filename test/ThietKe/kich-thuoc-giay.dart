import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nkv/api/NhanVien/authorize_api.dart';
import 'package:nkv/api/ThietKe/thietke_api.dart';
import 'package:nkv/model/ThietKe/ThongTinDanTrang_V2.dart';
import 'package:nkv/model/ThietKe/tbKhoGiayIn.dart';
import 'package:nkv/model/ThietKe/tbl_GiayLon.dart';
import 'package:nkv/resources/Users/register_page.dart';
import 'package:nkv/services/show_Dialog.dart';
import '../../api/NghiepVu/donsanxuat_api.dart';
import '../../model/drop_list_model.dart';
import '../../utilities/loading_dialog.dart';
import 'package:searchable_listview/searchable_listview.dart';

List<tbl_GiayLon> dsGiayLon = [];
List<ThongTinDanTrang_V2> dsTinhDanTrang = [];
bool showRender = false; // cờ để hiển thị render
String? dropdownValue;
class frmKichThuocGiay extends StatelessWidget {
  final AuthorizeApi auth = AuthorizeApi();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GiayLonApi.LoadData(), // Đảm bảo hàm này trả về Future<List<YourDataType>>
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Hiển thị vòng xoay tải
        } else if (snapshot.hasError) {
          return Center(child: Text('Lỗi: ${snapshot.error}')); // Xử lý lỗi
        } else if (snapshot.hasData) {
          //dsGiayLon = snapshot.data as List<tbl_GiayLon>; // Thay YourDataType bằng kiểu dữ liệu thực tế
          return Login(dsGiayLon: snapshot.data as List<tbl_GiayLon>);
        }
        return Login(dsGiayLon: snapshot.data as List<tbl_GiayLon>); // Widget dự phòng nếu không có dữ liệu
      },
    );
  }
}
class Login extends StatefulWidget {
  final List<tbl_GiayLon> dsGiayLon;
  const Login({super.key, required this.dsGiayLon});

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  final TextEditingController _giaylonController = TextEditingController();
  final TextEditingController _khogiayinController = TextEditingController();
  final TextEditingController _kichthuocController = TextEditingController();

  String? dropdownValue;
  List<ThongTinDanTrang_V2> dsTinhDanTrang = [];
  bool showRender = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        // Đảm bảo Container có kích thước giới hạn
        child: SizedBox(
          height: MediaQuery.of(context).size.height, // Chiều cao toàn màn hình
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                    child: TextField(
                      controller: _kichthuocController,
                      decoration: InputDecoration(
                        prefixIcon: SizedBox(
                          width: 50,
                          child: Image.asset('assets/images/size01_16.png'),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Nhập Kích Thước',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                    alignment: Alignment.centerLeft,
                    child: const Text('Giấy Lớn:'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: DropdownMenu<String>(
                      controller: _giaylonController,
                      width: 350,
                      initialSelection: widget.dsGiayLon.isNotEmpty ? widget.dsGiayLon.first.idGiayLon.toString() : null,
                      onSelected: (String? value) async {
                        if (value != null) {
                          setState(() {
                            dropdownValue = value;
                            showRender = false;
                            dsTinhDanTrang = [];
                          });
                          try {
                            final danhSachMoi = await KhoGiayInApi.tinhDanTrang(value, _kichthuocController.text);
                            setState(() {
                              dsTinhDanTrang = danhSachMoi ?? [];
                              showRender = dsTinhDanTrang.isNotEmpty;
                              print("Dữ liệu render: ${dsTinhDanTrang.length}");
                            });
                          } catch (e) {
                            setState(() {
                              showRender = false;
                              dsTinhDanTrang = [];
                            });
                            ShowDialog.showAlertDialog(context, 'Lỗi: $e');
                          }
                        }
                      },
                      dropdownMenuEntries: widget.dsGiayLon.isNotEmpty
                          ? widget.dsGiayLon
                          .map((item) => DropdownMenuEntry<String>(
                        value: item.idGiayLon.toString(),
                        label: item.idGiayLon.toString(),
                      ))
                          .toList()
                          : [],
                    ),
                  ),
                  if (showRender && dsTinhDanTrang.isNotEmpty)
                    render(dsTinhDanTrang: dsTinhDanTrang),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class render extends StatelessWidget {
  final List<ThongTinDanTrang_V2> dsTinhDanTrang;
  const render({super.key, required this.dsTinhDanTrang});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10,0, 10, 0),
      // Giới hạn chiều cao cho SearchableList
      child: SizedBox(
        height: 400, // Chiều cao cố định, điều chỉnh theo nhu cầu
        child: SearchableList<ThongTinDanTrang_V2>.async(
          itemBuilder: (item) {
            return ActorItem(actor: item);
          },
          asyncListCallback: () async {
            return dsTinhDanTrang;
          },
          asyncListFilter: (query, list) {
            return dsTinhDanTrang
                .where((element) =>
                element.kgi.toLowerCase().contains(query.toLowerCase()))
                .toList();
          },
          emptyWidget: const EmptyView(),
          // inputDecoration: InputDecoration(
          //   labelText: "Search SCD",
          //   fillColor: Colors.white,
          //   focusedBorder: OutlineInputBorder(
          //     borderSide: const BorderSide(color: Colors.blue, width: 1.0),
          //     borderRadius: BorderRadius.circular(10.0),
          //   ),
          // ),
        ),
      ),
    );
  }
}
class ActorItem extends StatelessWidget {
  final ThongTinDanTrang_V2 actor;
  const ActorItem({Key? key, required this.actor,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        DonSanXuatApi.ExportPdf(actor.kgi.toString()).then((value)
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
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width:100,
                          child: Text('Khổ Giấy In: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(actor.kgi.toString()),
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
                          child: Text('RK: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(actor.rk .toString()),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width:100,
                          child: Text('Tổng : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(actor.kgITong.toString()),
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


