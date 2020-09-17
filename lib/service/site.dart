import 'package:cloud_firestore/cloud_firestore.dart';

class SiteService {
  Firestore _firestore = Firestore.instance;

  // get sites
  Future<List<DocumentSnapshot>> getSites() {
    return _firestore.collection("sites").getDocuments().then((snaps) {
      return snaps.documents;
    });
  }
}
