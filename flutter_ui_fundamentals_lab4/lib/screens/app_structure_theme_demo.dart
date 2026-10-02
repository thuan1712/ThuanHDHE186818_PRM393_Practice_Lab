import 'package:flutter/material.dart';

class AppStructureThemeDemo extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const AppStructureThemeDemo({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<AppStructureThemeDemo> createState() => _AppStructureThemeDemoState();
}

class _AppStructureThemeDemoState extends State<AppStructureThemeDemo> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 4 – App Structure & Theme'),
        actions: [
          Row(
            children: [
              const Text('Dark', style: TextStyle(fontSize: 12)),
              Switch(
                value: widget.isDarkMode,
                onChanged: (_) => widget.onToggleTheme(),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'This is a simple screen with theme toggle.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Current Mode: ${widget.isDarkMode ? "Dark Mode" : "Light Mode"}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('FAB Button Click Count: $_counter'),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter++;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('FloatingActionButton clicked! (Count: $_counter)'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
