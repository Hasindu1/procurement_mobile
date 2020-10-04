import 'package:cloud_firestore/cloud_firestore.dart';

class ItemService {
  String _id;
  String _name;
  double _unit;
  final _db = Firestore.instance;

  // getters and setters
  String get getId => _id;

  set setId(String id) => this._id = id;

  String get getName => _name;

  set setName(String name) => this._name = name;

  double get getUnit => _unit;

  set setUnit(double unit) => this._unit = unit;

  // retrieve all items in items collection
  Future<List<DocumentSnapshot>> getItems() {
    return _db.collection("items").getDocuments().then((snaps) {
      return snaps.documents;
    });
  }
}
