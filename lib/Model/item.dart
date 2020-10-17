import 'package:flutter/cupertino.dart';

class Item {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String description;

  Item({@required this.id, @required this.name, @required this.price, @required this.quantity, @required this.description});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'price': price, 'quantity': quantity, 'description': description};
  }

  static Item fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Item(
        id: map['id'], name: map['name'], price: map['price'], quantity: map['quantity'], description: map['description']);
  }
}
