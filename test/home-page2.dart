import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// Hằng số cho màu sắc, kích thước, và khoảng cách
const Color primaryColor = Colors.orange;
const double cardMargin = 16.0;
const double cardPadding = 16.0;
const double kpiCardHeight = 100.0;
const double chartHeight = 200.0;
const double titleFontSize = 24.0;
const double kpiFontSize = 20.0;
const double labelFontSize = 16.0;

class HomePage extends StatelessWidget {
  HomePage({super.key});

// Dữ liệu giả lập: Số lượng đơn hàng trong 7 ngày gần nhất
  final List<double> orderData = [50, 70, 60, 90, 80, 100, 120];
  final List<String> days = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thống kê đơn hàng hằng ngày'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
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
            ],
          ),
        ),
      ),
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
              // Text(
              //   title,
              //   textAlign: TextAlign.center,
              //   style: const TextStyle(
              //     fontSize: labelFontSize,
              //     color: Colors.black54,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
