import 'package:flutter/material.dart';

class UpTile extends StatelessWidget {
  String imagePath;

  UpTile({this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white,
        child: Image.asset(imagePath),
      ),
    );
  }
}