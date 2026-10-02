import 'package:flutter/material.dart';

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  double _rating = 50.0;
  bool _isActive = true;
  String _selectedGenre = 'Action';
  DateTime? _selectedDate;

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 2 – Input Controls Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Rating (Slider)
            const Text(
              'Rating (Slider)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _rating,
              min: 0,
              max: 100,
              divisions: 100,
              label: _rating.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _rating = value;
                });
              },
            ),
            Text(
              'Current value: ${_rating.round()}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // 2. Active (Switch)
            const Text(
              'Active (Switch)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Is movie active?'),
                Switch(
                  value: _isActive,
                  onChanged: (bool value) {
                    setState(() {
                      _isActive = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 3. Genre (RadioListTile)
            const Text(
              'Genre (RadioListTile)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            RadioListTile<String>(
              title: const Text('Action'),
              value: 'Action',
              groupValue: _selectedGenre,
              contentPadding: EdgeInsets.zero,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    _selectedGenre = value;
                  });
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('Comedy'),
              value: 'Comedy',
              groupValue: _selectedGenre,
              contentPadding: EdgeInsets.zero,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    _selectedGenre = value;
                  });
                }
              },
            ),
            Text(
              'Selected genre: $_selectedGenre',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // 4. DatePicker Button
            Center(
              child: Column(
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _pickDate(context),
                    icon: const Icon(Icons.calendar_month),
                    label: const Text('Open Date Picker'),
                  ),
                  const SizedBox(height: 8),
                  if (_selectedDate != null)
                    Text(
                      'Selected Date: ${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
