import 'package:flutter/material.dart';
import '../../utilities/values/format.dart';
import '../../api/KhoBTP_TP/KhoBTP_TP_api.dart';
import '../../model/KhoBTP_TP/KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat.dart';
import '../../utilities/fDateTime.dart';
import '../../utilities/values/theme.dart';
import 'package:searchable_listview/searchable_listview.dart';
import '../../utilities/values/colors.dart';
import 'frmKhoBTP_TP_ChiTietXuat.dart';

class frmKhoBTP_TP_Xuat extends StatefulWidget {
  const frmKhoBTP_TP_Xuat({super.key});
  @override
  _frmKhoBTP_TP_XuatState createState() => _frmKhoBTP_TP_XuatState();
}

class _frmKhoBTP_TP_XuatState extends State<frmKhoBTP_TP_Xuat> {
  List<KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat> dsTonKho = [];
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
        title: const Text('Danh Sách Xuất Kho'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {}),
          ),
        ],
        backgroundColor:primaryColor,
      ),
      body: FutureBuilder<List<KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat>>(
        future: KhoBTP_TPApi.KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat_V2(),
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
  final List<KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat> dsTonKho;
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
      child: SearchableList<KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat>(
        searchTextController: searchController,
        itemBuilder: (item) => ActorItem(actor: item),
        // asyncListCallback: () async {
        //   return dsTonKho;
        // },
        filter: (query) {
          return dsTonKho.where((element) => element.MaPhieu!.contains(query.toLowerCase())).toList();
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
  final KhoBTP_TP_GroupByMaPhieu_GetIDKhuVuc_GetXuat actor;

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
      //       builder: (context) => KhoBTP_TP_ChiTietXuatXuat(
      //         maVatLieu: actor.maVatLieu,
      //         viTri: actor.viTri,
      //         kho: actor.kho,
      //       ),
      //     ),
      //   );
      // },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black38, // Màu viền
              width: 0.5,           // Độ dày viền
            ),
            borderRadius: BorderRadius.circular(8), // Bo góc nếu cần
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          //height: 120,
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
                        Row(
                          children: [
                            const SizedBox(
                              width: 100,
                              child: Text(
                                'Ngày Nhập:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                            ),
                            Text(
                              fDateTime.DD_MM_YYYY(actor.Ngay.toString()),
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
                                'Mã Phiếu:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                            ),
                            Text(
                              actor.MaPhieu.toString(),
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
                              formatNumber(actor.TongSoLuong),
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
                              actor.SoLuongSanPham.toString(),
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
                              actor.NhanVien.toString(),
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
                          builder: (context) => frmKhoBTP_TP_ChiTietXuat(tb: actor,),
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