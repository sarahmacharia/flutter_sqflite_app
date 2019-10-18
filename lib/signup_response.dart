import 'package:product/signup_request.dart';
import 'package:product/user.dart';

abstract class SignupCallBack {
  void onSignupSuccess(User user);
  void onSignupError(String error);
}

class SignupResponse {
  SignupCallBack _callBack;
  //SignupRequest signupRequest = new SignupRequest();

  SignupResponse(this._callBack);
  doSignup(String firstname, String lastname, String email, String password,
      String confirmpassword) {
    SignupRequest()
        .getSignup(firstname, lastname, email, password, confirmpassword)
        .then((user) => _callBack.onSignupSuccess(user))
        .catchError((onError) => _callBack.onSignupError(onError.toString()));
  }
}
