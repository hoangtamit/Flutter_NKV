import 'package:flutter/material.dart';


class NutritionTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text('Dinh dưỡng'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () {}, child: Text('NGÀY')),
              ElevatedButton(onPressed: () {}, child: Text('7 NGÀY')),
              ElevatedButton(onPressed: () {}, child: Text('THÁNG')),
              ElevatedButton(onPressed: () {}, child: Text('NĂM')),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_ios, size: 16),
                Text('Hôm nay'),
                Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: 0.35,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey[300],
                  ),
                ),
                Column(
                  children: [
                    Text('Đã hấp thụ >', style: TextStyle(fontSize: 16)),
                    Text('96 kcal', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                    Text('Đủ năng lượng', style: TextStyle(color: Colors.green, fontSize: 16)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Icon(Icons.local_dining),
                        Text('Còn lại >'),
                        Text('1,310 kcal', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Icon(Icons.star),
                        Text('Điểm dinh dưỡng >'),
                        Text('67%', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Icon(Icons.favorite),
                        Text('6/105 g'),
                        Text('Protein >'),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Icon(Icons.local_dining),
                        Text('12/123 g'),
                        Text('Tinh bột >'),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Icon(Icons.local_drink),
                        Text('2/55 g'),
                        Text('Chất béo >'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: Text('Xem tất cả các giá trị dinh dưỡng')),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Theo dõi nhận ăn', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Icon(Icons.arrow_drop_down),
              ],
            ),
            Text('Bắt đầu nhận ăn tiếp theo sau 4g 10p 21giây'),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: Text('Nhật ký thức')),
          ],
        ),
      ),
    );
  }
}