import 'package:flutter/material.dart';
import 'package:procurementapp/pages/PurchaseOrder.dart';
import 'package:procurementapp/util/routes.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Site Manager"),
              accountEmail: Text("sitemanager@gmail.com"),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(color: Colors.blueGrey),
            ),
            InkWell(
              onTap: () {
                changeScreen(context, PurchaseOrder());
              },
              child: ListTile(
                title: Text("Purchase A Order"),
                leading: Icon(
                  Icons.add_circle,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
