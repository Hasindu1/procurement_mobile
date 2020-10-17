import 'package:flutter/cupertino.dart';

class Supplier {
  final String id;
  final String name;
  final String address;
  final String email;
  final String contact;
  final String depots;
  final List sites;
  final bool isApproved;

  Supplier(
      {@required this.id,
      @required this.name,
      @required this.address,
      @required this.email,
      @required this.contact,
      @required this.depots,
      @required this.sites,
      @required this.isApproved});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'email': email,
      'contact': contact,
      'depots': depots,
      'sites': sites,
      'isApproved': isApproved
    };
  }

  static Supplier fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Supplier(
        id: map['id'],
        name: map['name'],
        address: map['address'],
        email: map['email'],
        contact: map['contact'],
        depots: map['depots'],
        sites: map['sites'],
        isApproved: map['isApproved']);
  }
}
