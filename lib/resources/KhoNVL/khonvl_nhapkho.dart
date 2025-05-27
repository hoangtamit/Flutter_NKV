import 'package:flutter/material.dart';
import 'package:qlsx/utilities/values/format.dart';
import '../../api/KhoNVL/KhoNVL_api.dart';
import '../../model/KhoNVL/KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap.dart';
import '../../utilities/fDateTime.dart';
import '../../utilities/values/theme.dart';
import 'chitietnhapxuat.dart';
import 'khonvl_chitietnhap.dart';
import 'kiemketonkho.dart';
import 'package:searchable_listview/searchable_listview.dart';

class frmKhoNVL_NhapKho extends StatefulWidget {
  const frmKhoNVL_NhapKho({super.key});
  @override
  _frmKhoNVL_NhapKhoState createState() => _frmKhoNVL_NhapKhoState();
}

class _frmKhoNVL_NhapKhoState extends State<frmKhoNVL_NhapKho> {
  List<KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap> dsTonKho = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh Sách Nhập Kho'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {}),
          ),
        ],
        backgroundColor:primaryColor,
      ),
      body: FutureBuilder<List<KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap>>(
        future: KhoNVLApi.KhoNVL_GroupByMaPhieu_GetNhap(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error loading data: ${snapshot.error}');
            return const Center(child: Text('Lỗi khi tải dữ liệu'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print('No data received from API');
            return const Center(child: Text('Không có dữ liệu tồn kho'));
          }
          dsTonKho = snapshot.data!;
          print('Loaded ${dsTonKho.length} items from API');
          return RenderSearchableList(
            dsTonKho: dsTonKho,
            searchController: _searchController,
          );
        },
      ),
    );
  }
}

class RenderSearchableList extends StatelessWidget {
  final List<KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap> dsTonKho;
  final TextEditingController searchController;
  const RenderSearchableList({
    super.key,
    required this.dsTonKho,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: SearchableList<KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap>(
        searchTextController: searchController,
        itemBuilder: (item) => ActorItem(actor: item),
        // asyncListCallback: () async {
        //   return dsTonKho;
        // },
        filter: (query) {
          return dsTonKho.where((element) => element.maPhieu.contains(query.toLowerCase())).toList();
        },
        // asyncListFilter: (query, list) {
        //   final filtered = dsTonKho.where((element) {
        //     return  element.maVatLieu.contains(query);
        //   }).toList();
        //   print('Filtered ${filtered.length} items');
        //   return filtered;
        // },
        emptyWidget: const EmptyView(),
        inputDecoration: InputDecoration(
          labelText: 'Tìm kiếm Mã Vật Liệu',
          prefixIcon: const Icon(Icons.search),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
          ),
        ),
        initialList: dsTonKho,
      ),
    );
  }
}

class ActorItem extends StatelessWidget {
  final KhoNVL_GroupByMaPhieu_GetIDKhuVuc_GetNhap actor;

  const ActorItem({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    const color = Colors.black87;
    const double fontSize = 14;

    return GestureDetector(
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => KhoNVL_ChiTietNhapXuat(
      //         maVatLieu: actor.maVatLieu,
      //         viTri: actor.viTri,
      //         kho: actor.kho,
      //       ),
      //     ),
      //   );
      // },
      child: Card(
        //color: Colors.orange[50],
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          height: 120,
          child: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(children: [
                            const SizedBox(width: 100, child: Text('Ngày Nhập:',style: TextStyle(fontWeight: FontWeight.bold, color: color,),),),
                            Text(fDateTime.DD_MM_YYYY(actor.ngay.toString()), style: const TextStyle(color: color, fontSize: fontSize,),),
                          ],),
                        Row(
                          children: [
                            const SizedBox(
                              width: 100,
                              child: Text(
                                'Mã Phiếu:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                            ),
                            Text(
                              actor.maPhieu.toString(),
                              style: const TextStyle(
                                color: color,
                                fontSize: fontSize,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 100,
                              child: Text(
                                'Số Lượng:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                            ),
                            Text(
                              formatNumber(actor.tongSoLuong),
                              style: const TextStyle(
                                color: color,
                                fontSize: fontSize,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 100,
                              child: Text(
                                'SL Vật Liệu:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                            ),
                            Text(
                              actor.soLuongVatLieu.toString(),
                              style: const TextStyle(
                                color: color,
                                fontSize: fontSize,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 100,
                              child: Text(
                                'Nhân Viên:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                            ),
                            Text(
                              actor.nguoiQuanKho.toString(),
                              style: const TextStyle(
                                color: color,
                                fontSize: fontSize,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KhoNVL_ChiTietNhap(tb: actor,),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 60,
                      child: Image.asset('assets/images/form03_64.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error, color: Colors.red, size: 48),
        SizedBox(height: 8),
        Text('Không tìm thấy mã vật liệu phù hợp'),
      ],
    );
  }
}