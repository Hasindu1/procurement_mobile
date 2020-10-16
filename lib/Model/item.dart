import 'package:flutter/cupertino.dart';

class Item {
  final String id;
  final String name;
  final double unit_price;

  Item({
    @required this.id,
    @required this.name,
    @required this.unit_price
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'unit_price': unit_price
    };
  }

  static Item fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Item(id: map['id'], name: map['name'], unit_price: map['unit_price']);
  }
}
