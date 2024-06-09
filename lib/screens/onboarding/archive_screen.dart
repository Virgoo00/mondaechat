import 'package:flutter/material.dart';

class ArchiveItem {
  final String title;
  final String date; // Gunakan String untuk menyimpan tanggal

  ArchiveItem({required this.title, required this.date});
}

class ArchiveScreen extends StatefulWidget {
  @override
  _ArchiveScreenState createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  List<ArchiveItem> archiveItems = [
    ArchiveItem(title: 'History Generate 1', date: '28/05/2024'),
    ArchiveItem(title: 'History Generate 2', date: '28/05/2024'),
    ArchiveItem(title: 'History Generate 3', date: '28/05/2024'),
  ];

  void _deleteItem(int index) {
    setState(() {
      archiveItems.removeAt(index);
    });
  }

  void _editItem(int index, String newTitle) {
    setState(() {
      archiveItems[index] = ArchiveItem(title: newTitle, date: archiveItems[index].date);
    });
  }

  void _showEditDialog(int index) {
    TextEditingController _controller = TextEditingController(text: archiveItems[index].title);

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
              itemCount: archiveItems.length,
              itemBuilder: (context, index) {
                final item = archiveItems[index];
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

class ArchiveListScreen extends StatefulWidget {
  @override
  _ArchiveListScreenState createState() => _ArchiveListScreenState();
}

class _ArchiveListScreenState extends State<ArchiveListScreen> {
  List<ArchiveItem> archiveListItems = [
    ArchiveItem(title: 'Archived Item 1', date: '28/05/2024'),
    ArchiveItem(title: 'Archived Item 2', date: '28/05/2024'),
    ArchiveItem(title: 'Archived Item 3', date: '28/05/2024'),
  ];

  void _deleteItem(int index) {
    setState(() {
      archiveListItems.removeAt(index);
    });
  }

  void _editItem(int index, String newTitle) {
    setState(() {
      archiveListItems[index] = ArchiveItem(title: newTitle, date: archiveListItems[index].date);
    });
  }

  void _showEditDialog(int index) {
    TextEditingController _controller = TextEditingController(text: archiveListItems[index].title);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Archive Name'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'New Archive Name',
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
        title: const Text('Archive List'),
        backgroundColor: Color.fromARGB(255, 199, 230, 255),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: archiveListItems.length,
              itemBuilder: (context, index) {
                final item = archiveListItems[index];
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
        ],
      ),
    );
  }
}
