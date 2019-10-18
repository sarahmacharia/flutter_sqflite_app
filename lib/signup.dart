import 'package:flutter/material.dart';
import 'package:product/home_presenter.dart';
import 'package:product/database/database_helper.dart';
import 'package:product/signup_response.dart';
import 'package:product/user.dart';
import 'package:product/login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => new _SignupPageState();
}

class _SignupPageState extends State<SignupPage> implements SignupCallBack {
  BuildContext _context;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _firstname, _lastname, _email, _password, _confirmpassword;
  SignupResponse _response;
  _SignupPageState() {
    _response = new SignupResponse(this);
  }
  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _response.doSignup(
            _firstname, _lastname, _email, _password, _confirmpassword);
      });
    }
  }

  void _showSnackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  Widget _visibilityIcon(bool _isObscured) {
    if (_isObscured) {
      return new Icon(Icons.visibility_off);
    } else {
      return new Icon(Icons.visibility);
    }
  }

  final tefirstname = TextEditingController();
  final telastname = TextEditingController();
  final teemail = TextEditingController();
  final tepassword = TextEditingController();
  final teconfirmpassword = TextEditingController();
  User user;
  bool _validate = false;
  bool _lastnamevalidate = false;
  bool _emailvalidate = false;
  bool _passwordvalidate = false;
  bool _confirmpasswordvalidate = false;
  bool _isObscured = true;
  String passwordError = "password field cannot be empty";

  @override
  void dispose() {
    tefirstname.dispose();
    telastname.dispose();
    teemail.dispose();
    tepassword.dispose();
    teconfirmpassword.dispose();
    super.dispose();
  }

  bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern, caseSensitive: true, multiLine: false);
    print(value);

    return regex.hasMatch(value);
  }

  displayRecord() {
    homePresenter.updateScreen();
  }

  HomePresenter homePresenter;
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    final firstnameField = TextField(
      obscureText: false,
      style: style,
      controller: tefirstname,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Enter firstname",
          errorText: _validate ? 'firstname field cannot be empty' : null,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final lastnameField = TextField(
      obscureText: false,
      controller: telastname,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Enter lastname",
          errorText:
              _lastnamevalidate ? "lastname field cannot be empty" : null,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final emailField = TextField(
      obscureText: false,
      style: style,
      controller: teemail,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Enter email",
          errorText: _emailvalidate ? " the email address is not valid" : null,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      obscureText: _isObscured,
      style: style,
      controller: tepassword,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: _visibilityIcon(_isObscured),
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Enter Password",
          errorText: _passwordvalidate ? passwordError : null,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final confirmpasswordField = TextField(
      onChanged: (text) {
        if (tepassword.text != teconfirmpassword.text) {
          setState(() {
            passwordError = "passwords do not match";
            _passwordvalidate = true;
            _confirmpasswordvalidate = true;
          });
        } else {
          _passwordvalidate = false;
          _confirmpasswordvalidate = false;
        }
      },
      obscureText: _isObscured,
      style: style,
      controller: teconfirmpassword,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: _visibilityIcon(_isObscured),
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Confirm Password",
          errorText: _confirmpasswordvalidate ? passwordError : null,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("sign up"),
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
                  confirmpasswordField,
                  SizedBox(
                    height: 35.0,
                  ),
                  Builder(
                    builder: (context) => MaterialButton(
                        elevation: 5.0,
                        color: Color(0xff01A0C7),
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        child: Text('Sign up',
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          setState(() {
                            validator();
                          });

                          if (_validate == false &&
                              (_lastnamevalidate == false) &&
                              (_emailvalidate == false) &&
                              (_passwordvalidate == false) &&
                              (_confirmpasswordvalidate == false)) {
                            var user = new User(tefirstname.text,
                                telastname.text, teemail.text, tepassword.text);
                            //created database connection
                            var db = new DatabaseHelper();
                            //take a future from the db.create user function
                            var response = db.createUser(user);
                            //resolve the future<dynaminc>
                            response.then((a) {
                              //check status code
                              if (a["code"] == 202) {
                                //create a snack bar showing
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.blueAccent,
                                  content: Text(a["message"]),
                                  duration: Duration(seconds: 10),
                                ));
                                Future.delayed(
                                    const Duration(milliseconds: 1500), () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                  );
                                });
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.redAccent,
                                  content: Text(a["message"]),
                                  duration: Duration(seconds: 10),
                                ));
                              }
                              ;
                            });
                          }
                        }),
                  ),
                  new Container(
                    height: 30,
                  ),
                  GestureDetector(
                      child: Text("Click here to login",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
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

  void validator() {
    if (tefirstname.text.isEmpty) {
      _validate = true;
    } else {
      _validate = false;
    }
    if (telastname.text.isEmpty) {
      _lastnamevalidate = true;
    } else {
      _lastnamevalidate = false;
    }
    if (teemail.text.isEmpty) {
      _emailvalidate = true;
    } else if (!teemail.text.contains('@') || !teemail.text.contains('.com')) {
      _emailvalidate = true;
    } else {
      _emailvalidate = false;
    }

    if (tepassword.text.isEmpty) {
      _passwordvalidate = true;
    } else if (!validatePassword(tepassword.text)) {
      setState(() {
        passwordError =
            "Must have one uppercase,lowercase,digit,special character and atleast 8 characters";
      });
      _passwordvalidate = true;
    } else {
      _passwordvalidate = false;
    }
    if (teconfirmpassword.text.isEmpty) {
      _confirmpasswordvalidate = true;
    } else if (tepassword.text != teconfirmpassword.text) {
      setState(() {
        passwordError = "passwords do not match";
        _passwordvalidate = true;
        _confirmpasswordvalidate = true;
      });
    } else {
      _confirmpasswordvalidate = false;
    }
  }

  @override
  void onSignupError(String error) {
    // TODO: implement onSignupError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onSignupSuccess(User user) async {
    if (user != null) {
      Navigator.of(context).pushNamed("/home");
    } else {
      // TODO: implement onSignupSuccess
      _showSnackBar("succesful");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future addRecord() async {
    var db = new DatabaseHelper();
    var user = new User(
        tefirstname.text, telastname.text, teemail.text, tepassword.text);
    user.setUserId(this.user.id);
    await db.saveUSer(user);
  }
}

Widget getTextField(
    String inputBoxName, TextEditingController inputBoxController) {
  var signupButton = new Padding(
    padding: const EdgeInsets.all(5.0),
    child: new TextFormField(
      controller: inputBoxController,
      decoration: new InputDecoration(
        hintText: inputBoxName,
      ),
    ),
  );

  return signupButton;
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
