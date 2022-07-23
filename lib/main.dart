import 'package:flutter/material.dart';

void main() {
  runApp(const PosterrApp());
}

class PosterrApp extends StatelessWidget {
  const PosterrApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posterr',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SizedBox(),
    );
  }
}
