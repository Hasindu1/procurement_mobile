import 'package:flutter/cupertino.dart';
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
      @required double total,
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
        total: total,
        date: date,
        description: description,
        comment: comment,
        status: status,
        remarks: remarks,
        draft: draft);
    await _db.collection(ORDERS).document(id).setData(order.toMap());
  }

//  return orders which are status is Pending, Approved or Rejected and draft is false
  Future getOrders() async {
    try {
      var orderDocumentSnapShot = await _db
          .collection(ORDERS)
          .where(DRAFT, isEqualTo: false)
          .where(STATUS,
              whereIn: [PENDING, APPROVED, REJECTED]).getDocuments();
      if (orderDocumentSnapShot.documents.isNotEmpty) {
        return orderDocumentSnapShot.documents
            .map((snapshot) => Order.fromMap(snapshot.data))
            .toList();
      }
    } catch (e) {
      print(e);
    }
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
      @required double total,
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
        total: total,
        date: date,
        description: description,
        comment: comment,
        status: status,
        remarks: remarks,
        draft: draft);
    await _db.collection(ORDERS).document(order.id).updateData(order.toMap());
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
