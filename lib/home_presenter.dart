import 'package:product/database/database_helper.dart';
import 'package:product/product.dart';

import 'dart:async';


abstract class HomeContract {
  void screenUpdate();
}

class HomePresenter {

  HomeContract _view;

  var db = new DatabaseHelper();

  HomePresenter(this._view);


  delete(Product product) {
    var db = new DatabaseHelper();
    db.deleteProduct(product);
    updateScreen();
  }

  view(Product product) {
    var db = new DatabaseHelper();
   return db.singleProduct(product);

  }

  Future<List<Product>> getProduct() {
    return db.getProduct();
  }

  updateScreen() {
    _view.screenUpdate();

  }



}
