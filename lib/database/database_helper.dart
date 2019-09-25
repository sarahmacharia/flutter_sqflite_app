import 'dart:async';
import 'dart:io' as io;

import 'package:product/product.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

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
  }


  Future<int> saveProduct(Product product) async {
    var dbClient = await db;
    int res = await dbClient.insert("Product", product.toMap());
    return res;
  }
  Future<List<Product>> getProduct() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM  Product');
    List<Product> employees= new List();
    for (int i = 0; i < list.length; i++) {
      var product =
      new Product(list[i]["product"], list[i]["description"], list[i]["date"]);
      product.setProductId(list[i]["id"]);
      employees.add(product);
    }
    print(employees.length);
    return employees;
  }

  Future<int> deleteProduct(Product product) async {
    var dbClient = await db;

    int res =
    await dbClient.rawDelete('DELETE FROM Product WHERE id = ?', [product.id]);
    return res;
  }


singleProduct(Product product) async {
    var dbClient = await db;
//    var res =
//    await dbClient.rawDelete('SELECT FROM Product WHERE id = ?',[product.id]);
    var res=dbClient.query("Product", where: "id=?",whereArgs: [product.id]);
    return res;
  }

  Future<bool> update(Product product) async {
    var dbClient = await db;
    int res =   await dbClient.update("Product", product.toMap(),
        where: "id = ?", whereArgs: <int>[product.id]);
    return res > 0 ? true : false;
  }
}
