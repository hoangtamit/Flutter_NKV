import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';
import '../../api/KhoNVL/KhoNVL_api.dart';
import '../../model/KhoNVL/KhoNVL_TonKho.dart';
import 'chitietnhapxuat.dart';
import 'kiemketonkho.dart';

class TonKho_ViTri_DanhSach extends StatefulWidget {
  const TonKho_ViTri_DanhSach({super.key});

  @override
  _TonKho_ViTri_DanhSachState createState() => _TonKho_ViTri_DanhSachState();
}

class _TonKho_ViTri_DanhSachState extends State<TonKho_ViTri_DanhSach> {
  List<KhoNVL_TonKho> dsTonKho = [];
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
        title: const Text('Danh Sách Tồn Kho Theo Vị Trí'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder<List<KhoNVL_TonKho>>(
        future: KhoNVLApi.TonKhoNVL_ViTri(),
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
  final List<KhoNVL_TonKho> dsTonKho;
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
      child: SearchableList<KhoNVL_TonKho>.async(
        searchTextController: searchController,
        itemBuilder: (item) => ActorItem(actor: item),
        asyncListCallback: () async {
          return dsTonKho;
        },
        asyncListFilter: (query, list) {
          final normalizedQuery = query;//.toLowerCase().trim();
          print('Search query: $normalizedQuery');
          if (normalizedQuery.isEmpty) {
            print('Empty query, returning full list');
            return dsTonKho;
          }
          final filtered = dsTonKho.where((element) {
            final maVatLieu = element.maVatLieu;//.toLowerCase();
            // final viTri = element.viTri.toLowerCase();
            // final quyCach = element.quyCach.toLowerCase();
            // final kho = element.kho.toLowerCase();
            final matches = maVatLieu.contains(normalizedQuery)
                // ||                viTri.contains(normalizedQuery) ||
                // quyCach.contains(normalizedQuery) ||
                // kho.contains(normalizedQuery)
            ;
            if (matches) {
              print('Match found: ${element.maVatLieu}');
            }
            return matches;
          }).toList();
          print('Filtered ${filtered.length} items');
          return filtered;
        },
        emptyWidget: const EmptyView(),
        inputDecoration: InputDecoration(
          labelText: 'Tìm kiếm (Mã, Vị Trí, Quy Cách, Kho)',
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
      ),
    );
  }
}

class ActorItem extends StatelessWidget {
  final KhoNVL_TonKho actor;

  const ActorItem({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    const color = Colors.black87;
    const double fontSize = 14;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KhoNVL_ChiTietNhapXuat(
              maVatLieu: actor.maVatLieu,
              viTri: actor.viTri,
              kho: actor.kho,
            ),
          ),
        );
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KhoNVL_ChiTietNhapXuat(
                            maVatLieu: actor.maVatLieu,
                            viTri: actor.viTri,
                            kho: actor.kho,
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
                              width: 100,
                              child: Text(
                                'Mã Vật Liệu:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                            ),
                            Text(
                              actor.maVatLieu,
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
                              actor.viTri,
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
                              actor.quyCach,
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
                          builder: (context) => KiemKeTonKho(
                            MaVatLieu: actor.maVatLieu,
                            ViTri: actor.viTri,
                            Kho: actor.kho,
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