import 'package:flutter/material.dart';
import './pages/auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) => 
    runApp(MyApp())
  )
  .catchError((err) => {
    print(err)
  });
  
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,scaffoldBackgroundColor: Colors.white, primaryColor: Colors.white
      ),
      home: AuthPage(),
    );
  }
}
