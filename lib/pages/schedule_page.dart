import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final TextEditingController _amountController = TextEditingController(text: '1');
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _postalController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _volumeSize = 'Per Liter';
  int _amount = 1;

  Widget _buildSemiTransparentTextField({
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.4),
        hoverColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int income = _amount * 10000;
    final int adminFee = 2500;
    final int totalIncome = income - adminFee;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 4),
            const Text('Schedule', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Schedule for pick up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('Fill all the field!', style: TextStyle(color: Colors.black54)),
              const SizedBox(height: 20),

              const Text('Volume Size', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              SizedBox(
                width: 140,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _volumeSize = 'Per Liter';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Per Liter'),
                ),
              ),

              const SizedBox(height: 20),
              const Text('Amount', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              SizedBox(
                width: 140,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        setState(() {
                          if (_amount > 1) _amount--;
                        });
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: TextEditingController(text: _amount.toString()),
                        onChanged: (value) {
                          setState(() {
                            _amount = int.tryParse(value) ?? 1;
                          });
                        },
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.4),
                          hoverColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () {
                        setState(() {
                          _amount++;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text('Full Address', style: TextStyle(fontWeight: FontWeight.bold)),
              _buildSemiTransparentTextField(controller: _addressController),

              const SizedBox(height: 8),
              const Text('City', style: TextStyle(fontWeight: FontWeight.bold)),
              _buildSemiTransparentTextField(controller: _cityController),

              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Province', style: TextStyle(fontWeight: FontWeight.bold)),
                        _buildSemiTransparentTextField(controller: _provinceController),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Postal Code', style: TextStyle(fontWeight: FontWeight.bold)),
                        _buildSemiTransparentTextField(
                          controller: _postalController,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              const Text('Phone Number', style: TextStyle(fontWeight: FontWeight.bold)),
              _buildSemiTransparentTextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 20),
              const Text('Pick Up Time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Day', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: _pickDate,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(4)),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 18),
                                const SizedBox(width: 8),
                                Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Time', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: _pickTime,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(4)),
                            child: Row(
                              children: [
                                const Icon(Icons.access_time, size: 18),
                                const SizedBox(width: 8),
                                Text('${_selectedTime.format(context)} WIB'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Text('Estimated Income', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Rp $totalIncome, admin fee Rp 2.500', style: const TextStyle(color: Colors.grey, fontSize: 11)),

              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: const Text('Order Now!', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _selectedTime);
    if (picked != null) setState(() => _selectedTime = picked);
  }

  Future<void> _handleSubmit() async {
    if (_addressController.text.isEmpty ||
        _cityController.text.isEmpty ||
        _provinceController.text.isEmpty ||
        _postalController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please complete all the fields.')));
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You are not logged in.')));
        return;
      }

      final total = _amount * 10000 - 2500;
      final uid = user.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).collection('transactions').add({
        'name': _volumeSize,
        'amount': total,
        'date': DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          _selectedTime.hour,
          _selectedTime.minute,
        ),
        'category': 'Income',
        'address': _addressController.text,
        'city': _cityController.text,
        'province': _provinceController.text,
        'postalCode': _postalController.text,
        'phone': _phoneController.text,
      });

      _showReceipt(total);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to submit: $e')));
    }
  }

  void _showReceipt(int total) {
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
            Text('$_amount Liter', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Summary', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 16)),
            const SizedBox(height: 6),
            Text('Pick-up address:\n${_addressController.text}, ${_cityController.text}', style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            Text(
              'Will be taken on:\n${DateFormat('EEEE, dd MMMM yyyy').format(_selectedDate)} ${_selectedTime.format(context)} WIB',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text('Total Amount: $_amount Liter', style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 16),
            const Text('Total Paid', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
            Text('Total: Rp $total', style: const TextStyle(color: Colors.white)),
            const Text('Admin Fee: Rp 2500', style: TextStyle(color: Colors.white)),
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
              child: const Text('Close', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
