import 'package:product/user.dart';
import 'dart:async';
import 'package:product/database/database_helper.dart';
class SignupCtr {
  DatabaseHelper con = new DatabaseHelper();
//insertion
  Future<int> saveUser(User user) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }
  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await con.db;
    int res = await dbClient.delete("User");
    return res;
  }
  Future<User> getLogin(String firstname, String lastname, String email, String password) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("SELECT * FROM user WHERE firstname = '$firstname', lastname = '$lastname', email = '$email', password = '$password'");

    if (res.length > 0) {
      return new User.map(res.first);
    }
    return null;
  }
  Future<List<User>> getAllUser() async {
    var dbClient = await con.db;
    var res = await dbClient.query("user");

    List<User> list =
    res.isNotEmpty ? res.map((c) => User.map(c)).toList() : null;
    return list;
  }
}