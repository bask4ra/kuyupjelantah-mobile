import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<TransactionData> _transactions = [];
  bool _isLoading = true;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .orderBy('date')
        .get();

    setState(() {
      _transactions = snapshot.docs.map((d) {
        final data = d.data() as Map<String, dynamic>;
        final ts = (data['date'] as Timestamp).toDate();
        return TransactionData(
          day: DateFormat('EEE d MMM').format(ts),
          amount: (data['amount'] as num).toInt(),
          category: data['category'] ?? 'Income',
          date: ts,
          address: data['address'],
          city: data['city'],
          province: data['province'],
          postalCode: data['postalCode'],
          phone: data['phone'],
        );
      }).toList();
      _isLoading = false;
    });
  }

  List<TransactionData> get _filteredTransactions {
    if (_startDate == null || _endDate == null) return _transactions;
    return _transactions.where((t) =>
    t.date.isAfter(_startDate!.subtract(const Duration(days: 1))) &&
        t.date.isBefore(_endDate!.add(const Duration(days: 1)))
    ).toList();
  }

  Future<void> _selectDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime(2100, 12, 31),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

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
        title: const Text('History', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range, color: Colors.black),
            onPressed: _selectDateRange,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildWeeklySummary(_filteredTransactions),
    );
  }

  Widget _buildWeeklySummary(List<TransactionData> data) {
    final total = data.fold<int>(0, (sum, item) => sum + item.amount);
    final totalOrders = data.where((item) => item.amount > 0).length;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Total Pendapatan', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Rp$total', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text('$totalOrders Pesanan Selesai', style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 32),
            const Text('Grafik Pendapatan', style: TextStyle(fontSize: 16)),
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
                            child: Text(NumberFormat.compact(locale: 'id_ID').format(value), style: const TextStyle(fontSize: 7)),
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
                      BarChartRodData(toY: data[index].amount.toDouble(), color: Colors.orange, width: 16),
                    ]),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Transaction Detail', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            ...data.where((d) => d.amount > 0).map((d) => GestureDetector(
              onTap: () => _showReceipt(d),
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
                    Text('Rp${d.amount}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  void _showReceipt(TransactionData d) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xff5D4A66),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(
          children: [
            const Text('Number of items to be taken', style: TextStyle(color: Colors.white, fontSize: 14)),
            const SizedBox(height: 10),
            Image.asset('assets/images/water-bottle.png', height: 60),
            const SizedBox(height: 8),
            Text('${d.amount} Liter', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Summary', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 16)),
            const SizedBox(height: 6),
            Text('Pick-up address:\n${d.address}, ${d.city}', style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            Text('Will be taken on:\n${DateFormat('EEEE, dd MMMM yyyy').format(d.date)}', style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            Text('Total Amount: ${d.amount} Liter', style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 16),
            const Text('Total Paid', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
            Text('Total: Rp${d.amount}', style: const TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Done', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionData {
  final String day;
  final int amount;
  final String category;
  final DateTime date;
  final String address;
  final String city;
  final String province;
  final String postalCode;
  final String phone;

  TransactionData({
    required this.day,
    required this.amount,
    required this.category,
    required this.date,
    required this.address,
    required this.city,
    required this.province,
    required this.postalCode,
    required this.phone,
  });
}