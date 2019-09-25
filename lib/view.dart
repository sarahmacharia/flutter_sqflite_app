import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:product/add_product_dialog.dart';
import 'package:product/product.dart';
import 'package:product/home_presenter.dart';
class ProductList extends StatelessWidget {
  List<Product> country;
  HomePresenter homePresenter;

  ProductList(List<Product> this.country,
      HomePresenter this.homePresenter, {
        Key key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: country == null ? 0 : country.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new Container(
                child: new Center(
                  child: new Row(
                    children: <Widget>[
//                      new CircleAvatar(
//                        radius: 30.0,
//                        child: new Text(getShortName(country[index])),
//                        backgroundColor: const Color(0xFF20283e),
//                      ),
                      new Expanded(
                        child: new Padding(
                          padding: EdgeInsets.all(10.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                country[index].product,
                                // set some style to text
                                style: new TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.lightBlueAccent),
                              ),

                              new Text(
                                country[index].description,
                                // set some style to text
                                style: new TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.lightBlueAccent),
                              ),
                              new Text(
                                "DATE: " + country[index].date,
                                // set some style to text
                                style: new TextStyle(
                                    fontSize: 20.0, color: Colors.amber),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)),
          );
        });
  }

}