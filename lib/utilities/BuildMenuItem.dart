import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
Widget buildSection({
  required String title,
  required Color color,
  required List<Widget> items,
}) {
  return Card(
    elevation: 6,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16,0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề cụm
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8), // Bo góc nếu cần
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // GridView cho các mục
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            crossAxisSpacing: 12,
            //mainAxisSpacing: 12,
            childAspectRatio: 1, // Tỷ lệ chiều rộng/chiều cao
            children: items,
          ),
        ],
      ),
    ),
  );
}
Widget buildSection2({
  required String title,
  required Color color,
  required List<Widget> items,
}) {
  return Card(
    elevation: 6,
    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16,0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề cụm
          Container(
            decoration: BoxDecoration(
              color: color,
              // border: Border.all(
              //   color: Colors.black38, // Màu viền
              //   width: 0.5,           // Độ dày viền
              // ),
              borderRadius: BorderRadius.circular(8), // Bo góc nếu cần
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // GridView cho các mục
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            //physics: ScrollPhysics() ,//const NeverScrollableScrollView(),
            crossAxisSpacing: 12,
            //mainAxisSpacing: 12,
            childAspectRatio: 1, // Tỷ lệ chiều rộng/chiều cao
            children: items,
          ),
        ],
      ),
    ),
  );
}

Widget buildMenuItem(
    BuildContext context, {
      required String title,
      required String icon,
      required VoidCallback onTap,
    }) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 50,
              height: 50,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ),
  );
}