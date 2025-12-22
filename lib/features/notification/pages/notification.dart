import 'package:flutter/material.dart';
import 'package:yatra/main.dart';

class Notifications extends StatelessWidget {
  NotificationsPayLoad? notificationsPayLoad;
  Notifications({super.key, this.notificationsPayLoad});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: Column(
        children: [
          Card(
            child: Column(
              children: [
                Text("${notificationsPayLoad?.title}"),
                Text("${notificationsPayLoad?.body}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
