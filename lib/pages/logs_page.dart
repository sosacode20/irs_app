import 'package:flutter/material.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({Key? key}) : super(key: key);

  static String routeName = '/logs';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.green,
        ),
      ),
    );
  }
}
