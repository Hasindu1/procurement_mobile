import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  final _db = Firestore.instance;
  String _id;
  String _site;
  String _supplier;
  String _product;
  int _quantity = 0;
  double _unit = 0.0;
  double _total = 0.0;
  DateTime _date = DateTime.now();
  String _description;
  String _comment;
  String _status;
  String _remarks;
  bool _draft = false;

  // getters setters
  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get site => _site;

  set site(String value) {
    _site = value;
  }

  String get supplier => _supplier;

  set supplier(String value) {
    _supplier = value;
  }

  String get product => _product;

  set product(String value) {
    _product = value;
  }

  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
  }

  double get unit => _unit;

  set unit(double value) {
    _unit = value;
  }

  double get total => _total;

  set total(double value) {
    _total = value;
  }

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get comment => _comment;

  set comment(String value) {
    _comment = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get remarks => _remarks;

  set remarks(String value) => _remarks = value;

  bool get draft => _draft;

  set draft(bool value) => _draft = value;

  // create order
  createOrder() async {
    await _db.collection("orders").document(id).setData({
      "id": this.id,
      "site": this.site,
      "supplier": this.supplier,
      "product": this.product,
      "quantity": this.quantity,
      "unit": this.unit,
      "total": this.total,
      "date": this.date,
      "description": this.description,
      "comment": this.comment,
      "status": this.status,
      "draft": this.draft,
      "remarks": this.remarks
    });
  }

  // reset model
  void reset() {
    this.id = '';
    this.site = '';
    this.supplier = '';
    this.product = '';
    this.quantity = 0;
    this.unit = 0.0;
    this.total = 0.0;
    this.description = '';
    this.date = DateTime.now();
    this.comment = '';
  }

  // retrieve data
  Future<List<DocumentSnapshot>> getOrders() async {
    return await _db
        .collection("orders")
        .where("draft", isEqualTo: false)
        .where("status", whereIn: ["Pending", "Approved", "Rejected"])
        .getDocuments()
        .then((snaps) {
          return snaps.documents;
        });
  }

  Future<List<DocumentSnapshot>> getDrafts() async {
    return await _db
        .collection("orders")
        .where("draft", isEqualTo: true)
        .getDocuments()
        .then((snaps) {
      return snaps.documents;
    });
  }

  Future<List<DocumentSnapshot>> getDelivered() async {
    return await _db
        .collection("orders")
        .where("status", isEqualTo: "Placed")
        .getDocuments()
        .then((snaps) {
      return snaps.documents;
    });
  }

  // update data
  void update() async {
    await _db.collection("orders").document(this._id).updateData({
      "site": this.site,
      "supplier": this.supplier,
      "product": this.product,
      "quantity": this.quantity,
      "unit": this.unit,
      "draft": this.draft,
      "total": this.total,
      "date": this.date,
      "description": this.description,
      "comment": this.comment
    });
  }

  void place() async {
    await _db.collection("orders").document(this._id).updateData({
      "status": this.status,
      "date": this.date
    });
  }

  // delete data
  void delete() async {
    await _db.collection("orders").document(this._id).delete();
  }
}
