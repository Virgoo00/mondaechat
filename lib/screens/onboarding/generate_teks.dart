import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:intl/intl.dart'; // Import paket untuk formatting tanggal

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> messages = [
    {"text": "Hello!", "sender": "sender"},
    {"text": "Hello! Welcome to MondaeAI, What do you want to ask?", "sender": "receiver"},
  ];

  static const apiKey = "AIzaSyDRoVCdj_65CDXCaeVXBIz7aM-Lara2NM8"; // Ganti dengan API key yang valid
  final model = GenerativeModel(model: "gemini-pro", apiKey: apiKey);

  void _sendMessage(String text) {
    setState(() {
      messages.add({"text": text, "sender": "sender"});
    });
    _controller.clear();
    _respondMessage(text);
  }

  void _respondMessage(String userMessage) async {

    // Memanggil API untuk mendapatkan respons
    final content = [Content.text(userMessage)];
    final response = await model.generateContent(content);

    setState(() {
      messages.add({"text": "Typing...", "sender": "receiver"}); // Menampilkan indikator pengetikan
    });

    // Simulasi efek pengetikan palsu
    _simulateTypingEffect(response.text ?? "");
  }

  void _simulateTypingEffect(String response) {
    int index = messages.length - 1;
    String currentText = "";

    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (currentText.length < response.length) {
        setState(() {
          currentText += response[currentText.length];
          messages[index] = {"text": currentText, "sender": "receiver"};
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: Text(
          'Text Generation',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return message["sender"] == "sender"
                    ? _buildSenderMessage(message["text"]!)
                    : _buildReceiverMessage(message["text"]!);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement logic for file input
                  },
                  child: const Icon(Icons.attach_file),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    maxLines: null,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text);
                    }
                  },
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSenderMessage(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildReceiverMessage(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.android, color: Colors.white),
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(text)),
          ],
        ),
      ),
    );
  }
}
