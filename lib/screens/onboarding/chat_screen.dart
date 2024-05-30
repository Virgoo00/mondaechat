import 'package:flutter/material.dart';
import 'dart:async';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> messages = [
    {"text": "Hello!", "sender": "sender"},
    {"text": "Hello! Welcome to MondaeAI, What do you want to ask?", "sender": "receiver"},
  ];

  void _sendMessage(String text) {
    setState(() {
      messages.add({"text": text, "sender": "sender"});
    });
    _controller.clear();
    _respondMessage(text);
  }

  void _respondMessage(String userMessage) {
    String botResponse;

    if (userMessage.contains("HTML")) {
      botResponse = "HTML stands for HyperText Markup Language. It's used to create web pages.";
    } else if (userMessage.contains("CSS")) {
      botResponse = "CSS stands for Cascading Style Sheets. It describes the look and formatting of a document written in HTML.";
    } else if (userMessage.contains("JavaScript")) {
      botResponse = "JavaScript is a programming language commonly used in web development to create interactive effects within web browsers.";
    } else if (userMessage.contains("Flutter")) {
      botResponse = "Flutter is an open-source UI software development toolkit created by Google. It's used to develop cross-platform applications.";
    } else if (userMessage.contains("Dart")) {
      botResponse = "Dart is a programming language optimized for building mobile, desktop, server, and web applications. It's used in Flutter development.";
    } else if (userMessage.contains("Python")) {
      botResponse = "Python is a high-level, interpreted programming language known for its readability and broad applicability in areas such as web development, data science, and scripting.";
    } else if (userMessage.contains("AI")) {
      botResponse = "AI stands for Artificial Intelligence. It refers to the simulation of human intelligence in machines that are programmed to think and learn.";
    } else if (userMessage.contains("robotics")) {
      botResponse = "Robotics involves the design, construction, and operation of robots. It combines principles from mechanical engineering, electrical engineering, and computer science.";
    } else if (userMessage.contains("machine learning")) {
      botResponse = "Machine learning is a subset of AI that involves the use of algorithms and statistical models to enable computers to perform tasks without explicit instructions.";
    } else if (userMessage.contains("database")) {
      botResponse = "A database is an organized collection of structured information, or data, typically stored electronically in a computer system. Examples include MySQL, PostgreSQL, and MongoDB.";
    } else if (userMessage.contains("SQL")) {
      botResponse = "SQL stands for Structured Query Language. It's used to manage and manipulate relational databases.";
    } else if (userMessage.contains("NoSQL")) {
      botResponse = "NoSQL databases are non-relational databases that store data differently than relational tables. Examples include MongoDB, Cassandra, and Redis.";
    } else if (userMessage.contains("Java")) {
      botResponse = "Java is a high-level, class-based, object-oriented programming language that is designed to have as few implementation dependencies as possible.";
    } else if (userMessage.contains("C++")) {
      botResponse = "C++ is a general-purpose programming language created as an extension of the C programming language, or 'C with Classes'.";
    } else if (userMessage.contains("C#")) {
      botResponse = "C# is a modern, object-oriented programming language developed by Microsoft as part of its .NET initiative.";
    } else if (userMessage.contains("React")) {
      botResponse = "React is a JavaScript library for building user interfaces, maintained by Facebook and a community of individual developers and companies.";
    } else if (userMessage.contains("Node.js")) {
      botResponse = "Node.js is an open-source, cross-platform, back-end JavaScript runtime environment that executes JavaScript code outside a web browser.";
    } else if (userMessage.contains("Angular")) {
      botResponse = "Angular is a platform and framework for building single-page client applications using HTML and TypeScript, maintained by Google.";
    } else if (userMessage.contains("Vue.js")) {
      botResponse = "Vue.js is an open-source model–view–viewmodel front-end JavaScript framework for building user interfaces and single-page applications.";
    } else if (userMessage.contains("Kotlin")) {
      botResponse = "Kotlin is a cross-platform, statically typed, general-purpose programming language with type inference, designed to interoperate fully with Java.";
    } else if (userMessage.contains("Swift")) {
      botResponse = "Swift is a powerful and intuitive programming language for macOS, iOS, watchOS, and tvOS, created by Apple.";
    } else if (userMessage.contains("PHP")) {
      botResponse = "PHP is a popular general-purpose scripting language that is especially suited to web development.";
    } else if (userMessage.contains("Ruby")) {
      botResponse = "Ruby is an open-source, dynamic programming language focused on simplicity and productivity. It has an elegant syntax that is natural to read and easy to write.";
    } else if (userMessage.contains("Linux")) {
      botResponse = "Linux is an open-source Unix-like operating system kernel. It is widely used in servers, desktops, and mobile devices.";
    } else if (userMessage.contains("Windows")) {
      botResponse = "Windows is a group of several proprietary graphical operating system families developed and marketed by Microsoft.";
    } else if (userMessage.contains("macOS")) {
      botResponse = "macOS is a series of proprietary graphical operating systems developed and marketed by Apple Inc. since 2001.";
    } else if (userMessage.contains("cloud computing")) {
      botResponse = "Cloud computing is the on-demand availability of computer system resources, especially data storage and computing power, without direct active management by the user.";
    } else if (userMessage.contains("DevOps")) {
      botResponse = "DevOps is a set of practices that combines software development (Dev) and IT operations (Ops) aimed at shortening the systems development life cycle and providing continuous delivery with high software quality.";
    } else if (userMessage.contains("blockchain")) {
      botResponse = "Blockchain is a decentralized digital ledger that records transactions across many computers in a way that the registered transactions cannot be altered retroactively.";
    } else if (userMessage.contains("cybersecurity")) {
      botResponse = "Cybersecurity involves protecting computer systems and networks from information disclosure, theft of, or damage to their hardware, software, or electronic data.";
    } else if (userMessage.contains("augmented reality")) {
      botResponse = "Augmented Reality (AR) is an interactive experience where real-world environments are enhanced by computer-generated perceptual information.";
    } else if (userMessage.contains("virtual reality")) {
      botResponse = "Virtual Reality (VR) is a simulated experience that can be similar to or completely different from the real world, often used for entertainment, education, and training.";
    } else if (userMessage.contains("IoT")) {
      botResponse = "The Internet of Things (IoT) refers to the network of physical objects embedded with sensors, software, and other technologies to connect and exchange data with other devices and systems over the internet.";
    } else {
      botResponse = "Sorry, I didn't understand that. Can you ask something else?";
    }

    _showTypingIndicator();
    _simulateTypingEffect(botResponse);
  }

  void _showTypingIndicator() {
    setState(() {
      messages.add({"text": "Typing...", "sender": "receiver"});
    });
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
        title: const Text('Text Generation'),
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
                    // Implement file input logic
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
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
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
          color: Colors.grey[300],
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
