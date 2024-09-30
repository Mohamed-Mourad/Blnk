import 'package:blnk_flutter/screens/create_account.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, primary: Colors.blue),
        useMaterial3: true,
      ),
      home: const CreateAccount(),
    );
  }
}
