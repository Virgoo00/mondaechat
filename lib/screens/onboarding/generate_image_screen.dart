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
  String? generatedImageUrl;
  String? imageDescription;
  String? prompt;
  File? selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> generateImage() async {
    setState(() {
      prompt = textController.text;
    });

    final response = await http.get(Uri.parse(
        'https://api.unsplash.com/photos/random?query=$prompt&client_id=ggV4vFCIo_vQFO1INJOgVWNQB1CXellKmUEYWyT9Is8'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        generatedImageUrl = data['urls']['regular'];
        imageDescription = data['alt_description'];
      });
    } else {
      print('Failed to load image');
    }
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (generatedImageUrl != null) ...[
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Generated Image:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          CachedNetworkImage(
                            imageUrl: generatedImageUrl!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          if (prompt != null) ...[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Prompt: $prompt',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                          if (imageDescription != null) ...[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Description: $imageDescription',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: generateImage,
                                  child: const Text('Regenerate Image'),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await FlutterDownloader.enqueue(
                                    url: generatedImageUrl!,
                                    savedDir: 'Downloads',
                                    fileName: 'image.jpg',
                                    showNotification: true,
                                    openFileFromNotification: true,
                                  );
                                },
                                icon: const Icon(Icons.download),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  const Text(
                    'Enter your text to generate an image:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: textController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Input Text',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: generateImage,
                        icon: const Icon(Icons.send),
                        label: const Text('Submit'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: pickImage,
                        child: const Text('Pick Image'),
                      ),
                      const SizedBox(width: 16),
                      if (selectedImage != null)
                        Image.file(
                          selectedImage!,
                          width: 50,
                          height: 50,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
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
