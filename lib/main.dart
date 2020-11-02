import 'package:flutter/material.dart';
import 'package:flutter_todo_app/dashboard.dart';
import 'package:flutter_todo_app/intro/SlideTile.dart';
import 'package:flutter_todo_app/intro/slider_model.dart';
import 'dart:io';

import 'package:flutter_todo_app/intro/upperTile.dart';
import 'package:swipedetector/swipedetector.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Intro()));

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  List<SliderModel> mySLides = new List<SliderModel>();
  int slideIndex = 0;
  PageController controller;

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySLides = getSlides();
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        routes: {
          '/dashboard': (context) => Dashboard(),
        },
        home: Scaffold(
            body: Container(
              color: Colors.white,
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    slideIndex = index;
                  });
                },
                children: <Widget>[
                  Expanded(flex: 1,
                      child: Container(
                        child: Center(child: Text.rich(
                            TextSpan(
                                text: 'Welcome to ',
                                style: TextStyle(
                                  fontSize: 30
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'Clear',
                                    style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),
                                  )
                                ]
                            )
                        )),
                      )),

                  SlideTile(
                    desc: mySLides[0].getDesc(),
                  ),
                  SlideTile(
                    desc: mySLides[1].getDesc(),
                  ),
                  SlideTile(
                    desc: mySLides[2].getDesc(),
                  ),

                ],
              ),
            ),
            bottomSheet: getChild(slideIndex),


    ),);
  }

  Widget getChild(int index) {
    switch (index) {
      case 0:
        {
          return Container(
            height: Platform.isIOS ? 70 : 60,
            color: Colors.white,
            alignment: Alignment.center,
            child: Text(
              "GET STARTED NOW",
              style: TextStyle(
                fontSize: 25,
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          );
        }
        break;
      case 1:{
       return SwipeDetector(
         swipeConfiguration: SwipeConfiguration(
             horizontalSwipeMaxHeightThreshold: 50.0,
             horizontalSwipeMinDisplacement:50.0,
             horizontalSwipeMinVelocity: 100.0),
         onSwipeLeft: () {
           controller.animateToPage(slideIndex + 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
         },
         onSwipeRight: (){
           controller.animateToPage(slideIndex - 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
         },
         child: Container(
           color: Colors.white,
           height: 350,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               SizedBox(
                 height: 30,
               ),
               Container(
                 alignment: Alignment.center,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     for (int i = 0; i < 3; i++)
                       i == slideIndex
                           ? _buildPageIndicator(true)
                           : _buildPageIndicator(false),
                   ],
                 ),
               ),
               UpTile(imagePath:mySLides[1].getImageAssetPath()),
             ],
           ),
         ),
       );
      }
      break;
      case 2:
        {
          return SwipeDetector(
            swipeConfiguration: SwipeConfiguration(
                horizontalSwipeMaxHeightThreshold: 50.0,
                horizontalSwipeMinDisplacement:50.0,
                horizontalSwipeMinVelocity: 100.0),
            onSwipeLeft: () {
              controller.animateToPage(slideIndex + 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
            },
            onSwipeRight: (){
              controller.animateToPage(slideIndex - 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
            },
            child: Container(
              color: Colors.white,
              height: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 3; i++)
                          i == slideIndex
                              ? _buildPageIndicator(true)
                              : _buildPageIndicator(false),
                      ],
                    ),
                  ),
                  UpTile(imagePath:mySLides[2].getImageAssetPath()),
                ],
              ),
            ),
          );
        }
        break;
      case 3:{
        return InkWell(
          onTap: (){
            _sendToOtpPage();
          },
          child: Container(
            height: Platform.isIOS ? 70 : 60,
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text(
              "GET STARTED NOW",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        );
      }
      break;
    }
  }

  void _sendToOtpPage() {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new Dashboard()),
    );
  }
}
