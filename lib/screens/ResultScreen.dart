import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocr_app/utils/FileSystem.dart';

class ResultScreen extends StatefulWidget {
  final String text;
  ResultScreen({
    this.text,
  });

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

IconData saveIcon = Icons.save_alt;
Color saveColor = Color(0xff6c63ff);
String saveText = "Save";

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    //Storage storage;

    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    reTakeImage() {
      Navigator.popUntil(
          context, ModalRoute.withName(Navigator.defaultRouteName));
      setState(() {
        saveIcon = Icons.save_alt;
        saveColor = Color(0xff6c63ff);
        saveText = "Save";
      });
    }

    saveTotext() {
      Storage.writeText(widget.text);
      setState(() {
        saveIcon = Icons.check;
        saveColor = Colors.green;
        saveText = "Saved";
      });
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
              onPressed: () {
                setState(() {
                  saveIcon = Icons.save_alt;
                  saveColor = Color(0xff6c63ff);
                  saveText = "Save";
                });
                Navigator.pop(context);
              }),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: widget.text != ''
                  ? Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: height * 0.05),
                      padding: EdgeInsets.all(20.0),
                      //color: Colors.amber,
                      height: height * 0.65,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10.0,
                                color: Colors.grey[300],
                                offset: Offset(0, 5.0))
                          ]
                          //border: Border.all(),
                          //borderRadius: BorderRadius.circular(20.0)
                          ),
                      child: SingleChildScrollView(
                        child: SelectableText(
                          widget.text,
                          style: GoogleFonts.poppins(
                              fontSize: 15.0, letterSpacing: 2.0
                              // fontWeight: FontWeight.bold
                              ),
                        ),
                      ),
                    )
                  : Column(
                      children: <Widget>[
                        Container(
                          width: width * 0.8,
                          height: height * 0.5,
                          child: SvgPicture.asset(
                            'assets/images/error.svg',
                            //  height: height * 0.55,
                            //  width: width * 0.45,
                          ),
                        ),
                        Text(
                          "Can't extract text from this Image\nUnsupported language or wrong image",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 17.0, fontWeight: FontWeight.w600,color: Colors.red),
                        ),
                        SizedBox(
                          height: height * 0.1,
                        ),
                      ],
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircularButton(
                  icon: saveIcon,
                  iconLabel: saveText,
                  onPress: saveTotext,
                  iconColor: saveColor,
                ),
                CircularButton(
                  icon: Icons.refresh,
                  iconLabel: 'Retake',
                  onPress: reTakeImage,
                  iconColor: Color(0xff6c63ff),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}

class CircularButton extends StatelessWidget {
  final IconData icon;
  final Function onPress;
  final String iconLabel;
  final Color iconColor;
  CircularButton({this.icon, this.onPress, this.iconLabel, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
                  icon,
                  color: iconColor,
                  size: 30.0,
                ),
                onPressed: onPress)
            // color: Colors.blueAccent,
            ),
        Text(
          iconLabel,
          style: GoogleFonts.poppins(fontSize: 15.0),
        )
      ],
    );
  }
}
