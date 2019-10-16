import 'package:flutter/material.dart';
import 'package:product/home.dart';
import 'package:product/signup.dart';

class Login extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<Login> {
  final teemail = TextEditingController();
  final tepassword = TextEditingController();

  bool _emailvalidate = false;
  bool _passwordvalidate = false;

  @override
  void dispose() {
    teemail.dispose();
    tepassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    final emailfield = TextField(
      controller: teemail,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "email",
          errorText: _emailvalidate ? " the email address is not valid" : null,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      obscureText: true,
      controller: tepassword,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          errorText:
              _passwordvalidate ? "password field cannot be empty" : null,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButton = Material(
      elevation: 5.0,
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          setState(() {
            if (teemail.text.isEmpty) {
              _emailvalidate = true;
            } else {
              _emailvalidate = false;
            }
            ;
            tepassword.text.isEmpty
                ? _passwordvalidate = true
                : _passwordvalidate = false;
          });
          if (_passwordvalidate == false && (_emailvalidate == false)) {
//
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (ctxt) => new MyHomePage(title: "product database")),
            );
          } else {
            print(teemail.text);
            print(tepassword.text);
          }
        },
        child: Text("login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login to your List"),
      ),
      body: Center(
        child: SingleChildScrollView(
        child: Container(
          //color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 45.0),
                emailfield,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButton,
                SizedBox(height: 15.0),
                GestureDetector(
                    child: Text("Click here to register",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
