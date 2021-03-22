import 'package:starshelper_app/pages/auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  int count1 = 0;
  String textHolder = '';

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _userNameController = TextEditingController();

    return new Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
      Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
              child: Text(
                'Register',
                style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(235.0, 100.0, 0.0, 0.0),
              child: Text(
                '.',
                style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan),
              ),
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
                    // hintText: 'EMAIL',
                    // hintStyle: ,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan))),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                    labelText: 'USERNAME ',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan))),
                obscureText: true,
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: 'PASSWORD ',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan))),
                obscureText: true,
              ),
              SizedBox(
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '$textHolder',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.cyanAccent,
                    color: Colors.cyan,
                    elevation: 5.0,
                    child: FlatButton(
                      onPressed: () {
                        String email = _emailController.text;
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(email);
                        if (emailValid &&
                            _passwordController.text.length <= 6) {
                          Map<String, dynamic> registerdata = {
                            'email': _emailController.text
                                .toLowerCase(), // email always stored in lower cases
                            'password': _passwordController.text,
                            'username': _userNameController.text,
                          };
                          try {
                            CollectionReference collectionReference =
                                FirebaseFirestore.instance.collection('login');
                            collectionReference
                                .add(registerdata)
                                .timeout(Duration(seconds: 10));

                            setState(() {
                              textHolder = 'Registered Successfully';
                            });
                          } catch (error) {
                            AlertDialog ad = AlertDialog(
                              title: Text('Error: '),
                              content: Text(error.toString()),
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ad;
                              },
                            );
                          }
                        } else {
                          setState(() {
                            textHolder =
                                'Invalid Email or Password length less than 6.';
                          });
                        }
                      },
                      child: Center(
                        child: Text(
                          'REGISTER',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  )),
              SizedBox(height: 20.0),
              Container(
                height: 40.0,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1.0),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => AuthPage()));
                    },
                    child: Center(
                      child: Text('Back',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat')),
                    ),
                  ),
                ),
              ),
            ],
          )),
    ]));
  }
}
