import 'dart:async';
import 'package:product/user.dart';
import 'package:product/signup_ctr.dart';
import 'package:product/signup_response.dart';
class SignupRequest {
  SignupCtr con = new SignupCtr();
  Future<User> getSignup(String firstname, String lastname, String email, String password)async {
    var result = con.getLogin(firstname,lastname,email,password);
    return result;
  }
}