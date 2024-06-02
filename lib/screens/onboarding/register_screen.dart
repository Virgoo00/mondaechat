import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Image.asset('assets/images/mondae_3.png', height: 100), // Ganti dengan gambar logo Anda
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Text(
                      'Create an Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              border: InputBorder.none,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Divider(
                            color: Colors.grey[300],
                            thickness: 1,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              border: InputBorder.none,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Divider(
                            color: Colors.grey[300],
                            thickness: 1,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'Confirm Password',
                              border: InputBorder.none,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // Implement registration logic here and navigate back to LoginScreen
                          Navigator.pop(context); // This will pop the RegisterScreen and return to LoginScreen
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6200EE),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Navigate back to login screen
                      },
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child: const Text('Sudah memiliki akun? Login'),
                    ),
                    const SizedBox(height: 30),
                    const SizedBox(height: 20),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: RegisterScreen(),
  ));
}





// KODE LAMA
// import 'package:flutter/material.dart';

// class RegisterScreen extends StatelessWidget {
//   const RegisterScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Register"),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Card(
//             elevation: 4,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const Text(
//                     'Create an Account',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     decoration: const InputDecoration(
//                       labelText: "Email",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     decoration: const InputDecoration(
//                       labelText: "Password",
//                       border: OutlineInputBorder(),
//                     ),
//                     obscureText: true,
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     decoration: const InputDecoration(
//                       labelText: "Confirm Password",
//                       border: OutlineInputBorder(),
//                     ),
//                     obscureText: true,
//                   ),
//                   const SizedBox(height: 32),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Implement registration logic here
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       textStyle: const TextStyle(fontSize: 16),
//                     ),
//                     child: const Text("Register"),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
