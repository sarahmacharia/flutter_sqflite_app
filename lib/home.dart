import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:product/add_product_dialog.dart';
import 'package:product/product.dart';
import 'package:product/home_presenter.dart';
import 'package:product/list.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements HomeContract {
  HomePresenter homePresenter;

  @override
  void initState() {
    super.initState();
    homePresenter = new HomePresenter(this);
  }

  displayRecord() {
    setState(() {});
  }

  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
    Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.center;

    return new InkWell(
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            new Text('Product Database',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }


  List<Widget> _buildActions() {
    return <Widget>[
      new IconButton(
          icon: const Icon(
            Icons.group_add,
            color: Colors.white,
          ),
          onPressed: (){ _openAddProductDialog();}
      ),
    ];
  }


  Future _openAddProductDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          new AddProductDialog().buildAboutDialog(context, this, false, null),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: _buildTitle(context),
        actions: _buildActions(),
      ),
      body: new FutureBuilder<List<Product>>(
        future: homePresenter.getProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var data = snapshot.data;
          return snapshot.hasData
              ? new ProductList(data,homePresenter)
              : new Center(child: new CircularProgressIndicator());
        },
      ),
    );
  }







  @override
  void screenUpdate() {
    setState(() {});
  }

}