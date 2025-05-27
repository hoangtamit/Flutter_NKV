import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qlsx/api/ThietKe/khogiayin_api.dart';
import '../../api/NghiepVu/donsanxuat_api.dart';
import 'package:searchable_listview/searchable_listview.dart';
import '../../model/ThietKe/tbKhoGiayIn.dart';

List<tbKhoGiayIn> users = [];
class frmKhoGiayIn extends StatefulWidget {
  const frmKhoGiayIn({Key? key}) : super(key: key);
  @override
  frmKhoGiayIn_State createState() => frmKhoGiayIn_State();
}
class frmKhoGiayIn_State extends State<frmKhoGiayIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: KhoGiayInApi.LoadData(),
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
        DonSanXuatApi.ExportPdf(actor.chiTietGiay.toString()).then((value)
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
