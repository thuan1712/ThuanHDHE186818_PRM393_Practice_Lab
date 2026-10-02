import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  final List<Map<String, String>> movies = const [
    {
      'title': 'Avatar',
      'description': 'Sample description',
    },
    {
      'title': 'Inception',
      'description': 'Sample description',
    },
    {
      'title': 'Interstellar',
      'description': 'Sample description',
    },
    {
      'title': 'Joker',
      'description': 'Sample description',
    },
    {
      'title': 'The Dark Knight',
      'description': 'Sample description',
    },
    {
      'title': 'Avengers: Endgame',
      'description': 'Sample description',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3 – Layout Demo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header with consistent padding
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Center(
              child: Text(
                'Now Playing',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // ListView.builder embedded inside Column using Expanded
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                final initial = movie['title']![0];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        initial,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ),
                    title: Text(
                      movie['title']!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      movie['description']!,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
