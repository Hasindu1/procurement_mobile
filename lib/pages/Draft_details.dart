import 'package:flutter/material.dart';
import 'package:procurementapp/components/Appbar.dart';
import 'package:procurementapp/components/Draft_detail.dart';
import 'package:procurementapp/components/Drawer.dart';

class DraftDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: appBar,
      drawer: MyDrawer(),
      body: DraftDetails()
    );
  }
}

