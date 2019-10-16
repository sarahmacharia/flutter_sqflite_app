import 'package:flutter/material.dart';
import 'package:product/homescreen.dart';
import 'package:product/user.dart';
import 'package:product/login.dart';
import 'package:product/home_page.dart';
import 'package:product/signup.dart';

void main() => runApp(new MyApp());


final routes = {
  '/login': (BuildContext context) => new SignupPage(),
  '/home': (BuildContext context) => new HomePage(),
  '/': (BuildContext context) => new SignupPage(),
};

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Database',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor:  const Color(0xFF02BB9F),
        primaryColorDark: const Color(0xFF167F67),
        accentColor: const Color(0xFFFFAD32),
      ),
//      home: new MyHomePage(title: 'Product Database'),
      home: new Login(),
    );
  }


}


