import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Generate extends StatefulWidget {
  @override
  _GenerateState createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  @override
  Widget build(BuildContext context) {
    var width = displayWidth(context);
    print('rebuilt');
    String _word;
    return Scaffold(
      appBar: AppBar(
        title: Text('create a QR code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _word = value;
                });
                print(_word);
              },
              decoration: InputDecoration(
                hintText: 'enter some text to generate a QR',
                border: OutlineInputBorder(),
              ),
            ),
            _word != null
                ? CustomPaint(
                    size: Size.square(width / 2),
                    painter: QrPainter(
                      data: _word,
                      version: QrVersions.auto,
                    ))
                : Container(),
          ],
        ),
      ),
    );
  }
}
