import 'package:flutter/material.dart';
import 'package:product/home_presenter.dart';
import 'package:product/database/database_helper.dart';
import 'package:product/product.dart';
import 'package:product/user.dart';
import 'package:product/home.dart';


class Login extends StatelessWidget {


  @override
  Widget build (BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    final usernamefield= TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );





    final passwordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButton = Material(
      elevation: 5.0,
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery
            .of(context)
            .size
            .width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
//
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (ctxt) => new MyHomePage(title: "product database")),);

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
        child: Container(
          //color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                SizedBox(height: 45.0),

                usernamefield,
                SizedBox(height: 25.0),

                passwordField,
                SizedBox(
                  height: 35.0,
                ),

                loginButton,
                SizedBox(
                    height: 15.0),
                GestureDetector(
                    child: Text("Click here to register", style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("product database"),
      ),
      body: new Text("Another Page...!!!!!!"),
    );
  }
}




class Register extends StatelessWidget {

  final tefirstname = TextEditingController();
  final telastname = TextEditingController();
  final teemail = TextEditingController();
  final tepassword = TextEditingController();
  User  user;



  displayRecord() {
    homePresenter.updateScreen();
  }
  HomePresenter homePresenter;
  @override
  Widget build (BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);



    final firstnameField= TextField(
      obscureText: false,
      style: style,
        controller: tefirstname,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Enter firstname",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final lastnameField= TextField(
      obscureText: false,
      controller: telastname,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Enter lastname",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );



    final emailField= TextField(
      obscureText: false,
      style: style,
      controller: teemail,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Enter email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );


    final passwordField = TextField(
      obscureText: true,
      style: style,
      controller: tepassword,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Enter Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final signupButton = Material(
      elevation: 5.0,
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery
            .of(context)
            .size
            .width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Register()),
          );},
        child: Text("signup",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );


    return new Scaffold(
        appBar: new AppBar(
          title: new Text("sign up"),
        ),
        body: Center(
          child:SingleChildScrollView(

            child: Container(
            //color: Colors.white,
            child: Padding(
            padding: const EdgeInsets.all(36.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

            SizedBox(height: 45.0),
        firstnameField,
        SizedBox(height: 25.0),
        lastnameField,
              SizedBox(height: 25.0),
              emailField,
        SizedBox(height: 25.0),
        passwordField,
        SizedBox(
          height: 35.0,
        ),

        signupButton,
        SizedBox(
            height: 15.0),
        GestureDetector(
        child: Text("Click here to login", style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue)),
            onTap: () {
          Navigator.push(
          context,
         MaterialPageRoute(builder: (context) => Login()),
          );
         }
        ),
            ],
        ),
            ),
            ),
        ),
        ),
    );
  }

  Future addRecord() async {
    var db = new DatabaseHelper();
    var user = new User(
        tefirstname.text, telastname.text, teemail.text, tepassword.text);
    user.setUserId(this.user.id);
    await db.saveUSer(user);
  }
}





Widget getTextField(String inputBoxName,
    TextEditingController inputBoxController) {
  var signupBtn = new Padding(
    padding: const EdgeInsets.all(5.0),
    child: new TextFormField(
      controller: inputBoxController,
      decoration: new InputDecoration(
        hintText: inputBoxName,
      ),
    ),
  );

  return signupBtn;
}

Widget getAppBorderButton(String buttonLabel, EdgeInsets margin) {
  var loginBtn = new Container(
    margin: margin,
    padding: EdgeInsets.all(8.0),
    alignment: FractionalOffset.center,
    decoration: new BoxDecoration(
      border: Border.all(color: const Color(0xFF28324E)),
      borderRadius: new BorderRadius.all(const Radius.circular(6.0)),
    ),
    child: new Text(
      buttonLabel,
      style: new TextStyle(
        color: const Color(0xFF28324E),

        fontSize: 20.0,
        fontWeight: FontWeight.w300,
        letterSpacing: 0.3,
      ),
    ),
  );
  return loginBtn;
}













