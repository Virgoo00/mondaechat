import 'package:flutter/material.dart';
import 'archive_screen.dart'; // Impor model ArchiveItem

class EditScreen extends StatefulWidget {
  final ArchiveItem item;
  final Function(ArchiveItem) onEdit;

  EditScreen({required this.item, required this.onEdit});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.item.title);
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.onEdit(ArchiveItem(title: titleController.text, dateTime: widget.item.dateTime));
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
