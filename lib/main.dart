import 'package:flutter/material.dart';
import 'package:readmyqr/scanner.dart';

import 'home.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/scan': (context) => Scanner(),
        '/generate': (context) => Scanner(),
      },
      home: Home(),
    );
  }
}
