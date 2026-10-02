import 'package:flutter/material.dart';

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 1 – Core Widgets Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Headline Text
            const Text(
              'Welcome to Flutter UI',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // 2. Icon using Material Icons
            const Icon(
              Icons.flutter_dash,
              size: 80,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),

            // 3. Image.network() with rounded corners & placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://picsum.photos/600/350',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 200,
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.broken_image, size: 48, color: Colors.grey),
                          SizedBox(height: 8),
                          Text('Image placeholder'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // 4. Card containing a ListTile
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const ListTile(
                leading: Icon(Icons.star, color: Colors.amber),
                title: Text(
                  'Movie Item',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('This is a sample ListTile inside a Card.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
