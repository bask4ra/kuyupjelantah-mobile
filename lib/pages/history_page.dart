import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class WeeklyIncomeSummaryPage extends StatefulWidget {
  const WeeklyIncomeSummaryPage({super.key});

  @override
  State<WeeklyIncomeSummaryPage> createState() => _WeeklyIncomeSummaryPageState();
}

class _WeeklyIncomeSummaryPageState extends State<WeeklyIncomeSummaryPage> {
  final PageController _pageController = PageController();

  final List<List<IncomeData>> _weeklyData = [
    [
      IncomeData('Sen 19 Mei', 0, 'Income'),
      IncomeData('Sel 20', 0, 'Income'),
      IncomeData('Rab 21', 10400, 'Income'),
      IncomeData('Kam 22', 4400, 'Income'),
      IncomeData('Jum 23', 16800, 'Income'),
      IncomeData('Sab 24', 18000, 'Income'),
      IncomeData('Min 25', 0, 'Income'),
    ],
    [
      IncomeData('Sen 26', 10000, 'Income'),
      IncomeData('Sel 27', 8000, 'Income'),
      IncomeData('Rab 28', 12000, 'Income'),
      IncomeData('Kam 29', 9000, 'Income'),
      IncomeData('Jum 30', 4000, 'Income'),
      IncomeData('Sab 31', 5000, 'Income'),
      IncomeData('Min 1 Jun', 0, 'Income'),
    ],
    [
      IncomeData('Sen 2 Jun', 10000, 'Income'),
      IncomeData('Sel 3', 8000, 'Income'),
      IncomeData('Rab 4', 12000, 'Income'),
      IncomeData('Kam 5', 9000, 'Income'),
      IncomeData('Jum 6', 4000, 'Income'),
      IncomeData('Sab 7', 5000, 'Income'),
      IncomeData('Min 8', 0, 'Income'),
    ]
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'History',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildWeekSelector(),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemCount: _weeklyData.length,
              itemBuilder: (context, index) => _buildWeeklySummary(_weeklyData[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekSelector() {
    final weekRanges = ['Mei 19 - 25', 'Mei 26 - Jun 1', 'Jun 2 - 8'];
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weekRanges.length,
        itemBuilder: (context, index) {
          final selected = index == _currentPage;
          return GestureDetector(
            onTap: () => _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? Colors.orange : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  weekRanges[index],
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWeeklySummary(List<IncomeData> data) {
    final total = data.fold<int>(0, (sum, item) => sum + item.amount);
    final totalOrders = data.where((item) => item.amount > 0).length;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text('Total Pendapatan yang Diterima', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Rp${total.toString()}',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text('$totalOrders Pesanan Selesai', style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 32),
            const Text('Grafik Pendapatan yang Diterima', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 8,
                            child: Text(
                              NumberFormat.compact(locale: 'id_ID').format(value),
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          final index = value.toInt();
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 6,
                            child: Text(
                              index >= 0 && index < data.length ? data[index].day.substring(0, 3) : '',
                              style: const TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(
                    data.length,
                        (index) => BarChartGroupData(x: index, barRods: [
                      BarChartRodData(toY: data[index].amount.toDouble(), color: Colors.orange, width: 16)
                    ]),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
                'Transaction Detail',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                )
            ),
            const SizedBox(height: 8),
            ...data.where((d) => d.amount > 0).map((d) => GestureDetector(
              onTap: () {
                print('Klik transaksi: ${d.day}');
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.attach_money, color: Colors.orange),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(d.day, style: const TextStyle(fontSize: 14)),
                            Text(d.category, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                    Text('Rp${d.amount}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class IncomeData {
  final String day;
  final int amount;
  final String category;

  IncomeData(this.day, this.amount, this.category);
}
