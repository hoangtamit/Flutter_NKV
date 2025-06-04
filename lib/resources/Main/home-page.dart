import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../utilities/CenterScreen.dart';
// Hằng số cho màu sắc, kích thước, và khoảng cách
const Color primaryColor = Colors.orange;
const double cardMargin = 16.0;
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
            padding: const EdgeInsets.all(cardMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
// KPIs
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildKpiCard('Tổng đơn hàng', '350', Icons.list),
                    _buildKpiCard('Đơn hoàn thành', '300', Icons.check_circle),
                    _buildKpiCard('Đơn bị hủy', '50', Icons.cancel),
                  ],
                ),
                const SizedBox(height: cardMargin),
// Biểu đồ đơn hàng theo ngày
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
                                      color: primaryColor,
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
                const SizedBox(height: cardMargin),
// Danh sách đơn hàng hôm nay sẽ xuất
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