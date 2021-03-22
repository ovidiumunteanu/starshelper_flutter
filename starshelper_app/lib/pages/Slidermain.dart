import 'package:flutter/material.dart';
import 'dart:io';
import '../models/slider_model.dart';
import '../sidebar/sidebar_layout.dart';

class Walkthrough extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App Onboarding",
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<SliderModel> slides = new List<SliderModel>();
  int currentIndex = 0;
  PageController pageController = new PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slides = getSlides();
  }

  Widget pageIndexIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: pageController,
        onPageChanged: (val) {
          setState(() {
            currentIndex = val;
          });
        },
        itemBuilder: (context, index) {
          return SliderTile(
            imageAssetPath: slides[index].imagePath,
            title: slides[index].title,
            description: slides[index].description,
          );
        },
        itemCount: slides.length,
      ),
      bottomSheet: currentIndex != slides.length - 1
          ? Container(
              height: Platform.isIOS ? 70 : 60,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      pageController.animateToPage(
                        slides.length - 1,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.linear,
                      );
                    },
                    child: Text("SKIP"),
                  ),
                  Row(
                    children: <Widget>[
                      for (int i = 0; i < slides.length; i++)
                        currentIndex == i
                            ? pageIndexIndicator(true)
                            : pageIndexIndicator(false)
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      pageController.animateToPage(
                        currentIndex + 1,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.linear,
                      );
                    },
                    child: Text("NEXT"),
                  ),
                ],
              ),
            )
          : Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: Platform.isIOS ? 70 : 60,
              color: Colors.blue,
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (context) => new SideBarLayout()));
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    'GET STARTED NOW',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class SliderTile extends StatelessWidget {
  //initialising variables here
  String imageAssetPath;
  String title;
  String description;

  SliderTile({this.imageAssetPath, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 110),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(imageAssetPath, height: 200),
          SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
