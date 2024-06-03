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
        title: const Text('Generate Image'),
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

  Widget _buildSystemMessage(String text, String prompt, int index) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.android, color: Colors.white),
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




// KODE LAMA
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class GenerateImageScreen extends StatefulWidget {
//   const GenerateImageScreen({super.key});

//   @override
//   GenerateImageScreenState createState() => GenerateImageScreenState();
// }

// class GenerateImageScreenState extends State<GenerateImageScreen> {
//   final TextEditingController textController = TextEditingController();
//   String? generatedImage;
//   String? prompt;
//   File? selectedImage;

//   final ImagePicker _picker = ImagePicker();

//   Future<void> pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedFile != null) {
//         selectedImage = File(pickedFile.path);
//       } else {
//         if (kDebugMode) {
//           print('No image selected.');
//         }
//       }
//     });
//   }

//   void generateImage() {
//     setState(() {
//       prompt = textController.text;
//       generatedImage = 'assets/generated_image.png'; // Path to dummy image
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Generate Image'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Enter your text to generate an image:',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: textController,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Input Text',
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: pickImage,
//                   child: const Text('Pick Image'),
//                 ),
//                 const SizedBox(width: 16),
//                 if (selectedImage != null)
//                   Image.file(
//                     selectedImage!,
//                     width: 50,
//                     height: 50,
//                   ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: generateImage,
//               child: const Text('Generate Image'),
//             ),
//             const SizedBox(height: 16),
//             if (generatedImage != null) ...[
//               const Text(
//                 'Generated Image:',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'Prompt: $prompt',
//                 style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
//               ),
//               const SizedBox(height: 16),
//               Image.asset(
//                 generatedImage!,
//                 height: 200,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
