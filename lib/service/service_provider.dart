import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:procurementapp/model/delivery.dart';
import 'package:procurementapp/model/depot.dart';
import 'package:procurementapp/model/enquiry.dart';
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
      @required double budget,
      @required bool isCompleted}) async {
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
        reason: null,
        isCompleted: isCompleted,
        budget: budget);
    await _db.collection(ORDERS).document(id).setData(order.toMap());
  }

//  return orders which are status is Pending, Approved or Rejected and draft is false
  Stream listenToOrdersRealTime() {
    _db
        .collection(ORDERS)
        .where(IS_COMPLETED, isEqualTo: false)
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
      @required bool isCompleted,
      @required double budget}) async {
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
        reason: null,
        isCompleted: isCompleted,
        budget: budget,);
    await _db.collection(ORDERS).document(order.id).updateData(order.toMap());
  }

// create delivery with relevant fields
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
    await _db
        .collection(DELIVERY)
        .document(deliveryId)
        .setData(delivery.toMap());
  }

//  return orders which are draft is true
  Future getDrafts() async {
    try {
      var siteDocumentSnapShot = await _db
          .collection(ORDERS)
          .where(IS_COMPLETED, isEqualTo: true)
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

// create new Enquiry to order
  Future createEnquiry({@required String orderRef, @required enquiry}) async {
    Enquiry enquiryModel = new Enquiry(orderRef: orderRef, enquiry: enquiry);
    _db.collection(ENQUIRIES).add(enquiryModel.toMap());
  }

  // return all depots
  Future getDepots() async {
    try {
      var depotDocumentSnapShot = await _db.collection(DEPOTS).getDocuments();
      if (depotDocumentSnapShot.documents.isNotEmpty) {
        return depotDocumentSnapShot.documents
            .map((snapshot) => Depot.fromMap(snapshot.data))
            .toList();
      }
    } catch (e) {
      print(e);
    }
  }
}
