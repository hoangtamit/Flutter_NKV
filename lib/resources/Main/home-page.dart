import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../utilities/CenterScreen.dart';
import '../../utilities/values/colors.dart';

const double cardMargin = 8.0;
const double cardPadding = 16.0;
const double kpiCardHeight = 140.0;
const double chartHeight = 200.0;
const double titleFontSize = 24.0;
const double kpiFontSize = 20.0;
const double labelFontSize = 16.0;
const double orderListHeight = 300.0;

// Mô hình dữ liệu đơn hàng
class Order {
  final String orderId;
  final String customerName;
  final int quantity;
  final String exportTime;

  const Order({
    required this.orderId,
    required this.customerName,
    required this.quantity,
    required this.exportTime,
  });
}

class HomePage extends StatelessWidget {
  HomePage({super.key});
// Dữ liệu giả lập: Số lượng đơn hàng trong 7 ngày gần nhất
  final List<double> orderData = [50, 70, 60, 90, 80, 100, 120];
  final List<String> days = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];

// Dữ liệu giả lập: Danh sách đơn hàng hôm nay sẽ xuất
  final List<Order> todayOrders = const [
    Order(
      orderId: 'DH001',
      customerName: 'Công ty ABC',
      quantity: 50,
      exportTime: '14:00',
    ),
    Order(
      orderId: 'DH002',
      customerName: 'Công ty XYZ',
      quantity: 30,
      exportTime: '15:30',
    ),
    Order(
      orderId: 'DH003',
      customerName: 'Công ty DEF',
      quantity: 70,
      exportTime: '16:00',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CenterScreen(
        title: 'Báo Cáo Thống Kê Hằng Ngày',
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  //padding: EdgeInsets.all(8.0),
                  //color: Colors.black12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(onPressed: () {}, child: Text('NGÀY', style: TextStyle(color: Colors.black))),
                      //ElevatedButton(onPressed: () {}, child: Text('TUẦN', style: TextStyle(color: Colors.black))),
                      ElevatedButton(onPressed: () {}, child: Text('THÁNG', style: TextStyle(color: Colors.black))),
                      ElevatedButton(onPressed: () {}, child: Text('NĂM', style: TextStyle(color: Colors.black))),
                    ],
                  ),
                ),
                // SizedBox(height: 20),
                // Center(child: Stack(
                //     alignment: Alignment.center,
                //     children: [
                //       SizedBox(
                //         width: 200,
                //         height: 200,
                //         child: CircularProgressIndicator(
                //           value: 0.45,
                //           strokeWidth: 10,
                //           color: greenOpacity3,
                //           backgroundColor: Colors.grey[300],
                //         ),
                //       ),
                //       Column(
                //         children: [
                //           //Text('Đã hấp thụ >', style: TextStyle(fontSize: 16)),
                //           Text('96%', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                //           Text('Đã hoàn thành', style: TextStyle(color: Colors.green, fontSize: 16)),
                //         ],
                //       ),
                //     ],
                //   ),),
                SizedBox(height: 20),
                Center(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        width: 260,
                        height: 260,
                        child: CustomPaint(
                          painter: SemicircleProgressPainter(
                            progress: 0.8,
                            strokeWidth: 15,
                            progressColor: greenColor,
                            backgroundColor: Colors.grey[300]!,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Text('Hoàn Thành >', style: TextStyle(fontSize: 16)),
                          Text('96%', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                          Text('Đã hoàn thành', style: TextStyle(color: Colors.green, fontSize: 16)),
                          Text('', style: TextStyle(fontSize: 80)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black38, // Màu viền
                                width: 0.5,           // Độ dày viền
                              ),
                              borderRadius: BorderRadius.circular(8), // Bo góc nếu cần
                            ),
                            width: 150,
                            height: 80,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(

                                children: [
                                  Text('Tổng đơn hàng'),
                                  Text('13 đơn hàng', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black38, // Màu viền
                                width: 0.5,           // Độ dày viền
                              ),
                              borderRadius: BorderRadius.circular(8), // Bo góc nếu cần
                            ),
                            width: 150,
                            height: 80,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text('Chưa hoàn thành'),
                                  Text('67%', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(cardPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Đơn hàng trong 7 ngày gần nhất',
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: chartHeight,
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              maxY: 150,
                              barTouchData: BarTouchData(enabled: false),
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        days[value.toInt()],
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: labelFontSize,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 40,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toInt().toString(),
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: labelFontSize,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              borderData: FlBorderData(show: false),
                              gridData: const FlGridData(show: true),
                              barGroups: orderData.asMap().entries.map((entry) {
                                return BarChartGroupData(
                                  x: entry.key,
                                  barRods: [
                                    BarChartRodData(
                                      toY: entry.value,
                                      color: greenColor,
                                      width: 16,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(cardPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Đơn hàng hôm nay sẽ xuất hàng',
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: orderListHeight,
                          child: ListView.builder(
                            itemCount: todayOrders.length,
                            itemBuilder: (context, index) {
                              final order = todayOrders[index];
                              return Card(
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.local_shipping,
                                    color: primaryColor,
                                    size: 24,
                                  ),
                                  title: Text(
                                    'Mã đơn: ${order.orderId}',
                                    style: const TextStyle(
                                      fontSize: labelFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Khách hàng: ${order.customerName}'),
                                      Text('Số lượng: ${order.quantity}'),
                                      Text('Thời gian xuất: ${order.exportTime}'),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  Widget _buildKpiCard(String title, String value, IconData icon) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          height: kpiCardHeight,
          padding: const EdgeInsets.all(cardPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: primaryColor, size: 24),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: kpiFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: labelFontSize,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class SemicircleProgressPainter extends CustomPainter {
  final double progress; // Progress value (0.0 to 1.0)
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;

  SemicircleProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.progressColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;
    // Paint for the background arc
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Paint for the progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw background semicircle (from 180° to 360°, i.e., bottom half)
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -3.3, // Start at 180° (bottom)
      3.5, // Sweep 180° (half circle)
      false,
      backgroundPaint,
    );

    // Draw progress semicircle
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.3, // Start at 180°
      3.5 * progress, // Sweep based on progress
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}