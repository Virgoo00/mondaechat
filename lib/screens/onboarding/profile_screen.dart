import 'package:flutter/material.dart';
import 'generate_image.dart';
import 'profile_settings_screen.dart';
import 'archive_screen.dart'; // Import layar archive
import 'generate_teks.dart';
import 'login_screen.dart'; // Import halaman login
import 'dart:io';

void main() {
  runApp(ProfileScreen());
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'Adewale Taiwo';
  String userRole = 'Regular User';
  File? profileImage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue[100]!, Colors.blue[50]!],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // User Profile
                GestureDetector(
                  onTap: () async {
                    // Navigasi ke halaman pengaturan profil
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileSettingsScreen(
                                initialName: userName,
                                initialEmail: 'user@example.com', // Ganti dengan email pengguna jika ada
                                initialImage: profileImage,
                              )),
                    );

                    if (result != null) {
                      setState(() {
                        userName = result['userName'];
                        profileImage = result['profileImage'];
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // User Avatar
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: profileImage != null
                              ? FileImage(profileImage!)
                              : AssetImage('assets/profile_placeholder.png') as ImageProvider<Object>,
                          child: profileImage == null
                              ? Icon(Icons.person, size: 40, color: Colors.white)
                              : null,
                        ),
                        SizedBox(height: 10),
                        Text(userName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text(userRole, style: TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                  ),
                ),

                // Archive History
                Container(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigasi ke halaman archive
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ArchiveScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[100],
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bookmark, color: Colors.white),
                        SizedBox(width: 10),
                        Text('Archive History'),
                        SizedBox(width: 10),
                        Text('100 in total', style: TextStyle(fontSize: 14, color: Colors.white)),
                      ],
                    ),
                  ),
                ),

                // Choose Features
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Choose features', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Image Generation
                    Container(
                      width: 100,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigasi ke halaman chat
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GenerateImageScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.text_fields, color: Colors.purple, size: 30),
                            SizedBox(height: 10),
                            Text('Image Generation', style: TextStyle(color: Colors.black, fontSize: 12), textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ),

                    // Text Generation
                    Container(
                      width: 100,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigasi ke halaman chat
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChatScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.text_fields, color: Colors.purple, size: 30),
                            SizedBox(height: 10),
                            Text('Text Generation', style: TextStyle(color: Colors.black, fontSize: 12), textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ),

                    // Chart Generation
                    Container(
                      width: 100,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.bar_chart, color: Colors.purple, size: 30),
                            SizedBox(height: 10),
                            Text('Chart Generation', style: TextStyle(color: Colors.black, fontSize: 12), textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Services
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Services', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),

                // Log Out
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      // Tampilkan dialog konfirmasi
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Konfirmasi'),
                            content: Text('Apakah Anda yakin ingin keluar?'),
                            actions: [
                              TextButton(
                                child: Text('Batal'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                onPressed: () {
                                  // Navigasi kembali ke halaman login dan hapus semua rute sebelumnya
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: Text('Keluar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: Colors.blue[900]),
                        SizedBox(width: 10),
                        Text('Log out'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





// KODE LAMA
// import 'package:flutter/material.dart';
// import 'package:mondaechat/screens/onboarding/profile_settings_screen.dart';
// import 'chat_screen.dart';
// import 'history_screen.dart';
// import 'login_screen.dart';
// import 'archive_screen.dart';
// import 'generate_image_screen.dart';
// import 'generate_chart_screen.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     const String username = "John Doe";
//     const String profileImageUrl = "assets/profile.jpg";

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // User Info Section
//             Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const CircleAvatar(
//                       radius: 50,
//                       backgroundImage: AssetImage(profileImageUrl),
//                     ),
//                     const SizedBox(height: 10),
//                     const Text(
//                       username,
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     ElevatedButton.icon(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const ProfileSettingsScreen(),
//                           ),
//                         );
//                       },
//                       icon: const Icon(Icons.settings),
//                       label: const Text('Setelan Profil'),
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//                         textStyle: const TextStyle(fontSize: 16),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Archive Section
//             const Text(
//               'Archive',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const HistoryScreen(),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         textStyle: const TextStyle(fontSize: 16),
//                       ),
//                       child: const Text('History'),
//                     ),
//                     const SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ArchiveScreen(),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         textStyle: const TextStyle(fontSize: 16),
//                       ),
//                       child: const Text('Archive'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
//             // Features Section
//             const Text(
//               'Features',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 10),
//             // Generate Image Feature
//             Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: ListTile(
//                 leading: const Icon(Icons.image, color: Colors.blueAccent, size: 40),
//                 title: const Text('Generate Image', style: TextStyle(fontSize: 18)),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const GenerateImageScreen(),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 10),
//             // Generate Text Feature
//             Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: ListTile(
//                 leading: const Icon(Icons.text_fields, color: Colors.green, size: 40),
//                 title: const Text('Generate Text', style: TextStyle(fontSize: 18)),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const ChatScreen(),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 10),
//             // Generate Chart Feature
//             Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: ListTile(
//                 leading: const Icon(Icons.bar_chart, color: Colors.orange, size: 40),
//                 title: const Text('Generate Chart', style: TextStyle(fontSize: 18)),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const GenerateChartScreen(),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 30),
//             // Logout Button
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => const LoginScreen()),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.redAccent,
//                   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                   textStyle: const TextStyle(fontSize: 16),
//                 ),
//                 child: const Text('Logout'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
