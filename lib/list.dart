import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:product/add_product_dialog.dart';
import 'package:product/product.dart';
import 'package:product/home_presenter.dart';
import 'package:product/database/database_helper.dart';

class ProductList extends StatelessWidget {
  List<Product> country;
  HomePresenter homePresenter;
  Product product;

  ProductList(
      List<Product> this.country,
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
                                    color: Colors.blueGrey),
                              ),
                              new Text(
                                "DATE: " + country[index].date,
                                // set some style to text
                                style: new TextStyle(
                                    fontSize: 20.0, color: Colors.lightGreenAccent),
                              ),
                            ],
                          ),
                        ),
                      ),
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: const Color(0xFF167F67),
                            ),
                            onPressed: () => edit(country[index], context),
                          ),
                          new IconButton(
                            icon: const Icon(
                              Icons.visibility,
                              color: const Color(0xFF167F67),
                            ),
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => viewProduct(context,index)),
                              );
//                              viewProduct(context, index);
                              },
                          ),

                          new IconButton(
                            icon: const Icon(Icons.delete_forever,
                                color: const Color(0xFF167F67)),
                            onPressed: () {
                              showAlertDialog(context,index);
                            }
//                                homePresenter.delete(country[index]),


                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)),
          );
        });


  }

  displayRecord() {
    homePresenter.updateScreen();
  }



  edit(Product product, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          new AddProductDialog().buildAboutDialog(context, this, true, product),
    );
    homePresenter.updateScreen();
  }
//
//  view(Product product) {
//
//    homePresenter.updateScreen();
//  }

  String getShortName(Product products) {
    String shortName = "";
    if (products.product.isNotEmpty) {
      shortName = products.product.substring(0, 1) + ".";
    }

    if (products.product.isNotEmpty) {
      shortName = shortName + products.product.substring(0, 1);
    }
    return shortName;
  }


//Shows Dialog for deleting a product
  showAlertDialog(BuildContext context, int index){

    Widget okButton = FlatButton(
      child: Text('Yes'),
      onPressed: (){
        homePresenter.delete(country[index]);
        Navigator.pop(context);
      },
    );

    Widget cancelButton = FlatButton(
      child: Text('Cancel'),
      onPressed: (){Navigator.pop(context);},
    );

    AlertDialog alert=AlertDialog(
      title: Text("Delete Dialog"),
      content: Text("Do you want to delete this product?"),
      actions:[
        cancelButton,

        okButton
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context){
          return alert;
        }
    );
  }


////  To fetch a single product from database
//  Future viewRecord(Product product) async {
//    var db = new DatabaseHelper();
//    product.setProductId(product.id);
//    await db.singleProduct(product);
//  }


//A widget to display the details of a single product
  viewProduct(BuildContext context , int index) {

     product=homePresenter.view(country[index]);
    String product_name='';
    String product_desc='';
    String date='';
    product_name = product.product.substring(0, 1) + ".";
    product_desc= product.description.substring(0, 1) + ".";
    date= product.date.substring(0, 1) + ".";

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("product details"),
      ),
      body: new Text("product name"),


    );
  }


}





