import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:portfolio/styles/color_constants.dart';


class Resume extends StatelessWidget {
  Resume({super.key});

  final resumePDF = PdfDocument.openAsset('jack_curtin_resume_july_2024.pdf');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Spacer(flex: 5,),
          GestureDetector(
            onTap: () => print("ok"),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.black,
              child: Icon(
                Icons.picture_as_pdf,
                color: ColorConstants.mainBlue,
              ),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () => print("download pdf"),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.black,
              child: Icon(
                Icons.download,
                color: ColorConstants.mainBlue,
              ),
            ),
          ),
          Spacer(flex: 5,),
        ],
      ),
    );
  }
}