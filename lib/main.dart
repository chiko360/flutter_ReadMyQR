import 'package:flutter/material.dart';
import 'package:readmyqr/screens/create.dart';
import 'package:readmyqr/screens/scanner.dart';

import 'screens/home.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/scan': (context) => Scanner(),
        '/generate': (context) => Generate(),
      },
      home: Home(),
    );
  }
}
