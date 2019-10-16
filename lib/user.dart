class User {
  static final columns = ["id", "firstname", "lastname", "email", "password"];

  int id;

  String _firstname;
  String _lastname;
  String _email;
  String _password;

  User(this._firstname, this._lastname, this._email, this._password);

  User.map(dynamic obj) {
    this._firstname = obj["firstname"];
    this._lastname = obj["lastname"];
    this._email = obj["email"];
    this._password = obj["password"];
  }
  User.test(this._email, this._password) {
    this._email = this._email;
    this._password = this._password;
  }
  String get firstname => _firstname;

  String get lastname => _lastname;

  String get email => _email;

  String get password => _password;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["firstname"] = _firstname;
    map["lastname"] = _lastname;
    map["email"] = _email;
    map["password"] = _password;
    return map;
  }

  fromMap(Map map) {
    User user = new User(_firstname, _lastname, _email, _password);

    user.id = map["id"];
    user._firstname = map["user"];
    user._lastname = map["user"];

    user._email = map["user"];
    user._password = map["user"];

    return user;
  }

  void setUserId(int id) {
    this.id = id;
  }
}
