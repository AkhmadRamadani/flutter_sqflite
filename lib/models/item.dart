class Item {
  int? _id;
  String? _name;
  int? _price;
  int? _stock;

  int get id => _id!;

  String get name => _name!;
  set name(String value) => _name = value;

  get price => _price!;
  set price(value) => _price = value;

  get stock => _stock!;
  set stock(value) => _stock = value;

// konstruktor versi 1
  Item(this._name, this._price, this._stock);

// konstruktor versi 2: konversi dari Map ke Item
  Item.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
    _price = map['price'];
    _stock = map['stock'];
  }
// konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = name;
    map['price'] = price;
    map['stock'] = stock;
    return map;
  }
}
