import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:procurementapp/model/delivery.dart';
import 'package:procurementapp/model/item.dart';
import 'package:procurementapp/model/order.dart';
import 'package:procurementapp/model/site.dart';
import 'package:procurementapp/model/supplier.dart';
import 'package:procurementapp/util/DBConnection.dart';
import 'package:procurementapp/util/common.dart';

/* This class contains firestore operation
  related to items, suppliers, sites and orders
 */
class ServiceProvider {
  final _db = DBConnection.getConnection();
  final StreamController<List<Order>> _streamController =
      StreamController<List<Order>>.broadcast();

//  return all items in database convert to a list
  Future getItems() async {
    try {
      var itemDocumentSnapshot = await _db.collection(ITEMS).getDocuments();
      if (itemDocumentSnapshot.documents.isNotEmpty) {
        return itemDocumentSnapshot.documents
            .map((snapshot) => Item.fromMap(snapshot.data))
            .toList();
      }
    } catch (e) {
      print(e);
    }
  }

//  return all sites details and convert to a list
  Future getSites() async {
    try {
      var siteDocumentSnapShot = await _db.collection(SITES).getDocuments();
      if (siteDocumentSnapShot.documents.isNotEmpty) {
        return siteDocumentSnapShot.documents
            .map((snapshot) => Site.fromMap(snapshot.data))
            .toList();
      }
    } catch (e) {
      print(e);
    }
  }

//  return all supplier details and conver to a list
  Future getSuppliers() async {
    try {
      var siteDocumentSnapShot = await _db.collection(SUPPLIERS).getDocuments();
      if (siteDocumentSnapShot.documents.isNotEmpty) {
        return siteDocumentSnapShot.documents
            .map((snapshot) => Supplier.fromMap(snapshot.data))
            .toList();
      }
    } catch (e) {
      print(e);
    }
  }

//  create new order document with relevant fields
  Future createOrder(
      {@required String id,
      @required String site,
      @required String supplier,
      @required String product,
      @required int quantity,
      @required double unit,
      @required DateTime date,
      @required String description,
      @required String comment,
      @required String status,
      @required String remarks,
      @required bool draft}) async {
    Order order = new Order(
        id: id,
        site: site,
        supplier: supplier,
        product: product,
        quantity: quantity,
        unit: unit,
        date: date,
        description: description,
        comment: comment,
        status: status,
        remarks: remarks,
        draft: draft,
        reason: null,
        isCompleted: null,
        budget: null);
    await _db.collection(ORDERS).document(id).setData(order.toMap());
  }

//  return orders which are status is Pending, Approved or Rejected and draft is false
  Stream listenToOrdersRealTime() {
    _db
        .collection(ORDERS)
        .where(DRAFT, isEqualTo: false)
        .where(STATUS, whereIn: [PENDING, APPROVED, REJECTED])
        .snapshots()
        .listen((orderSnapshot) {
          if (orderSnapshot.documents.isNotEmpty) {
            var orders = orderSnapshot.documents
                .map((snapshot) => Order.fromMap(snapshot.data))
                .toList();
            _streamController.add(orders);
          }
        });
    return _streamController.stream;
  }

//  delete order document from database by document id
  Future deleteOrder(String id) async {
    await _db.collection(ORDERS).document(id).delete();
  }

//  update details of order by document id
  Future updateOrder(
      {@required String id,
      @required String site,
      @required String supplier,
      @required String product,
      @required int quantity,
      @required double unit,
      @required DateTime date,
      @required String description,
      @required String comment,
      @required String status,
      @required String remarks,
      @required bool draft}) async {
    Order order = new Order(
        id: id,
        site: site,
        supplier: supplier,
        product: product,
        quantity: quantity,
        unit: unit,
        date: date,
        description: description,
        comment: comment,
        status: status,
        remarks: remarks,
        draft: draft,
        reason: null,
        isCompleted: null,
        budget: null);
    await _db.collection(ORDERS).document(order.id).updateData(order.toMap());
  }

  Future createDelivery(
      {@required deliveryId,
      @required orderRef,
      @required item,
      @required isPayed}) async {
    Delivery delivery = new Delivery(
        deliveryId: deliveryId,
        orderRef: orderRef,
        item: item,
        isPayed: isPayed);
    await _db.collection(DELIVERY).add(delivery.toMap());
  }

//  return orders which are draft is true
  Future getDrafts() async {
    try {
      var siteDocumentSnapShot = await _db
          .collection(ORDERS)
          .where(DRAFT, isEqualTo: true)
          .getDocuments();
      if (siteDocumentSnapShot.documents.isNotEmpty) {
        return siteDocumentSnapShot.documents
            .map((snapshot) => Order.fromMap(snapshot.data))
            .toList();
      }
    } catch (e) {
      print(e);
    }
  }

// return order details which are placed
  Future getPlacedOrders() async {
    try {
      var placedDocumentSnapshot = await _db
          .collection(ORDERS)
          .where(STATUS, isEqualTo: PLACED)
          .getDocuments();
      if (placedDocumentSnapshot.documents.isNotEmpty) {
        return placedDocumentSnapshot.documents
            .map((snapshot) => Order.fromMap(snapshot.data))
            .toList();
      }
    } catch (e) {
      print(e);
    }
  }
}
