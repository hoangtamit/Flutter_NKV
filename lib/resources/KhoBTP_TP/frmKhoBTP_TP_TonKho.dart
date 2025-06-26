import 'package:flutter/material.dart';
// import 'package:searchable_listview/searchable_listview.dart';
import '../../api/KhoBTP_TP/KhoBTP_TP_api.dart';
import '../../model/KhoBTP_TP/KhoBTP_TP_TonKho.dart';
import '../../utilities/values/theme.dart';
import 'package:searchable_listview/resources/arrays.dart';
import 'package:searchable_listview/searchable_listview.dart';
import '../../utilities/values/colors.dart';
import '../KhoNVL/kiemketonkho.dart';
import 'frmKhoBTP_TP_ChiTietNhapXuat.dart';
import 'frmKhoBTP_TP_KiemKeTonKho.dart';
class frmKhoBTP_TP_TonKho extends StatefulWidget {
  const frmKhoBTP_TP_TonKho({super.key});

  @override
  _frmKhoBTP_TP_TonKhoState createState() => _frmKhoBTP_TP_TonKhoState();
}

class _frmKhoBTP_TP_TonKhoState extends State<frmKhoBTP_TP_TonKho> {
  List<KhoBTP_TP_TonKho> dsTonKho = [];
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
        title: const Text('Tồn Kho BTP_TP '),
        centerTitle: true,
        backgroundColor:primaryColor,
      ),
      body: FutureBuilder<List<KhoBTP_TP_TonKho>>(
        future: KhoBTP_TPApi.TonKhoBTP_TP_ViTri_KhachHang_Lo(),
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
  final List<KhoBTP_TP_TonKho> dsTonKho;
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
      child: SearchableList<KhoBTP_TP_TonKho>(
        searchTextController: searchController,
        itemBuilder: (item) => ActorItem(actor: item),
        // asyncListCallback: () async {
        //   return dsTonKho;
        // },
        filter: (query) {
          return dsTonKho.where((element) => element.MaSanPham!.contains(query.toLowerCase())).toList();
        },
        // asyncListFilter: (query, list) {
        //   final filtered = dsTonKho.where((element) {
        //     return  element.MaSanPham.contains(query);
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
  final KhoBTP_TP_TonKho actor;

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
      //       builder: (context) => KhoBTP_TP_ChiTietNhapXuat(
      //         MaSanPham: actor.MaSanPham,
      //         viTri: actor.ViTri,
      //         kho: actor.Kho,
      //       ),
      //     ),
      //   );
      // },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0,4,0,4),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black38, // Màu viền
              width: 0.5,           // Độ dày viền
            ),
            borderRadius: BorderRadius.circular(8), // Bo góc nếu cần
          ),
          height: 105,
          child: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => frmKhoBTP_TP_ChiTietNhapXuat(
                            maSanPham: actor.MaSanPham!,
                            viTri: actor.ViTri!,
                            kho: actor.Kho!,lo:actor.Lo!,
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 60,
                      child: Image.asset('assets/images/checklist-64.png'),
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
                            const SizedBox(
                              width: 105,
                              child: Text(
                                'Mã Sản Phẩm:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                            ),
                            Text(
                              actor.MaSanPham!,
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
                                'Vị Trí:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                            ),
                            Text(
                              actor.ViTri!,
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
                                'Quy Cách:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                            ),
                            Text(
                              actor.QuyCach!,
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
                                'Tồn Cuối Kỳ:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                            ),
                            Text(
                              actor.toncuoiky.toString(),
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
                          builder: (context) => frmKhoBTP_TP_KiemKeTonKho(
                            MaSanPham: actor.MaSanPham,
                            ViTri: actor.ViTri,
                            Kho: actor.Kho,Lo:actor.Lo,
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 60,
                      child: Image.asset('assets/images/move03_64.png'),
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