import 'package:flutter/material.dart';
import 'package:procurementapp/components/Appbar.dart';
import 'package:procurementapp/components/DraftList.dart';
import 'package:procurementapp/components/Drawer.dart';

class Draft extends StatefulWidget {
  @override
  _DraftState createState() => _DraftState();
}

class _DraftState extends State<Draft> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: MyDrawer(),
      body: DraftList()
    );
  }
}
