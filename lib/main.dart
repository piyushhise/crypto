import 'package:crypto_demo/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CryptoDemoApp());
}

class CryptoDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
