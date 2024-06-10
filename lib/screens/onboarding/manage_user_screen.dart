import 'package:flutter/material.dart';

class ManageUserScreen extends StatefulWidget {
  const ManageUserScreen({super.key});

  @override
  ManageUserScreenState createState() => ManageUserScreenState();
}

class ManageUserScreenState extends State<ManageUserScreen> {
  List<Subscription> subscriptions = [
    Subscription(userName: 'User 1', email: 'user1@example.com'),
    Subscription(userName: 'User 2', email: 'user2@example.com'),
    Subscription(userName: 'User 3', email: 'user3@example.com'),
  ];

  void _approveSubscription(int index) {
    setState(() {
      subscriptions[index] = Subscription(
        userName: subscriptions[index].userName,
        email: subscriptions[index].email,
        isApproved: true,
      );
    });
  }

  void _rejectSubscription(int index) {
    setState(() {
      subscriptions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage User Subscriptions'),
      ),
      body: ListView.builder(
        itemCount: subscriptions.length,
        itemBuilder: (context, index) {
          final subscription = subscriptions[index];
          return ListTile(
            title: Text(subscription.userName),
            subtitle: Text(subscription.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!subscription.isApproved)
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () => _approveSubscription(index),
                  ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () => _rejectSubscription(index),
                ),
              ],
            ),
            tileColor: subscription.isApproved ? Colors.green[50] : null,
          );
        },
      ),
    );
  }
}

class Subscription {
  final String userName;
  final String email;
  final bool isApproved;

  Subscription({
    required this.userName,
    required this.email,
    this.isApproved = false,
  });
}
