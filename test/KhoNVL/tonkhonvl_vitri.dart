import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';
import '../../api/KhoNVL/KhoNVL_api.dart';
import '../../model/KhoNVL/KhoNVL_TonKho.dart';

List<KhoNVL_TonKho> dsTonKho = [];
class TonKho_ViTri_DanhSach extends StatefulWidget {
  const TonKho_ViTri_DanhSach({Key? key}) : super(key: key);
  @override
  _TonKho_ViTri_DanhSachState createState() => _TonKho_ViTri_DanhSachState();
}
class _TonKho_ViTri_DanhSachState extends State<TonKho_ViTri_DanhSach> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: KhoNVLApi.TonKhoNVL_ViTri(),
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
          dsTonKho = data!;
          return const render();
        },
      ),
    );
  }
  Widget renderAsynchSearchableListview() {
    return Container(
      padding: const EdgeInsets.fromLTRB(5,0,5,5),
      child: SearchableList<KhoNVL_TonKho>.async(
        itemBuilder: (item) {
          return ActorItem(actor:item);
        },
        asyncListCallback: () async {
          await Future.delayed(const Duration(seconds: 1));
          return dsTonKho;
        },
        asyncListFilter: (query, list) {
          return dsTonKho.where((element) =>
              element.maVatLieu.contains(query)).toList();
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
        ),// itemBuilder: (KhoNVL_TonKho item) {  },// itemBuilder: (KhoNVL_TonKho item) {  },
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
      child: SearchableList<KhoNVL_TonKho>.async(
        itemBuilder: (item) {
          return ActorItem(actor: item);
        },
        asyncListCallback: () async {
          await Future.delayed(const Duration(seconds: 1));
          return dsTonKho;
        },
        asyncListFilter: (query, list) {
          return dsTonKho.where((element) =>
              element.maVatLieu.contains(query.toUpperCase())).toList();
        },
        // seperatorBuilder: (context, index) {
        //   return const Divider();
        // },
        //key: const TextStyle(fontSize: 16),
        emptyWidget: const EmptyView(),
        inputDecoration: InputDecoration(
          labelText: "Search Mã Vật Liệu",
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
  final KhoNVL_TonKho actor;

  const ActorItem({Key? key, required this.actor,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const _color = Colors.black87;
    bool isChecked = false;
    return  GestureDetector(

      onTap: (){
        //Navigator.push(context, MaterialPageRoute(builder: (context) => KiemKeTonKho(MaVatLieu:actor.maVatLieu.toString())));
        //Navigator.push(context, MaterialPageRoute(builder: (context) => KhoNVL_ChiTietNhapXuat(MaVatLieu:actor.maVatLieu.toString())));
      },
      child: Card(
        color: Colors.orange[50],
        child: Container(
          padding: const EdgeInsets.fromLTRB(0,5,0,5),
          height: 100,
          decoration: BoxDecoration(
            //color: Colors.black12,
            borderRadius: BorderRadius.circular(10),
          ),
          child:  Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => KhoNVL_ChiTietNhapXuat(MaVatLieu:actor.maVatLieu.toString())));
                    },
                    child:  SizedBox(
                        width: 60, child: Image.asset('assets/images/checklist-64.png')
                    ),
                  ),
                  const SizedBox(width: 5,),
                  GestureDetector(
                    onTap: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => KiemKeTonKho(MaVatLieu:actor.maVatLieu.toString(),ViTri:actor.viTri.toString(),Kho:actor.kho.toString())));
                    },
                    child: SizedBox(
                      //width: MediaQuery.sizeOf(context).width - 160,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width:100,
                                child: Text('Mã Vật Liệu: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _color,
                                  ),
                                ),
                              ),
                              Text(actor.maVatLieu.toString(),
                                style: const TextStyle(
                                  color: _color,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(width:100,
                                child: Text('Tồn Cuối Kỳ: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _color,
                                  ),
                                ),
                              ),
                              Text(actor.toncuoiky.toString(),
                                style: const TextStyle(
                                  color: _color,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(width:100,
                                child: Text('Vị Trí: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _color,
                                  ),
                                ),
                              ),
                              Text(actor.viTri.toString(),
                                style: const TextStyle(
                                  color: _color,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(width:100,
                                child: Text('Kiểm Kê: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _color,
                                  ),
                                ),
                              ),
                              Text(actor.soLuongKiemKe.toString(),
                                style: const TextStyle(
                                  color: _color,
                                  fontSize: 16,
                                ),
                              ),
                              // SizedBox(width:100,
                              //   child: Checkbox (
                              //     value: actor.isKiemKe,
                              //     onChanged: (bool? value) {},
                              //   ),
                              // )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                  onTap: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => KhoNVL_ChiTietNhapXuat(MaVatLieu:actor.maVatLieu.toString())));
                  },
                  child: Checkbox (
                    value: actor.isKiemKe,
                    onChanged: null,
                  )
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

