import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GenerateChartScreen extends StatefulWidget {
  const GenerateChartScreen({super.key});

  @override
  GenerateChartScreenState createState() => GenerateChartScreenState();
}

class GenerateChartScreenState extends State<GenerateChartScreen> {
  final TextEditingController xAxisController = TextEditingController();
  final TextEditingController yAxisController = TextEditingController();
  List<FlSpot> dataPoints = [];

  void generateChart() {
    final xValues = xAxisController.text.split(',').map((e) => double.tryParse(e.trim())).toList();
    final yValues = yAxisController.text.split(',').map((e) => double.tryParse(e.trim())).toList();

    if (xValues.length == yValues.length && !xValues.contains(null) && !yValues.contains(null)) {
      dataPoints = List.generate(xValues.length, (index) => FlSpot(xValues[index]!, yValues[index]!));
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('X and Y values must have the same length and be valid numbers')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Chart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter X values (comma separated):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: xAxisController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'X Values',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            const Text(
              'Enter Y values (comma separated):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: yAxisController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Y Values',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: generateChart,
              child: const Text('Generate Chart'),
            ),
            const SizedBox(height: 16),
            if (dataPoints.isNotEmpty)
              Expanded(
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
        ),
      ),
    );
  }
}
