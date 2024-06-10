import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chart Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GenerateChartScreen(),
    );
  }
}

class GenerateChartScreen extends StatefulWidget {
  const GenerateChartScreen({super.key});

  @override
  GenerateChartScreenState createState() => GenerateChartScreenState();
}

class GenerateChartScreenState extends State<GenerateChartScreen> {
  final TextEditingController keywordController = TextEditingController();
  final List<Map<String, dynamic>> messages = [];
  List<FlSpot> dataPoints = [];
  bool isLoading = false;
  final String apiKey = '9SK2B21H2PEPEZ28'; // Ganti dengan API key Anda

  Future<void> fetchChartData(String keyword) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$keyword&apikey=$apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final timeSeries = data['Time Series (Daily)'] as Map<String, dynamic>;

        final xValues = <double>[];
        final yValues = <double>[];
        int count = 0;

        timeSeries.forEach((date, value) {
          if (count < 30) { // Mengambil data 30 hari terakhir
            final double closePrice = double.parse(value['4. close']);
            xValues.add(count.toDouble());
            yValues.add(closePrice);
            count++;
          }
        });

        if (xValues.length == yValues.length) {
          setState(() {
            dataPoints = List.generate(xValues.length, (index) => FlSpot(xValues[index], yValues[index]));
            messages.add({
              "text": "Generated chart for symbol: $keyword",
              "sender": "system",
              "keyword": keyword
            });
          });
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data mismatch between X and Y values')));
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to fetch data')));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('An error occurred while fetching data')));
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void generateChart(String keyword) {
    if (keyword.isNotEmpty) {
      fetchChartData(keyword);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a keyword')));
    }
  }

  void _sendMessage(String text) {
    setState(() {
      messages.add({"text": text, "sender": "user", "keyword": text});
    });
    keywordController.clear();
    generateChart(text); // Generate chart based on user input
  }

  void _editMessage(int index, String newText) {
    setState(() {
      messages[index]['text'] = newText;
      messages[index]['keyword'] = newText;
    });
    generateChart(newText); // Generate chart based on the new user input
  }

  void _deleteMessage(int index) {
    setState(() {
      messages.removeAt(index);
      dataPoints = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: const Text(
          'Generate Chart',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Dismissible(
                  key: Key(message['text']),
                  onDismissed: (direction) {
                    _deleteMessage(index);
                  },
                  background: Container(color: Colors.red),
                  child: message["sender"] == "user"
                      ? _buildUserMessage(message["text"]!, index)
                      : _buildSystemMessage(message["text"]!, message["keyword"]!, index),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: keywordController,
                    decoration: InputDecoration(
                      hintText: 'Type your stock symbol...',
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
                    if (keywordController.text.isNotEmpty) {
                      _sendMessage(keywordController.text);
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

  Widget _buildUserMessage(String text, int index) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onLongPress: () async {
          final newText = await _showEditDialog(text);
          if (newText != null) {
            _editMessage(index, newText);
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            text,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildSystemMessage(String text, String keyword, int index) {
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
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage('assets/images/mondae_2.png'), // Updated line
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onLongPress: () async {
                          final newText = await _showEditDialog(keyword);
                          if (newText != null) {
                            _editMessage(index, newText);
                          }
                        },
                        child: Text(
                          text,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
                      isLoading
                          ? const SpinKitCircle(
                              color: Colors.blue,
                              size: 50.0,
                            )
                          : _buildChart(),
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

  Future<String?> _showEditDialog(String currentText) async {
    TextEditingController editController = TextEditingController(text: currentText);

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Message'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(hintText: 'Enter new text'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, editController.text);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildChart() {
    return Column(
      children: [
        const Text(
          'Closing Prices',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 300,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: dataPoints,
                  isCurved: true,
                  barWidth: 2,
                  colors: [Colors.blue],
                  belowBarData: BarAreaData(show: true, colors: [Colors.blue.withOpacity(0.3)]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Code Lama
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Chart Generator',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const GenerateChartScreen(),
//     );
//   }
// }

// class GenerateChartScreen extends StatefulWidget {
//   const GenerateChartScreen({super.key});

//   @override
//   GenerateChartScreenState createState() => GenerateChartScreenState();
// }

// class GenerateChartScreenState extends State<GenerateChartScreen> {
//   final TextEditingController keywordController = TextEditingController();
//   final List<Map<String, dynamic>> messages = [];
//   List<FlSpot> dataPoints = [];
//   bool isLoading = false;
//   final String apiKey = '9SK2B21H2PEPEZ28'; // Ganti dengan API key Anda

//   Future<void> fetchChartData(String keyword) async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final response = await http.get(
//         Uri.parse('https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$keyword&apikey=$apiKey'),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body) as Map<String, dynamic>;
//         final timeSeries = data['Time Series (Daily)'] as Map<String, dynamic>;

//         final xValues = <double>[];
//         final yValues = <double>[];
//         int count = 0;

//         timeSeries.forEach((date, value) {
//           if (count < 30) { // Mengambil data 30 hari terakhir
//             final double closePrice = double.parse(value['4. close']);
//             xValues.add(count.toDouble());
//             yValues.add(closePrice);
//             count++;
//           }
//         });

//         if (xValues.length == yValues.length) {
//           setState(() {
//             dataPoints = List.generate(xValues.length, (index) => FlSpot(xValues[index], yValues[index]));
//             messages.add({
//               "text": "Generated chart for symbol: $keyword",
//               "sender": "system",
//               "keyword": keyword
//             });
//           });
//         } else {
//           if (mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data mismatch between X and Y values')));
//           }
//         }
//       } else {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to fetch data')));
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('An error occurred while fetching data')));
//       }
//     }

//     if (mounted) {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   void generateChart(String keyword) {
//     if (keyword.isNotEmpty) {
//       fetchChartData(keyword);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a keyword')));
//     }
//   }

//   void _sendMessage(String text) {
//     setState(() {
//       messages.add({"text": text, "sender": "user", "keyword": text});
//     });
//     keywordController.clear();
//     generateChart(text); // Generate chart based on user input
//   }
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       backgroundColor: Colors.blue[100],
//       title: Text(
//         'Generate Chart',
//         style: TextStyle(color: Colors.black),
//       ),
//     ),
//     body: Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Expanded(
//           child: ListView.builder(
//             itemCount: messages.length,
//             itemBuilder: (context, index) {
//               final message = messages[index];
//               return message["sender"] == "user"
//                   ? _buildUserMessage(message["text"]!)
//                   : _buildSystemMessage(message["text"]!, message["keyword"]!);
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: Row(
//             children: [
//               const SizedBox(width: 16),
//               Expanded(
//                 child: TextField(
//                   controller: keywordController,
//                   decoration: InputDecoration(
//                     hintText: 'Type your stock symbol...',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   ),
//                   onSubmitted: _sendMessage,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   if (keywordController.text.isNotEmpty) {
//                     _sendMessage(keywordController.text);
//                   }
//                 },
//                 child: const Icon(Icons.send),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

//   Widget _buildUserMessage(String text) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.blue[100],
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Text(
//           text,
//           style: const TextStyle(color: Colors.black),
//         ),
//       ),
//     );
//   }

//   Widget _buildSystemMessage(String text, String keyword) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.grey[100],
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const CircleAvatar(
//                   backgroundColor: Colors.grey,
//                   backgroundImage: AssetImage('assets/images/mondae_2.png'), // Updated line
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         text,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 8),
//                       isLoading
//                           ? const SpinKitCircle(
//                               color: Colors.blue,
//                               size: 50.0,
//                             )
//                           : _buildChart(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildChart() {
//     return Column(
//       children: [
//         const Text(
//           'Closing Prices',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(
//           height: 300,
//           child: LineChart(
//             LineChartData(
//               lineBarsData: [
//                 LineChartBarData(
//                   spots: dataPoints,
//                   isCurved: true,
//                   barWidth: 2,
//                   colors: [Colors.blue],
//                   belowBarData: BarAreaData(show: true, colors: [Colors.blue.withOpacity(0.3)]),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
