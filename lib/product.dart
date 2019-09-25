class Product {

  int id;

  String _product;
  String _description;
  String _date;

  Product(this._product, this._description, this._date);

  Product.map(dynamic obj) {
    this._product = obj["product"];
    this._description = obj["description"];
    this._date = obj["date"];
  }

  String get product => _product;

  String get description => _description;

  String get date => _date;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["product"] = _product;
    map["description"] = _description;
    map["date"] = _date;
    return map;
  }
  void setProductId(int id) {
    this.id = id;
  }

}