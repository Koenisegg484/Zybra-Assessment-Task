import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Colors
Color lightPink = const Color(0xfef5bbfd);
Color lightGreen = Color(0xff6ffa60);
Color lightPurple = Color(0xff606dfa);
Color lightRed = Color(0xfffa6363);
Color lightYellow = Color(0xfffadb60);


// Padding
EdgeInsets miniPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10);
EdgeInsets mediumPadding = const EdgeInsets.symmetric(horizontal: 20, vertical: 20);


// Spacing between widgets
Widget miniSpacing = const SizedBox(width: 6);
Widget mediumSpacingHeight = const SizedBox(height: 16);

BorderRadius BR50 = const BorderRadius.all(Radius.circular(50));


//Icons
Widget whiteSimpleIcon({required IconData icondata}){
  return Icon(icondata, color: Colors.white);
}

Widget tagHeading({required Color color, required Icon icondata, required String title}){
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: icondata,
      ),
      const SizedBox(
        width: 10,
      ),
      Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 25,
            color: Colors.black),
      )
    ],
  );
}