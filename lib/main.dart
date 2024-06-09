import 'package:flutter/material.dart';
import 'package:mondaechat/screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MONDAEAI',
      theme: ThemeData(
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
              fontSize: 16.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.normal),
          displayLarge: TextStyle(
              fontSize: 24.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
          displayMedium: TextStyle(
              fontSize: 22.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
          // Tambahkan gaya teks lainnya sesuai kebutuhan
        ),
        primarySwatch: Colors.blue,
      ),
      home: const OnboardingScreen(),
    );
  }
}









// untuk membuat login
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Login Screen',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const LoginScreen(),
//     );
//   }
// }

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back_ios),
//           color: Colors.black,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 50),
//             Image.asset('assets/images/logo.png', height: 100), // Ganti dengan gambar logo anda
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 children: [
//                   const Text(
//                     'Selamat datang kembali',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 20),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.white,
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.grey,
//                           offset: Offset(0, 2),
//                           blurRadius: 4,
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 20),
//                         const TextField(
//                           decoration: InputDecoration(
//                             hintText: 'Username',
//                             border: InputBorder.none,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Divider(
//                           color: Colors.grey[300],
//                           thickness: 1,
//                         ),
//                         const SizedBox(height: 10),
//                         const TextField(
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             hintText: 'Password',
//                             border: InputBorder.none,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Container(
//                     width: double.infinity, // Set the width to infinity to match parent width
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.grey,
//                           offset: Offset(0, 2),
//                           blurRadius: 4,
//                         ),
//                       ],
//                     ),
//                     child: ElevatedButton(
//                       onPressed: () {}, // Implement login logic
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF6200EE),
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text(
//                         'Login',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   TextButton(
//                     onPressed: () {}, // Implement register screen navigation
//                     style: TextButton.styleFrom(
//                       textStyle: const TextStyle(fontSize: 16),
//                     ),
//                     child: const Text('Belum memiliki akun? Mendaftar'),
//                   ),
//                   TextButton(
//                     onPressed: () {}, // Implement forgot password navigation
//                     style: TextButton.styleFrom(
//                       textStyle: const TextStyle(fontSize: 16),
//                     ),
//                     child: const Text('Lupa password?'),
//                   ),
//                   const SizedBox(height: 30),
//                   const SizedBox(height: 20),
//                   const SizedBox(height: 30),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }







// untuk membuat daftar diri
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Daftar Akun',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const DaftarScreen(),
//     );
//   }
// }

// class DaftarScreen extends StatelessWidget {
//   const DaftarScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back_ios),
//           color: Colors.black,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 50),
//             Image.asset('assets/images/logo.png', height: 100), // Ganti dengan gambar logo anda
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 children: [
//                   const Text(
//                     'Selamat datang',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     'Buat akun baru',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.black,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 20),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.white,
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.grey,
//                           offset: Offset(0, 2),
//                           blurRadius: 4,
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 20),
//                         const TextField(
//                           decoration: InputDecoration(
//                             hintText: 'Username',
//                             border: InputBorder.none,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Divider(
//                           color: Colors.grey[300],
//                           thickness: 1,
//                         ),
//                         const SizedBox(height: 10),
//                         const TextField(
//                           decoration: InputDecoration(
//                             hintText: 'Email',
//                             border: InputBorder.none,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Divider(
//                           color: Colors.grey[300],
//                           thickness: 1,
//                         ),
//                         const SizedBox(height: 10),
//                         const TextField(
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             hintText: 'Password',
//                             border: InputBorder.none,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Divider(
//                           color: Colors.grey[300],
//                           thickness: 1,
//                         ),
//                         const SizedBox(height: 10),
//                         const TextField(
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             hintText: 'Konfirmasi Password',
//                             border: InputBorder.none,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Container(
//                     width: double.infinity, // Set the width to infinity to match parent width
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.grey,
//                           offset: Offset(0, 2),
//                           blurRadius: 4,
//                         ),
//                       ],
//                     ),
//                     child: ElevatedButton(
//                       onPressed: () {}, // Implement login logic
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF6200EE),
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text(
//                         'Daftar',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   TextButton(
//                     onPressed: () {}, // Implement register screen navigation
//                     style: TextButton.styleFrom(
//                       textStyle: const TextStyle(fontSize: 16),
//                     ),
//                     child: const Text('Sudah memiliki akun? Masuk'),
//                   ),
//                   const SizedBox(height: 30),
//                   const SizedBox(height: 20),
//                   const SizedBox(height: 30),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }













// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Choose features'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Text('Choose features', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   // Image Generation
//                   Container(
//                     width: 120, // Lebar card
//                     height: 150, // Tinggi card
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.2),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         padding: EdgeInsets.all(20),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.image, color: Colors.purple),
//                           SizedBox(height: 10),
//                           Text('Image Generation', style: TextStyle(color: Colors.black)),
//                         ],
//                       ),
//                     ),
//                   ),
                  
//                   // Text Generation
//                   Container(
//                     width: 120, // Lebar card
//                     height: 150, // Tinggi card
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.2),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         padding: EdgeInsets.all(20),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.text_fields, color: Colors.purple),
//                           SizedBox(height: 10),
//                           Text('Text Generation', style: TextStyle(color: Colors.black)),
//                         ],
//                       ),
//                     ),
//                   ),
                  
//                   // Chart Generation
//                   Container(
//                     width: 120, // Lebar card
//                     height: 150, // Tinggi card
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.2),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         padding: EdgeInsets.all(20),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.bar_chart, color: Colors.purple),
//                           SizedBox(height: 10),
//                           Text('Chart Generation', style: TextStyle(color: Colors.black)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }







//tampilan chat
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Text Generation'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 // Picture
//                 child: Image.asset('assets/images/mondae3.png'), // Gambar acak dari aset
//               ),
//               SizedBox(height: 30),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     width: 150,
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.lightBlue,
//                         padding: EdgeInsets.symmetric(vertical: 15),
//                         textStyle: TextStyle(fontSize: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text('Create HTML', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//                           Text('HTML Code Gen', style: TextStyle(fontSize: 12, color: Colors.white)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 150,
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.lightBlue,
//                         padding: EdgeInsets.symmetric(vertical: 15),
//                         textStyle: TextStyle(fontSize: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text('JavaScript Code', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//                           Text('JavaScript Gen', style: TextStyle(fontSize: 12, color: Colors.white)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     width: 150,
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.lightBlue,
//                         padding: EdgeInsets.symmetric(vertical: 15),
//                         textStyle: TextStyle(fontSize: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text('Example PHP', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//                           Text('PHP Explanation', style: TextStyle(fontSize: 12, color: Colors.white)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 150,
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.lightBlue,
//                         padding: EdgeInsets.symmetric(vertical: 15),
//                         textStyle: TextStyle(fontSize: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text('What is OOP', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//                           Text('OOP Explanation', style: TextStyle(fontSize: 12, color: Colors.white)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 30),
//               Container(
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.image),
//                       onPressed: () {},
//                     ),
//                     Expanded(
//                       child: TextField(
//                         style: TextStyle(color: Colors.black), // Warna teks menjadi putih
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                           hintText: 'Type a message',
//                           hintStyle: TextStyle(color: Color.fromARGB(137, 78, 72, 72)), // Warna hint text menjadi putih agak transparan
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.send),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 10),
//               Divider(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
