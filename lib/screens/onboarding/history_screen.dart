import 'package:flutter/material.dart';
import 'archive_screen.dart'; // Mengimpor file archive_screen.dart

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<ArchiveItem> historyItems = [
    ArchiveItem(title: 'History Generate 1', date: '28/05/2024'),
    ArchiveItem(title: 'History Generate 2', date: '28/05/2024'),
    ArchiveItem(title: 'History Generate 3', date: '28/05/2024'),
  ];

  void _deleteItem(int index) {
    setState(() {
      historyItems.removeAt(index);
    });
  }

  void _editItem(int index, String newTitle) {
    setState(() {
      historyItems[index] = ArchiveItem(title: newTitle, date: historyItems[index].date);
    });
  }

  void _showEditDialog(int index) {
    TextEditingController _controller = TextEditingController(text: historyItems[index].title);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit History Name'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'New History Name',
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                _editItem(index, _controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: Color.fromARGB(255, 199, 230, 255),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Implementasi untuk menambahkan item
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: historyItems.length,
              itemBuilder: (context, index) {
                final item = historyItems[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.date),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showEditDialog(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteItem(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArchiveListScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFC7E6FF),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.archive_outlined, color: Color(0xFF717CA1)),
                  SizedBox(width: 8.0),
                  Text('Archive List'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
