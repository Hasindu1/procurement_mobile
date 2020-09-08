import 'package:flutter/material.dart';
import 'package:procurementapp/components/OderList.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.blueGrey,
      ),
      drawer: Drawer(
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
      ),
      body: OrderList(),
    );
  }
}
