import 'package:flutter/material.dart';

class TodoHomeScreen extends StatelessWidget {
  const TodoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Your Tasks", maxLines: 2),
      ),
      body: const SafeArea(
        child: Center(
          child: Text("Hello TODO App"),
        ),
      ),
    );
  }
}
