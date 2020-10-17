import 'package:flutter/cupertino.dart';

class Enquiry {
  final String orderRef;
  final String enquiry;

  Enquiry({@required this.orderRef, @required this.enquiry});

  Map<String, dynamic> toMap() {
    return {'orderRef': orderRef, 'enquiry': enquiry};
  }

  static Enquiry fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Enquiry(orderRef: map['orderRef'], enquiry: map['enquiry']);
  }
}
