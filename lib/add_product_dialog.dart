import 'dart:async';

import 'package:flutter/material.dart';
import 'package:product/database/database_helper.dart';
import 'package:product/product.dart';

class AddProductDialog {
  final teProduct = TextEditingController();
  final teDescription = TextEditingController();
  final teDate = TextEditingController();
  Product product;
  DateTime selectedDate = DateTime.now();

  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,


  );

  Widget buildAboutDialog(BuildContext context, _myHomePageState, bool isEdit,
      Product product) {
    if (product != null) {
      this.product = product;
      teProduct.text = product.product;
      teDescription.text = product.description;
      teDate.text = product.date;
    }

    return new AlertDialog(
      title: new Text(isEdit ? 'Edit' : 'Add new product'),
      content: new SingleChildScrollView(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("Enter product name", teProduct),
            getTextField("Enter description of product", teDescription),
            getTextField("Date", teDate),

            new GestureDetector(
              onTap: () {
                addRecord(isEdit);
                _myHomePageState.displayRecord();
                Navigator.of(context).pop();
              },
              child: new Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: getAppBorderButton(
                    isEdit ? "Edit" : "Add",
                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),


              ),
            ),
          ],
        ),
      ),
    );
  }



    Widget getTextField(String inputBoxName,
        TextEditingController inputBoxController) {
      var loginBtn = new Padding(
        padding: const EdgeInsets.all(5.0),
        child: new TextFormField(
          controller: inputBoxController,
          decoration: new InputDecoration(
            hintText: inputBoxName,
          ),
        ),
      );

      return loginBtn;
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

    Future addRecord(bool isEdit) async {
      var db = new DatabaseHelper();
      var product = new Product(
          teProduct.text, teDescription.text, teDate.text);
      if (isEdit) {
        product.setProductId(this.product.id);
        await db.update(product);
      } else {
        await db.saveProduct(product);
      }
    }
  }


