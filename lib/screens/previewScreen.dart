import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocr_app/screens/ResultScreen.dart';

class PreviewScreeen extends StatefulWidget {
  final File image;
  PreviewScreeen({this.image});

  @override
  _PreviewScreeenState createState() => _PreviewScreeenState();
}

class _PreviewScreeenState extends State<PreviewScreeen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Color scanLineColor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1),
        lowerBound: 40.0,
        upperBound: 450.0);
    //_controller.stop();
  }

  void triggerAnimation() {
    _controller.repeat(reverse: true);
    _controller.addListener(() {
      setState(() {
        //scanLineColor = Color(0xff6c63ff);
      });
      //print(_controller.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(widget.image);
    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();

    Future prevewText(String text) async {
      _controller.stop();
      setState(() {
        scanLineColor = null;
      });
      textRecognizer.close();
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResultScreen(
                    text: text,
                    //storage: Storage(),
                  )));
    }

    Future scanImage() async {
      setState(() {
        scanLineColor = Color(0xff6c63ff);
      });
      triggerAnimation();
      final VisionText visionText =
          await textRecognizer.processImage(visionImage);
      //String text = visionText.text;
      String totaltext = '';
      for (TextBlock block in visionText.blocks) {
        //final List<RecognizedLanguage> languages = block.recognizedLanguages;
        for (TextLine line in block.lines) {
          totaltext += '\n' + line.text;
        }
      }

      //print('Total:' + totaltext); //final text wih seperate lines
      await prevewText(totaltext);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white30,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xff6c63ff),
              size: 30.0,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: height * 0.7,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    // top: 0,
                    child: Center(
                        child: widget.image == null
                            ? Text('No image selected.')
                            : Image.file(
                                widget.image,
                                height: height * 0.6,
                              )),
                  ),
                  Positioned(
                      top: _controller.value == null ? 40 : _controller.value,
                      left: width * 0.1,
                      child: Container(
                          width: width * 0.8,
                          height: 5.0,
                          color: scanLineColor //Color(0xff6c63ff),
                          )),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      // offset:Offset(5.0, 5.0),
                      blurRadius: 15.0,
                    )
                  ],
                ),
                child: IconButton(
                    iconSize: 50.0,
                    icon: Icon(
                      Icons.search,
                      color: Color(0xff6c63ff),
                      size: 30.0,
                    ),
                    onPressed: scanImage)
                // color: Colors.blueAccent,

                ),
            Text(
              'OCR',
              style: GoogleFonts.poppins(fontSize: 15.0),
            ),
          ],
        ),
      )),
    );
  }
}
