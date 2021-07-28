import 'package:flutter/material.dart';

Size displaySize(BuildContext context) {
  //debugPrint('Size = ' + MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  //debugPrint('Height = ' + displaySize(context).height.toString());
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  //debugPrint('Width = ' + displaySize(context).width.toString());
  return displaySize(context).width;
}

int displayOrientation(BuildContext context) {
  //debugPrint('orientation = ' + MediaQuery.of(context).orientation.toString());
  return MediaQuery.of(context).orientation.index;
}
