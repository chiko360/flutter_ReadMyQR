import 'package:flutter/material.dart';
import 'package:readmyqr/constants.dart';
import 'package:readmyqr/widgets/button.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = displayWidth(context);
    var height = displayHeight(context);
    var orientation = displayOrientation(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Read my QR'),
      ),
      body: Container(
        width: double.infinity,
        child: (orientation == 0)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Image.asset(
                    'assets/images/home.png',
                    height: width / 2,
                    width: width / 2,
                  ),
                  Spacer(),
                  Button(
                    title: 'scan a Qr',
                    destination: '/scan',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Button(
                    title: 'Generate a Qr',
                    destination: '/generate',
                  ),
                  Spacer(),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/images/home.png',
                    height: height / 1.7,
                    width: height / 1.7,
                  ),
                  Column(
                    children: [
                      Spacer(),
                      Button(
                        title: 'scan a Qr',
                        destination: '/scan',
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Button(
                        title: 'Generate a Qr',
                        destination: '/generate',
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
