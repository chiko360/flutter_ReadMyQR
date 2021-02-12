import 'package:flutter/material.dart';
import 'package:readmyqr/widgets/button.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read my QR'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              title: 'scan a Qr',
              destination: '/scan',
            ),
            SizedBox(
              height: 10,
            ),
            Button(
              title: 'Generate a Qr',
              destination: '/generate',
            )
          ],
        ),
      ),
    );
  }
}
