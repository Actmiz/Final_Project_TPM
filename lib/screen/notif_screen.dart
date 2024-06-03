import 'package:flutter/material.dart';

class NotifScreen extends StatelessWidget {
  final List<String> notifications;

  NotifScreen({required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notifications[index]),
          );
        },
      ),
    );
  }
}
