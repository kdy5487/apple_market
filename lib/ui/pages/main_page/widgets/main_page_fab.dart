import 'package:flutter/material.dart';

class MainPageFab extends StatelessWidget {
  const MainPageFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Implement the action for the FAB
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('FAB Pressed')));
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.blue,
    );
  }
}
