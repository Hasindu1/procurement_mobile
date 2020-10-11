import 'package:flutter/material.dart';
import 'package:procurementapp/components/Drawer.dart';
import 'package:procurementapp/pages/DeliveredList.dart';
import 'package:procurementapp/util/routes.dart';

import 'Home.dart';

class Delivered extends StatelessWidget {
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
      body: DeliveredList(),
    );
  }
}