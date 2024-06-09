import 'package:flutter/material.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class GenerateImageScreen extends StatefulWidget {
  const GenerateImageScreen({Key? key}) : super(key: key);

  @override
  _GenerateImageScreenState createState() => _GenerateImageScreenState();
}

class _GenerateImageScreenState extends State<GenerateImageScreen> {
  final TextEditingController textController = TextEditingController();
  final List<Map<String, dynamic>> messages = [];
  final Map<String, Map<String, String>> generatedImages = {};
  File? selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        messages.add({"text": "Image selected", "sender": "system"});
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> generateImage(String prompt, {bool isRegenerate = false, int? index}) async {
    final response = await http.get(Uri.parse(
        'https://api.unsplash.com/photos/random?query=$prompt&client_id=ggV4vFCIo_vQFO1INJOgVWNQB1CXellKmUEYWyT9Is8'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        generatedImages[prompt] = {
          "url": data['urls']['regular'],
          "description": data['alt_description']
        };
        if (isRegenerate && index != null) {
          messages[index] = {"text": "Generated image for prompt: $prompt", "sender": "system", "prompt": prompt};
        } else {
          messages.add({"text": "Generated image for prompt: $prompt", "sender": "system", "prompt": prompt});
        }
      });
    } else {
      print('Failed to load image');
    }
  }

  void _showFullScreenImage(String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImage(imageUrl: imageUrl),
      ),
    );
  }

  void _sendMessage(String text) {
    setState(() {
      messages.add({"text": text, "sender": "user", "prompt": text});
    });
    textController.clear();
    generateImage(text); // Generate image based on user input
  }

  void _regenerateImage(String prompt, int index) {
    generateImage(prompt, isRegenerate: true, index: index); // Regenerate image based on the specific prompt
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Generate Image',
          style: TextStyle(color: Colors.black), // Ubah warna teks menjadi putih
        ),
        backgroundColor: Colors.blue[100], // Ubah warna background menjadi ungu
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return message["sender"] == "user"
                    ? _buildUserMessage(message["text"]!)
                    : _buildSystemMessage(message["text"]!, message["prompt"]!, index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: pickImage,
                  child: const Icon(Icons.attach_file),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      _sendMessage(textController.text);
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


  Widget _buildUserMessage(String text) {
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

  Widget _buildSystemMessage(String text, String prompt, int index) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 210, 210, 210),
                  backgroundImage: AssetImage('assets/images/mondae_2.png'), // Updated line
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      generatedImages.containsKey(prompt)
                          ? GestureDetector(
                              onTap: () => _showFullScreenImage(generatedImages[prompt]!["url"]!),
                              child: Card(
                                elevation: 3,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      width: 400,
                                      height: 200,
                                      child: CachedNetworkImage(
                                        imageUrl: generatedImages[prompt]!["url"]!,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => const Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                    if (generatedImages[prompt]!["description"] != null)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          generatedImages[prompt]!["description"]!,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            await FlutterDownloader.enqueue(
                                              url: generatedImages[prompt]!["url"]!,
                                              savedDir: 'Downloads',
                                              fileName: 'image.jpg',
                                              showNotification: true,
                                              openFileFromNotification: true,
                                            );
                                          },
                                          icon: const Icon(Icons.download),
                                        ),
                                        IconButton(
                                          onPressed: () =>
                                              _regenerateImage(prompt, index),
                                          icon: const Icon(Icons.refresh),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFullScreenImage(String imageUrl) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
