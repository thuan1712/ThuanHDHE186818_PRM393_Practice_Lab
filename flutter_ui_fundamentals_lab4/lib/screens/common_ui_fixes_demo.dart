import 'package:flutter/material.dart';

class CommonUiFixesDemo extends StatefulWidget {
  const CommonUiFixesDemo({super.key});

  @override
  State<CommonUiFixesDemo> createState() => _CommonUiFixesDemoState();
}

class _CommonUiFixesDemoState extends State<CommonUiFixesDemo> {
  int _stateCounter = 0;
  DateTime? _pickedDate;

  final List<String> _movies = const [
    'Movie A',
    'Movie B',
    'Movie C',
    'Movie D',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5 – Common UI Fixes'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // FIX 1: ListView inside Column using Expanded
            // ==========================================
            const Text(
              'Correct ListView inside Column using Expanded',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.blue.withOpacity(0.1),
                    child: const Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Fixed: Bọc ListView trong Expanded để tránh lỗi unbounded height.',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _movies.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.movie, color: Colors.blueGrey),
                          title: Text(_movies[index]),
                          dense: true,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // FIX 2: Overflow in small screens using SingleChildScrollView
            // ==========================================
            const Text(
              'Fix 2: Tránh tràn màn hình bằng SingleChildScrollView',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    const Icon(Icons.screen_rotation, color: Colors.orange),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Toàn bộ màn hình này đã được bọc trong SingleChildScrollView để chống lỗi tràn viền (A RenderFlex overflowed by ... pixels / sọc vàng đen).',
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // FIX 3: State update issue by adding setState()
            // ==========================================
            const Text(
              'Fix 3: Cập nhật giao diện với setState()',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Giá trị đếm: $_stateCounter',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Gọi setState để báo Flutter vẽ lại (re-render) widget
                        setState(() {
                          _stateCounter++;
                        });
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Tăng (setState)'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // FIX 4: DatePicker BuildContext error fix
            // ==========================================
            const Text(
              'Fix 4: Gọi DatePicker với BuildContext hợp lệ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        _pickedDate == null
                            ? 'Chưa chọn ngày'
                            : 'Đã chọn: ${_pickedDate!.day}/${_pickedDate!.month}/${_pickedDate!.year}',
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    Builder(
                      builder: (buttonContext) {
                        return OutlinedButton.icon(
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: buttonContext,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2030),
                            );
                            if (picked != null) {
                              setState(() {
                                _pickedDate = picked;
                              });
                            }
                          },
                          icon: const Icon(Icons.date_range),
                          label: const Text('Mở Lịch'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
