import 'package:flutter/material.dart';
import 'payment_screen.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose Your Subscription Plan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SubscriptionPlanCard(
              planName: 'Basic Plan',
              price: '\$9.99 / month',
              features: const [
                'Feature 1',
                'Feature 2',
                'Feature 3',
              ],
              onSubscribe: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentScreen(
                      planName: 'Basic Plan',
                      price: '\$9.99 / month',
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            SubscriptionPlanCard(
              planName: 'Premium Plan',
              price: '\$19.99 / month',
              features: const [
                'Feature 1',
                'Feature 2',
                'Feature 3',
                'Feature 4',
                'Feature 5',
              ],
              onSubscribe: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentScreen(
                      planName: 'Premium Plan',
                      price: '\$19.99 / month',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionPlanCard extends StatelessWidget {
  final String planName;
  final String price;
  final List<String> features;
  final VoidCallback onSubscribe;

  const SubscriptionPlanCard({
    super.key,
    required this.planName,
    required this.price,
    required this.features,
    required this.onSubscribe,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(planName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(price, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
            const SizedBox(height: 10),
            ...features.map((feature) => Text('• $feature')),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: onSubscribe,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: const Text('Subscribe'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
