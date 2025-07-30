import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center( 
      child: Text("news",style: TextStyle(color: Colors.white,fontSize: 20)),
    );
  }
}