import 'package:flutter/material.dart';
import '../../api/ThietKe/khogiayin_api.dart';
import '../../widgets/widget_text.dart';


class frmKhoGiayIn2 extends StatefulWidget {
  const frmKhoGiayIn2({super.key});
  @override
  frmKhoGiayIn_State2 createState() => frmKhoGiayIn_State2();
}
class frmKhoGiayIn_State2 extends State<frmKhoGiayIn2> {

  void iniState() {super.initState();}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: KhoGiayInApi.LoadData(),
          builder: (context, snapshot) {
            final screenWidth = MediaQuery.of(context).size.width;
            var data = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text('Please wait its loading...'));
            }
            else {
              return
                Padding(padding: EdgeInsets.fromLTRB(0,30,0,0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      dataRowHeight: 60,
                      //horizontalMargin: 30,
                      //dataRowMaxHeight: 50,
                      //border: TableBorder.all(width: 1),
                      // showCheckboxColumn: true,
                      // showBottomBorder: true,
                      // checkboxHorizontalMargin: 10,
                      columns: const <DataColumn>[
                        DataColumn(label: Text('Giấy Lớn'),),
                        DataColumn(label: Text('Cắt Giấy'),),
                        DataColumn(label: Text('Khổ Giấy In'),),
                      ],
                      rows: List<DataRow>.generate(data!.length, (int index) =>
                          DataRow(
                            // color: WidgetStateProperty.resolveWith<Color?>(
                            //         (Set<WidgetState> states) {
                            //       // All rows will have the same selected color.
                            //       if (states.contains(MaterialState.selected)) {
                            //         return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                            //       }
                            //       // Even rows will have a grey color.
                            //       if (index.isEven) {
                            //         return Colors.grey.withOpacity(0.3);
                            //       }
                            //       return null; // Use default value for other states and odd rows.
                            //     }),
                            cells: <DataCell>[
                              // DataCell(
                              //     SizedBox(width: 50,
                              //       child: ClipRRect(
                              //         borderRadius: BorderRadius.circular(50),
                              //         child: Image.asset('assets/images/no-photo-32.png') ),
                              //     ),),
                              DataCell(
                                SizedBox(
                                  width: screenWidth * 0.2, // 30% màn hình
                                  child: widgetText.txt01(data[index].giayLon.toString()),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: screenWidth * 0.2, // 30% màn hình
                                  child: widgetText.txt01(data[index].catGiay.toString()),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: screenWidth * 0.4, // 30% màn hình
                                  child: widgetText.txt01(data[index].khoGiayIn.toString()),
                                ),
                              ),
                            ],
                            selected: false, //selected[index],
                            // onSelectChanged: (bool? value) {
                            //   setState(() {
                            //     selected[index] = value!;
                            //   });
                            // },
                          ),
                      ),
                    ),
                  ),
                ),
              );
            }
          }
      ),
    );
  }
}
class DataTableExampleApp extends StatelessWidget {
  const DataTableExampleApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('DataTable Sample')),
        body: const DataTableExample(),
      ),
    );
  }
}
class DataTableExample extends StatelessWidget {
  const DataTableExample({super.key});
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Name',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Age',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Role',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Sarah')),
            DataCell(Text('19')),
            DataCell(Text('Student')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Janine')),
            DataCell(Text('43')),
            DataCell(Text('Professor')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('William')),
            DataCell(Text('27')),
            DataCell(Text('Associate Professor')),
          ],
        ),
      ],
    );
  }
}