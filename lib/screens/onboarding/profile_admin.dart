import 'package:flutter/material.dart';
import 'generate_chart.dart';
import 'generate_image.dart';
import 'history_screen.dart';
import 'profile_settings_screen.dart';
import 'generate_teks.dart';
import 'login_screen.dart'; // Import halaman login
import 'manage_user_screen.dart'; // Import halaman Manage User
import 'dart:io';

void main() {
  runApp(const ProfileAdminScreen());
}

class ProfileAdminScreen extends StatefulWidget {
  const ProfileAdminScreen({super.key});

  @override
  ProfileAdminScreenState createState() => ProfileAdminScreenState();
}

class ProfileAdminScreenState extends State<ProfileAdminScreen> {
  String userName = 'Adewale Taiwo';
  String userRole = 'Admin';
  File? profileImage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
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
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // User Avatar
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: profileImage != null
                              ? FileImage(profileImage!)
                              : const AssetImage('assets/profile_placeholder.png') as ImageProvider<Object>,
                          child: profileImage == null
                              ? const Icon(Icons.person, size: 40, color: Colors.white)
                              : null,
                        ),
                        const SizedBox(height: 10),
                        Text(userName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Text(userRole, style: const TextStyle(fontSize: 14, color: Colors.black45)),
                      ],
                    ),
                  ),
                ),

                // Archive History
                Container(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigasi ke halaman archive
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HistoryScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent[100],
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.archive_rounded, color: Colors.white),
                        SizedBox(width: 10),
                        Text('Archive History'),
                        SizedBox(width: 10),
                        Text('100 in total', style: TextStyle(fontSize: 14, color: Colors.white)),
                      ],
                    ),
                  ),
                ),

                // Choose Features
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Choose features', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),
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
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigasi ke halaman chat
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const GenerateImageScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image, color: Colors.purple, size: 30),
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
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigasi ke halaman chat
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ChatScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Column(
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
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const GenerateChartScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Column(
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
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Services', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),

                // Manage User
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ManageUserScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.manage_accounts, color: Colors.blue[900]),
                        const SizedBox(width: 20),
                        const Text('Manage User'),
                      ],
                    ),
                  ),
                ),

                // Log Out
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      // Tampilkan dialog konfirmasi
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Konfirmasi'),
                            content: const Text('Apakah Anda yakin ingin keluar?'),
                            actions: [
                              TextButton(
                                child: const Text('Batal'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                onPressed: () {
                                  // Navigasi kembali ke halaman login dan hapus semua rute sebelumnya
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()),
                                        (Route<dynamic> route) => false,
                                  );
                                },
                                child: const Text('Keluar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: Colors.blue[900]),
                        const SizedBox(width: 20),
                        const Text('Log out'),
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
