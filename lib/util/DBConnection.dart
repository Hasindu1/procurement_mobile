import 'package:cloud_firestore/cloud_firestore.dart';

class DBConnection {
  static Firestore _db;

  /*  return Firestore.instance if object is not null
    otherwise create instance and return
   */
  static Firestore getConnection() {
    if (_db == null) {
      _db = Firestore.instance;
    }
    return _db;
  }
}