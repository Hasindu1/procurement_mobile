import 'package:flutter/cupertino.dart';

class Delivery {
  final String deliveryId;
  final String orderRef;
  final String item;
  final bool isPayed;

  Delivery(
      {@required this.deliveryId,
      @required this.orderRef,
      @required this.item,
      @required this.isPayed});

  Map<String, dynamic> toMap() {
    return {
      'deliveryId': deliveryId,
      'orderRef': orderRef,
      'item': item,
      'isPayed': isPayed
    };
  }

  static Delivery fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Delivery(
        deliveryId: map['deliveryId'],
        orderRef: map['orderRef'],
        item: map['item'],
        isPayed: map['isPayed']);
  }
}
