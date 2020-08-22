import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocr_app/utils/FileSystem.dart';

class BottomSheetScreen extends StatefulWidget {
  final Function saveFile;
  BottomSheetScreen({this.saveFile});

  @override
  _BottomSheetScreenState createState() => _BottomSheetScreenState();
}

class _BottomSheetScreenState extends State<BottomSheetScreen> {
  // TextEditingController _controller;
  @override
  // void initState() {
  //   super.initState();
  //   _controller = TextEditingController();
  // }

  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    String fileName;
    return Container(
        color: Color(0xff757575),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
              vertical: MediaQuery.of(context).size.width * 0.05),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0))),
          child: Column(
            children: [
              TextField(
                //autofocus: true,
                decoration: InputDecoration(
                  labelText: "Enter File Name",
                  labelStyle: GoogleFonts.poppins(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                    ),
                  contentPadding: EdgeInsets.only(left: 10.0,right: 10.0),

                ),
                onChanged: (file) {
                  fileName = file;
                },
              ),
              SizedBox(height: 20.0,),
              FlatButton(
                  color: Color(0xff6c63ff),
                  child: Text("Save",
                    style: GoogleFonts.poppins(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                    ),
                  
                  onPressed: () {
                    widget.saveFile(fileName);
                    Navigator.pop(context);
                  }
                ),
                Text('Your File will be saved in:\nstorage/android/data/\ncom.palSitabja.ocr_app/files',
                  textAlign: TextAlign.center,
                  style:GoogleFonts.poppins(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ) ,
                
            ],
          ),
        ));
  }
}
