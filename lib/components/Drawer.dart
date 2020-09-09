import 'package:flutter/material.dart';

Drawer get drawer {
  return Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Site Manager"),
              accountEmail: Text("sitemanager@gmail.com"),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white,),
                ),
              ),
              decoration: BoxDecoration(color: Colors.blueGrey),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text("Purchase A Order"),
                leading: Icon(Icons.add_circle, color: Colors.blueAccent,),
              ),
            ),
          ],
        ),
      );
}