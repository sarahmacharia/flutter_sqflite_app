import 'dart:async';
import 'dart:io' as io;

import 'package:product/product.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:product/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:product/login.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Product(id INTEGER PRIMARY KEY, product TEXT, description TEXT, date TEXT)");
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY, firstname TEXT, lastname TEXT, email TEXT, password TEXT)");
  }

  Future<int> saveProduct(Product product) async {
    var dbClient = await db;
    int res = await dbClient.insert("Product", product.toMap());
    return res;
  }

  Future<int> saveUSer(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  Future<List<Product>> getProduct() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM  Product');
    List<Product> employees = new List();
    for (int i = 0; i < list.length; i++) {
      var product = new Product(
          list[i]["product"], list[i]["description"], list[i]["date"]);
      product.setProductId(list[i]["id"]);
      employees.add(product);
    }
    print(employees.length);
    return employees;
  }

  Future<List<User>> getUsers() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM  User');
    List<User> employees = new List();
    for (int i = 0; i < list.length; i++) {
      var user = new User(list[i]["firstname"], list[i]["lastname"],
          list[i]["email"], list[i]["password"]);
      print(user.password);
      user.setUserId(list[i]["id"]);
      employees.add(user);
    }

    return employees;
  }

  getUser(User user) async {
    var response = new Map();
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM User where email=? and password=?',
        [user.email, user.password]);
    if (list.length > 0) {
      response['data'] = list;
      response['code'] = 202;
      response['message'] = 'Login Successful';
    } else {
      response['data'] = '';
      response['code'] = 400;
      response['message'] = 'Invalid password or email';
    }
    ;
    return response;
  }
//  newUser(User newUser) async {
//    final db = await _db;
//    //get the biggest id in the table
//    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM User");
//    int id = table.first["id"];
//    //insert to the table using the new id
//    var raw = await db.rawInsert(
//        "INSERT Into User(id,firstname,lastname,email, password)"
//            " VALUES (?,?,?,?)",
//        [id, newUser.firstname, newUser.lastname, newUser.email, newUser.password]);
//    return raw;
//  }

  Future<int> deleteProduct(Product product) async {
    var dbClient = await db;

    int res = await dbClient
        .rawDelete('DELETE FROM Product WHERE id = ?', [product.id]);
    return res;
  }

  createUser(User user) async {
    var response = new Map();
    var dbClient = await db;

    var count = await dbClient.rawQuery(
        'SELECT count(*) as count FROM  User where email=?', [user.email]);

    if (count[0]["count"] == 0) {
      var result = await _db.rawInsert(
          'INSERT INTO User (firstname,lastname,email, password) VALUES (?,?,?,?)',
          [user.firstname, user.lastname, user.email, user.password]);
      response['data'] = result;
      response['code'] = 202;
      response['message'] = 'Account created';
    } else {
      response['data'] = '';
      response['code'] = 400;
      response['message'] = 'User exists';
    }
    ;
    return response;
  }

//
//  Future<product> myProduct(Product product) async {

//    var dbClient = await db;
//
//    int res =
//    await dbClient.rawDelete('SELECT * FROM Product WHERE id = ?', [product.id]);
//    return res;
//  }

//  Future<Product> fetchProduct(int id)async{
//    var dbClient = await db;
//     List<Map>results=await dbClient.query("product",columns:
//      Product.columns,where:"id=?",whereArgs:[id]);
//
//     Product product=Product.fromMap(results[0]);
//     return product;
//
//  }

  singleProduct(Product product) async {
    var dbClient = await db;
//    var res =
//    await dbClient.rawDelete('SELECT FROM Product WHERE id = ?',[product.id]);
    var res = dbClient.query("Product", where: "id=?", whereArgs: [product.id]);
    return res;
  }

  Future<bool> update(Product product) async {
    var dbClient = await db;
    int res = await dbClient.update("Product", product.toMap(),
        where: "id = ?", whereArgs: <int>[product.id]);
    return res > 0 ? true : false;
  }
}
