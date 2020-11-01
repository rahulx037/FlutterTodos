import 'package:flutter/material.dart';

class SlideTile extends StatelessWidget {
  String desc;

  SlideTile({this.desc});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 150,
            ),
            Text(desc, textAlign: TextAlign.center,style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20
            ),)
          ],
        ),
      ),
    );
  }
}