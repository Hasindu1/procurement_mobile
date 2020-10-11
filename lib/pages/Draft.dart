import 'package:flutter/material.dart';
import 'package:procurementapp/components/DraftList.dart';
import 'package:procurementapp/components/Drawer.dart';
import 'package:procurementapp/pages/Home.dart';
import 'package:procurementapp/util/routes.dart';

class Draft extends StatefulWidget {
  @override
  _DraftState createState() => _DraftState();
}

class _DraftState extends State<Draft> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(icon: Icon(Icons.arrow_back), onPressed: () => changeScreenReplacement(context, Home()))
        ],
      ),
      drawer: MyDrawer(),
      body: DraftList()
    );
  }
}
