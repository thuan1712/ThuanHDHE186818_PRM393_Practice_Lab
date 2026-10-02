import 'package:flutter/material.dart';
import 'core_widgets_demo.dart';
import 'input_controls_demo.dart';
import 'layout_demo.dart';
import 'app_structure_theme_demo.dart';
import 'common_ui_fixes_demo.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const HomeScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> exercises = [
      {
        'title': 'Exercise 1 – Core Widgets Demo',
        'subtitle': 'Text, Image, Icon, Card, ListTile',
        'builder': (context) => const CoreWidgetsDemo(),
      },
      {
        'title': 'Exercise 2 – Input Controls Demo',
        'subtitle': 'Slider, Switch, RadioListTile, DatePicker',
        'builder': (context) => const InputControlsDemo(),
      },
      {
        'title': 'Exercise 3 – Layout Demo',
        'subtitle': 'Column, Row, Padding, ListView',
        'builder': (context) => const LayoutDemo(),
      },
      {
        'title': 'Exercise 4 – App Structure & Theme',
        'subtitle': 'Scaffold, AppBar, FAB & ThemeMode',
        'builder': (context) => AppStructureThemeDemo(
              onToggleTheme: onToggleTheme,
              isDarkMode: isDarkMode,
            ),
      },
      {
        'title': 'Exercise 5 – Common UI Fixes',
        'subtitle': 'Expanded, SingleChildScrollView, setState',
        'builder': (context) => const CommonUiFixesDemo(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 4 – Flutter UI Fundamentals'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            tooltip: 'Toggle Theme',
            onPressed: onToggleTheme,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final item = exercises[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12.0),
            child: ListTile(
              title: Text(
                item['title'],
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                item['subtitle'],
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: item['builder'],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
