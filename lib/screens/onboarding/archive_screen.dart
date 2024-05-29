import 'package:flutter/material.dart';

import 'chat_screen.dart';

class ArchiveItem {
  final String title;
  final DateTime dateTime;

  ArchiveItem({required this.title, required this.dateTime});
}

class ArchiveScreen extends StatelessWidget {
  ArchiveScreen({super.key});

  final List<ArchiveItem> archiveItems = List.generate(
    10,
        (index) => ArchiveItem(
      title: 'Generated Item ${index + 1}',
      dateTime: DateTime.now().subtract(Duration(days: index)),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Archive'),
      ),
      body: ListView.builder(
        itemCount: archiveItems.length,
        itemBuilder: (context, index) {
          final item = archiveItems[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    """${'${item.dateTime.toLocal()}'.split(' ')[0]} at ${'${item.dateTime.toLocal()}'.split(' ')[1].substring(0, 5)}""",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ChatScreen()),
                          );
                        },
                        child: const Text('Open'),
                      ),
                      const SizedBox(width: 2),
                      ElevatedButton(
                        onPressed: () {
                        },
                        child: const Text('Edit'),
                      ),
                      const SizedBox(width: 0),
                      ElevatedButton(
                        onPressed: () {
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Background color
                        ),
                        child: const Text('Delete'),
                      ),
                      const SizedBox(width: 0),
                      ElevatedButton(
                        onPressed: () {
                          // Implement share functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Background color
                        ),
                        child: const Text('Share'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
