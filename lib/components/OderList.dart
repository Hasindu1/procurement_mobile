import 'package:flutter/material.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

enum SingleCharacter { supplier, sitemanager, status }

class _OrderListState extends State<OrderList> {
  SingleCharacter _character = SingleCharacter.supplier;

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(bottom: 18.0, top: 12.0),
        child: Center(
            child: Text(
          "Purchase Orders",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        )),
      ),
      TextField(
        decoration: InputDecoration(
            hintText: 'Search By',
            border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.amber, style: BorderStyle.solid))),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 200.0),
        child: Column(
        children: <Widget>[
          ListTile(
            title: const Text('Supplier'),
            leading: Radio(
              value: SingleCharacter.supplier,
              groupValue: _character,
              onChanged: (SingleCharacter value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Site Manager'),
            leading: Radio(
              value: SingleCharacter.sitemanager,
              groupValue: _character,
              onChanged: (SingleCharacter value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Status'),
            leading: Radio(
              value: SingleCharacter.status,
              groupValue: _character,
              onChanged: (SingleCharacter value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
        ],
    ),
      ),
      SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(columns: [
            DataColumn(label: Text("Order Reference", style: TextStyle(fontSize: 15.0),)),
            DataColumn(label: Text("Supplier",style: TextStyle(fontSize: 15.0),)),
            DataColumn(label: Text("Site Manager",style: TextStyle(fontSize: 15.0),)),
            DataColumn(label: Text("Order Status",style: TextStyle(fontSize: 15.0),)),
            DataColumn(label: Text("View Order",style: TextStyle(fontSize: 15.0),)),
          ], rows: [
            DataRow(cells: [
              DataCell(Text("1",style: TextStyle(fontSize: 15.0),)),
              DataCell(Text("Atlas",style: TextStyle(fontSize: 15.0),)),
              DataCell(Text("Pasidu",style: TextStyle(fontSize: 15.0),)),
              DataCell(Text("New",style: TextStyle(fontSize: 15.0),)),
              DataCell(Icon(Icons.remove_red_eye), onTap: () {}),
            ]),
            DataRow(cells: [
              DataCell(Text("2")),
              DataCell(Text("Atlas")),
              DataCell(Text("Pasidu")),
              DataCell(Text("New")),
              DataCell(Icon(Icons.remove_red_eye), onTap: () {}),
            ]),
            DataRow(cells: [
              DataCell(Text("3")),
              DataCell(Text("Atlas")),
              DataCell(Text("Pasidu")),
              DataCell(Text("New")),
              DataCell(Icon(Icons.remove_red_eye), onTap: () {}),
            ])
          ])),
    ]);
  }
}
