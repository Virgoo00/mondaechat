import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class GenerateImageScreen extends StatefulWidget {
  const GenerateImageScreen({super.key});

  @override
  GenerateImageScreenState createState() => GenerateImageScreenState();
}

class GenerateImageScreenState extends State<GenerateImageScreen> {
  final TextEditingController textController = TextEditingController();
  String? generatedImage;
  String? prompt;
  File? selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      } else {
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    });
  }

  void generateImage() {
    setState(() {
      prompt = textController.text;
      generatedImage = 'assets/generated_image.png'; // Path to dummy image
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your text to generate an image:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Input Text',
              ),
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
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: generateImage,
              child: const Text('Generate Image'),
            ),
            const SizedBox(height: 16),
            if (generatedImage != null) ...[
              const Text(
                'Generated Image:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Prompt: $prompt',
                style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 16),
              Image.asset(
                generatedImage!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
