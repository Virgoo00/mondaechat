import 'package:flutter/material.dart';
import 'history_screen.dart';
import 'generate_image.dart';
import 'generate_teks.dart';
import 'login_screen.dart'; // Import halaman login
import 'dart:io';
import 'profile_settings_screen.dart';
import 'generate_chart.dart'; // Import halaman generate_chart
import 'package:mondaechat/screens/onboarding/subscription_screen.dart';

void main() {
  runApp(const ProfileScreen());
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  String userName = 'Adewale Taiwo';
  String userRole = 'Regular User';
  File? profileImage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 199, 230, 255), // Warna appbar
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
              colors: [const Color.fromARGB(255, 199, 230, 255), Colors.blue[50]!],
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
                        Text(userRole, style: const TextStyle(fontSize: 14, color: Colors.grey)),
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
                      backgroundColor: Colors.purple, // Ubah warna latar belakang menjadi ungu
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white), // Ubah warna teks menjadi putih
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.archive, color: Colors.white),
                        SizedBox(width: 10),
                        Text('Archive History', style: TextStyle(fontSize: 12, color: Colors.white)),
                        SizedBox(width: 10),
                        Text('100 in total', style: TextStyle(fontSize: 12, color: Colors.white)),
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
                          // Navigasi ke halaman generate_chart
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

                // Subscription Button
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      // Logic untuk subscription
                      // Contoh: Navigasi ke halaman subscription
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SubscriptionScreen()), // Halaman SubscriptionScreen harus dibuat
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.subscriptions, color: Colors.white),
                        SizedBox(width: 20),
                        Text('Subscribe'),
                      ],
                    ),
                  ),
                ),


                // Log Out
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      // Tampilkan dialog konfirmasi
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Are you sure want to logout?'),
                            content: const Text('You must login first before access app again!'),
                            actions: [
                              TextButton(
                                child: const Text('Cancel'),
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
                                    MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: const Text('Logout'),
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
                      side: const BorderSide(color: Colors.red),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: Colors.red),
                        SizedBox(width: 10),
                        Text('Logout', style: TextStyle(color: Colors.red)),
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


// Code Lama
// import 'package:flutter/material.dart';
// import 'history_screen.dart';
// import 'generate_image.dart';
// import 'generate_teks.dart';
// import 'login_screen.dart'; // Import halaman login
// import 'dart:io';
// import 'profile_settings_screen.dart';
// import 'generate_chart.dart'; // Import halaman generate_chart

// void main() {
//   runApp(ProfileScreen());
// }

// class ProfileScreen extends StatefulWidget {
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   String userName = 'Adewale Taiwo';
//   String userRole = 'Regular User';
//   File? profileImage;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color.fromARGB(255, 199, 230, 255), // Warna appbar
//           elevation: 0,
//           leading: IconButton(
//             icon: Icon(Icons.menu, color: Colors.black),
//             onPressed: () {},
//           ),
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [Color.fromARGB(255, 199, 230, 255), Colors.blue[50]!],
//             ),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 // User Profile
//                 GestureDetector(
//                   onTap: () async {
//                     // Navigasi ke halaman pengaturan profil
//                     final result = await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => ProfileSettingsScreen(
//                                 initialName: userName,
//                                 initialEmail: 'user@example.com', // Ganti dengan email pengguna jika ada
//                                 initialImage: profileImage,
//                               )),
//                     );

//                     if (result != null) {
//                       setState(() {
//                         userName = result['userName'];
//                         profileImage = result['profileImage'];
//                       });
//                     }
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(20),
//                     child: Column(
//                       children: [
//                         // User Avatar
//                         CircleAvatar(
//                           radius: 40,
//                           backgroundImage: profileImage != null
//                               ? FileImage(profileImage!)
//                               : AssetImage('assets/profile_placeholder.png') as ImageProvider<Object>,
//                           child: profileImage == null
//                               ? Icon(Icons.person, size: 40, color: Colors.white)
//                               : null,
//                         ),
//                         SizedBox(height: 10),
//                         Text(userName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                         SizedBox(height: 5),
//                         Text(userRole, style: TextStyle(fontSize: 14, color: Colors.grey)),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // Archive History
//                 Container(
//                   padding: EdgeInsets.all(20),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Navigasi ke halaman archive
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => HistoryScreen()),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.purple, // Ubah warna latar belakang menjadi ungu
//                       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                       textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white), // Ubah warna teks menjadi putih
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.archive, color: Colors.white),
//                         SizedBox(width: 10),
//                         Text('Archive History', style: TextStyle(fontSize: 12, color: Colors.white)),
//                         SizedBox(width: 10),
//                         Text('100 in total', style: TextStyle(fontSize: 12, color: Colors.white)),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // Choose Features
//                 SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Text('Choose features', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     // Image Generation
//                     Container(
//                       width: 100,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.2),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Navigasi ke halaman chat
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => GenerateImageScreen()),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           padding: EdgeInsets.all(15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.image, color: Colors.purple, size: 30),
//                             SizedBox(height: 10),
//                             Text('Image Generation', style: TextStyle(color: Colors.black, fontSize: 12), textAlign: TextAlign.center),
//                           ],
//                         ),
//                       ),
//                     ),

//                     // Text Generation
//                     Container(
//                       width: 100,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.2),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Navigasi ke halaman chat
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => ChatScreen()),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           padding: EdgeInsets.all(15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.text_fields, color: Colors.purple, size: 30),
//                             SizedBox(height: 10),
//                             Text('Text Generation', style: TextStyle(color: Colors.black, fontSize: 12), textAlign: TextAlign.center),
//                           ],
//                         ),
//                       ),
//                     ),

//                     // Chart Generation
//                     Container(
//                       width: 100,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.2),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Navigasi ke halaman generate_chart
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => GenerateChartScreen()),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           padding: EdgeInsets.all(15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.bar_chart, color: Colors.purple, size: 30),
//                             SizedBox(height: 10),
//                             Text('Chart Generation', style: TextStyle(color: Colors.black, fontSize: 12), textAlign: TextAlign.center),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 // Services
//                 SizedBox(height: 30),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Text('Services', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 ),

//                 // Log Out
//                 SizedBox(height: 15),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Tampilkan dialog konfirmasi
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             title: Text('Are you sure want to logout?'),
//                             content: Text('You must login first before access app again!'),
//                             actions: [
//                               TextButton(
//                                 child: Text('Cancel'),
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               ),
//                               ElevatedButton(
//                                 style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                                 onPressed: () {
//                                   // Navigasi kembali ke halaman login dan hapus semua rute sebelumnya
//                                   Navigator.pushAndRemoveUntil(
//                                     context,
//                                     MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
//                                     (Route<dynamic> route) => false,
//                                   );
//                                 },
//                                 child: Text('Logout'),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//                       textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                       side: BorderSide(color: Colors.red),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.logout, color: Colors.red),
//                         SizedBox(width: 10),
//                         Text('Logout', style: TextStyle(color: Colors.red)),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

