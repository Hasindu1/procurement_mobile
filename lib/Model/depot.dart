import 'package:flutter/cupertino.dart';

class Depot {
  final String depotName;

  Depot({@required this.depotName});

  Map<String, dynamic> toMap() {
    return {'depotName': depotName};
  }

  static Depot fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Depot(depotName: map['depotName']);
  }
}
