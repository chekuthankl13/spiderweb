import 'package:flutter/material.dart';
import 'package:spiderweb/utils/utils.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 50,
        ),
        spaceHeight(10),
       const Text("failed to connect with mssql server !!")
      ],
    ),
  ),
    );
  }
}