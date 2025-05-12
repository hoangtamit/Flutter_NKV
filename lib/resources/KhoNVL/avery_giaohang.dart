import 'package:flutter/material.dart';
import 'package:nkv/utilities/values/format.dart';
import '../../api/KhoNVL/KhoNVL_api.dart';
import '../../model/KhoNVL/tbl_Avery_GiaoHang.dart';
import '../../utilities/values/theme.dart';
import 'chitietnhapxuat.dart';
import 'khonvl_phieunhap.dart';
import 'kiemketonkho.dart';
import 'package:searchable_listview/searchable_listview.dart';

class Avery_GiaoHang extends StatefulWidget {
  const Avery_GiaoHang({super.key});
  @override
  _Avery_GiaoHangState createState() => _Avery_GiaoHangState();
}

class _Avery_GiaoHangState extends State<Avery_GiaoHang> {
  List<tbl_Avery_GiaoHang> dsAveryGiaoHang = [];
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
        title: const Text('Danh Sách AD Giao Hàng'),
        centerTitle: true,
        backgroundColor:primaryColor,
      ),
      body: FutureBuilder<List<tbl_Avery_GiaoHang>>(
        future: KhoNVLApi.Avery_GiaoHang_LoadData(),
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
          dsAveryGiaoHang = snapshot.data!;
          print('Loaded ${dsAveryGiaoHang.length} items from API');
          return RenderSearchableList(
            dsAveryGiaoHang: dsAveryGiaoHang,
            searchController: _searchController,
          );
        },
      ),
    );
  }
}

class RenderSearchableList extends StatelessWidget {
  final List<tbl_Avery_GiaoHang> dsAveryGiaoHang;
  final TextEditingController searchController;
  const RenderSearchableList({
    super.key,
    required this.dsAveryGiaoHang,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: SearchableList<tbl_Avery_GiaoHang>(
        searchTextController: searchController,
        itemBuilder: (item) => ActorItem(actor: item),
        // asyncListCallback: () async {
        //   return dsAveryGiaoHang;
        // },
        filter: (query) {
          return dsAveryGiaoHang.where((element) => element.IDVatLieu.contains(query.toLowerCase())).toList();
        },
        // asyncListFilter: (query, list) {
        //   final filtered = dsAveryGiaoHang.where((element) {
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
        initialList: dsAveryGiaoHang,
      ),
    );
  }
}

class ActorItem extends StatelessWidget {
  final tbl_Avery_GiaoHang actor;

  const ActorItem({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    const color = Colors.black87;
    const double fontSize = 14;

    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => KhoNVL_ChiTietNhapXuat(
        //       maVatLieu: actor.maVatLieu,
        //       viTri: actor.viTri,
        //       kho: actor.kho,
        //     ),
        //   ),
        // );
      },
      child: Card(
        color: Colors.orange[50],
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          height: 105,
          child: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
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
                    child: SizedBox(
                      width: 60,
                      child: Image.asset('assets/images/warehouse06_64.png'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 100, child: Text('Mã Vật Liệu:', style: TextStyle(fontWeight: FontWeight.bold, color: color,),),),
                            Text(actor.IDVatLieu,style: const TextStyle(color: color,fontSize: fontSize,),),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 100,
                              child: Text(
                                'Ngày Giao:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                            ),
                            Text(
                              actor.RequestTime,
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
                                'Item:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                            ),
                            Text(
                              actor.Item.toString(),
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
                              actor.RequestedQuantity.toString(),
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
                          builder: (context) => KhoNVL_PhieuNhap(tb: actor,),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 60,
                      child: Image.asset('assets/images/import01_64.png'),
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