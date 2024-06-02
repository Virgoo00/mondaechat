import 'package:flutter/material.dart';
import 'generate_teks.dart';
import 'edit_archive.dart'; // Impor layar pengeditan

class ArchiveItem {
  final String title;
  final DateTime dateTime;

  ArchiveItem({required this.title, required this.dateTime});
}

class ArchiveScreen extends StatefulWidget {
  @override
  _ArchiveScreenState createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  List<ArchiveItem> archiveItems = List.generate(
    10,
    (index) => ArchiveItem(
      title: 'Generated Item ${index + 1}',
      dateTime: DateTime.now().subtract(Duration(days: index)),
    ),
  );

  void _deleteItem(int index) {
    setState(() {
      archiveItems.removeAt(index);
    });
  }

  void _editItem(int index, ArchiveItem newItem) {
    setState(() {
      archiveItems[index] = newItem;
    });
  }

  void _shareItem(ArchiveItem item) {
    // Implement share functionality here
    // For demonstration, just showing a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sharing ${item.title}')),
    );
  }

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
                    "${item.dateTime.toLocal()}".split(' ')[0],
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
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
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        child: const Text('Open'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditScreen(
                                item: item,
                                onEdit: (newItem) => _editItem(index, newItem),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        child: const Text('Edit'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => _deleteItem(index),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Background color
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        child: const Text('Delete'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => _shareItem(item),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Background color
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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







// KODE LAMA
// import 'package:flutter/material.dart';

// import 'chat_screen.dart';

// class ArchiveItem {
//   final String title;
//   final DateTime dateTime;

//   ArchiveItem({required this.title, required this.dateTime});
// }

// class ArchiveScreen extends StatelessWidget {
//   ArchiveScreen({super.key});

//   final List<ArchiveItem> archiveItems = List.generate(
//     10,
//         (index) => ArchiveItem(
//       title: 'Generated Item ${index + 1}',
//       dateTime: DateTime.now().subtract(Duration(days: index)),
//     ),
//   );
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Archive'),
//       ),
//       body: ListView.builder(
//         itemCount: archiveItems.length,
//         itemBuilder: (context, index) {
//           final item = archiveItems[index];
//           return Card(
//             margin: const EdgeInsets.all(8.0),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     item.title,
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     """${'${item.dateTime.toLocal()}'.split(' ')[0]} at ${'${item.dateTime.toLocal()}'.split(' ')[1].substring(0, 5)}""",
//                     style: const TextStyle(color: Colors.grey),
//                   ),
//                   const SizedBox(height: 2),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => const ChatScreen()),
//                           );
//                         },
//                         child: const Text('Open'),
//                       ),
//                       const SizedBox(width: 2),
//                       ElevatedButton(
//                         onPressed: () {
//                         },
//                         child: const Text('Edit'),
//                       ),
//                       const SizedBox(width: 0),
//                       ElevatedButton(
//                         onPressed: () {
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.red, // Background color
//                         ),
//                         child: const Text('Delete'),
//                       ),
//                       const SizedBox(width: 0),
//                       ElevatedButton(
//                         onPressed: () {
//                           // Implement share functionality
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue, // Background color
//                         ),
//                         child: const Text('Share'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
