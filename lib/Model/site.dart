import 'package:flutter/cupertino.dart';

class Site {
  final String id;
  final String name;
  final String address;
  final String email;
  final String contact;
  final List suppliers;

  Site(
      {@required this.id,
      @required this.name,
      @required this.address,
      @required this.email,
      @required this.contact,
      @required this.suppliers
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'email': email,
      'contact': contact,
      'suppliers': suppliers
    };
  }

  static Site fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Site(
        id: map['id'],
        name: map['name'],
        address: map['address'],
        email: map['email'],
        contact: map['contact'],
        suppliers: map['suppliers']);
  }
}
