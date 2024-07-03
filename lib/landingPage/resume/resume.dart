import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/styles/color_constants.dart';


class Resume extends StatelessWidget {
  Resume({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Spacer(flex: 5,),
          GestureDetector(
            onTap: () => context.go("/cv"),
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