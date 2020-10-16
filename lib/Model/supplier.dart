import 'package:flutter/cupertino.dart';

class Supplier {
  final String id;
  final String name;
  final String address;
  final String email;
  final String contact;

  Supplier({
    @required this.id,
    @required this.name,
    @required this.address,
    @required this.email,
    @required this.contact
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'email': email,
      'contact': contact
    };
  }

  static Supplier fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Supplier(id: map['id'], name: map['name'], address: map['address'], email: map['email'], contact: map['contact']);
  }}