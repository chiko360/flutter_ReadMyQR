import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final String destination;
  Button({this.title, this.destination});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10),
              textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.pushNamed(context, destination);
          },
          child: FittedBox(child: Text(title))),
    );
  }
}
