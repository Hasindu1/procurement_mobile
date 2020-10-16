import 'package:flutter/cupertino.dart';

class Order {
  final String id;
  final String site;
  final String supplier;
  final String product;
  final int quantity;
  final double unit;
  final double total;
  final DateTime date;
  final String description;
  final String comment;
  final String status;
  final String remarks;
  final bool draft;

  Order({
    @required this.id,
    @required this.site,
    @required this.supplier,
    @required this.product,
    @required this.quantity,
    @required this.unit,
    @required this.total,
    @required this.date,
    @required this.description,
    @required this.comment,
    @required this.status,
    @required this.remarks,
    @required this.draft
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'site': site,
      'supplier': supplier,
      'product': product,
      'quantity': quantity,
      'unit': unit,
      'total': total,
      'date': date,
      'description': description,
      'comment': comment,
      'status': status,
      'remarks': remarks,
      'draft': draft
    };
  }

  static Order fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Order(id: map['id'], site: map['site'], supplier: map['supplier'], product: map['product'], quantity: map['quantity'], unit: map['unit'], total: map['total'], date: map['date'].toDate(), description: map['description'], comment: map['comment'], status: map['status'], remarks: map['remarks'], draft: map['draft']);
  }

}