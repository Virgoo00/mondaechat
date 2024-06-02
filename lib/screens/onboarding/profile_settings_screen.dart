import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileSettingsScreen extends StatefulWidget {
  final String initialName;
  final String initialEmail;
  final File? initialImage;

  const ProfileSettingsScreen({
    Key? key,
    required this.initialName,
    required this.initialEmail,
    this.initialImage,
  }) : super(key: key);

  @override
  ProfileSettingsScreenState createState() => ProfileSettingsScreenState();
}

class ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  XFile? _profileImage;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initialName;
    _emailController.text = widget.initialEmail;
    if (widget.initialImage != null) {
      _profileImage = XFile(widget.initialImage!.path);
    }
  }

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage != null
                    ? FileImage(File(_profileImage!.path)) as ImageProvider<Object>
                    : const AssetImage('assets/profile_placeholder.png') as ImageProvider<Object>,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Kembalikan data pengguna yang diperbarui ke layar utama
                Navigator.pop(context, {
                  'userName': _nameController.text,
                  'profileImage': _profileImage != null ? File(_profileImage!.path) : null,
                });
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}







// KODE LAMA
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class ProfileSettingsScreen extends StatefulWidget {
//   const ProfileSettingsScreen({super.key});

//   @override
//   ProfileSettingsScreenState createState() => ProfileSettingsScreenState();
// }

// class ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   XFile? _profileImage;

//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickImage() async {
//     final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _profileImage = pickedImage;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile Settings'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: _pickImage,
//               child: CircleAvatar(
//                 radius: 50,
//                 backgroundImage: _profileImage != null
//                     ? FileImage(File(_profileImage!.path)) as ImageProvider<Object>
//                     : const AssetImage('assets/profile_placeholder.png') as ImageProvider<Object>,
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(
//                 labelText: 'Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Lakukan penyimpanan data pengguna di sini
//                 Navigator.pop(context);
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
