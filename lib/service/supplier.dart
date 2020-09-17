import 'package:cloud_firestore/cloud_firestore.dart';

class SupplierService {
  Firestore _firestore = Firestore.instance;

  // get sites
  Future<List<DocumentSnapshot>> getSuppliers() {
    return _firestore.collection("suppliers").getDocuments().then((snaps) {
      return snaps.documents;
    });
  }
}
