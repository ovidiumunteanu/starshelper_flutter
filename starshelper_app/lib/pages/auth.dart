import 'package:starshelper_app/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:starshelper_app/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:starshelper_app/sidebar/sidebar_layout.dart';
import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:starshelper_app/pages/Slidermain.dart';
import '../utils/global.dart';
import '../pages/homepage.dart';
import '../pages/timetable/index.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    await prefs.setString('userName', Global().appData["userName"]);
    await prefs.setString('userEmail', Global().appData["userEmail"]);
    
    if (_seen) {
      Global().appData["sidebar_initpage"] = HomePage(); //TTHomePage(title: ""); 
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => new SideBarLayout()), (route)=>false);
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => new Walkthrough()), (route)=>false);
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
          child: LoadingBouncingGrid.circle(
        borderColor: Colors.blue,
        borderSize: 6.0,
        size: 60.0,
        backgroundColor: Colors.cyanAccent,
        duration: Duration(seconds: 5),
      )),
    );
  }
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('IntroScreen'),
      ),
      body: new Center(
        child: new Text('This is the IntroScreen'),
      ),
    );
  }
}

class AuthPage extends StatefulWidget with NavigationStates {
  @override
  _AuthPageState createState() => new _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  int count = 0;
  // To be changed by login info

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkLoggedIn();
  }

  checkLoggedIn () async {
    print('checkLoggedIn');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print("aaaaaa" + prefs.getString('userEmail') );

    if(prefs.getString('userEmail') != null) {
      Global().appData["userEmail"] = prefs.getString('userEmail');
      Global().appData["userName"] = prefs.getString('userName');
      Navigator.push(context,  MaterialPageRoute(builder: (context) => Splash()), );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    return new Scaffold(
        body: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                child: Text('StarsHelper',
                    style:
                        TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(300.0, 100.0, 0.0, 0.0),
                child: Text('.',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
              )
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: 'PASSWORD',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                  obscureText: true,
                ),
                SizedBox(height: 5.0),
                Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 15.0, left: 20.0),
                  child: InkWell(
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                Container(
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.blueAccent,
                    color: Colors.blue,
                    elevation: 7.0,
                    child: FlatButton(
                      onPressed: () {
                        Stream<QuerySnapshot> snapshot = FirebaseFirestore
                            .instance
                            .collection('login')
                            .where('email',
                                isEqualTo: _emailController.text.toLowerCase())
                            .where('password',
                                isEqualTo: _passwordController.text)
                            .snapshots();
                        snapshot.forEach((element) {
                          if (element.docs.isNotEmpty) {
                            count++;
                          }
                          print(count);
                          if (count == 0) {
                            print(count); // for debug
                            AlertDialog ad = AlertDialog(
                              title: Text('Login Failed'),
                              content: Text('Incorrect Email or Password'),
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ad;
                              },
                            );
                          } else {
                            element.docs.asMap().forEach((index, data) {
                              Global().appData["userName"] =
                                  element.docs[index]["username"];
                            });

                            Global().appData["userEmail"] =
                                _emailController.text;

                            count = 0;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Splash()),
                            );
                            return;
                          }
                        });
                      },
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
        SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 5.0),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SignupPage()));
              },
              child: Text(
                'Register',
                style: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
            )
          ],
        )
      ],
    )));
  }
}
