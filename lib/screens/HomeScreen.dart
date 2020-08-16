import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr_app/screens/previewScreen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    //print(height);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: width * 0.1, right: width * 0.1, top: height * 0.05),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: height * 0.5,
              child: SvgPicture.asset(
                'assets/images/ocr.svg',
                height: height * 0.55,
                width: width * 0.45,
              ),
            ),
            Text(
              'OCR',
              style: GoogleFonts.poppins(
                  fontSize: 30.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              'Instantly Convert your picture\ninto text without typing',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: height<=715?14.0:17.0, letterSpacing: 2.0
                  // fontWeight: FontWeight.bold
                  ),
            ),
            SizedBox(
              height: height * 0.07,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CircularCameraButton(),
                CircularGalleryButton()
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CircularCameraButton extends StatefulWidget {
  // final IconData icon;
  // final Future onPress;
  const CircularCameraButton({
    // this.icon,
    // this.onPress,
    Key key,
  }) : super(key: key);

  @override
  _CircularCameraButtonState createState() => _CircularCameraButtonState();
}

class _CircularCameraButtonState extends State<CircularCameraButton> {
  @override
  Widget build(BuildContext context) {
    File _image;
    // final picker = ImagePicker();
    Future<void> getImagefromCamera() async {
      final pickedFile =
          await ImagePicker().getImage(source: ImageSource.camera);
      setState(() {
        _image = File(pickedFile.path);
      });
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PreviewScreeen(
                    image: _image,
                  )));
    }

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
              ]
              // color: Colors.blueAccent,
              ),
          child: IconButton(
              iconSize: 50.0,
              icon: Icon(
                Icons.camera_alt,
                color: Color(0xff6c63ff),
                size: 30.0,
              ),
              onPressed: getImagefromCamera),
        ),
        Text(
          'Camera',
          style: GoogleFonts.poppins(fontSize: 15.0),
        )
      ],
    );
  }
}

class CircularGalleryButton extends StatefulWidget {
  const CircularGalleryButton({
    Key key,
  }) : super(key: key);

  @override
  _CircularGalleryButtonState createState() => _CircularGalleryButtonState();
}

class _CircularGalleryButtonState extends State<CircularGalleryButton> {
  @override
  Widget build(BuildContext context) {
    File _image;
    Future<void> getImagefromGallery() async {
      final pickedFile =
          await ImagePicker().getImage(source: ImageSource.gallery);
      setState(() {
        _image = File(pickedFile.path);
      });
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PreviewScreeen(
                    image: _image,
                  )));
    }

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
              ]
              // color: Colors.blueAccent,
              ),
          child: IconButton(
              iconSize: 50.0,
              icon: Icon(
                Icons.filter,
                color: Color(0xff6c63ff),
                size: 30.0,
              ),
              onPressed: getImagefromGallery),
        ),
        Text(
          'Gallery',
          style: GoogleFonts.poppins(fontSize: 15.0),
        )
      ],
    );
  }
}
