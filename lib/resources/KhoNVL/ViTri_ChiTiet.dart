import 'package:flutter/material.dart';
import 'package:nkv/model/KhoNVL/tbl_ViTri.dart';

// Hàm hiển thị popup danh sách vị trí kho
void ShowViTriKhoDialog(BuildContext context, List<tbl_ViTri> dsViTri, Function(String) onViTriSelected) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Danh sách vị trí kho'),
        content: Container(
          width: double.maxFinite,
          height: 300,
          child: ListView.builder(
            itemCount: dsViTri.length,
            itemBuilder: (context, index) {
              final viTri = dsViTri[index].ViTri;
              return ListTile(
                title: Text(viTri),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Loại Hàng: ${dsViTri[index].LoaiHang}'),
                  ],
                ),
                onTap: () {
                  onViTriSelected(viTri);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Hủy'),
          ),
        ],
      );
    },
  );
}

