import 'package:flutter/material.dart';
import 'package:ocr_app/screens/HomeScreen.dart';

void main() {
  runApp(OCRapp());
}

class OCRapp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'OCR_APP',
        theme: ThemeData.light(),
        home: SafeArea(child: HomeScreen()));
  }
}
