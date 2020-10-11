import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:procurementapp/pages/OrderDetails.dart';
import 'package:procurementapp/service/order.dart';
import 'package:procurementapp/service/site.dart';
import 'package:procurementapp/util/routes.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

enum SingleCharacter { supplier, site, status }

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _OrderListState extends State<OrderList> {
  SingleCharacter _character = SingleCharacter.supplier;
  OrderService orderService = new OrderService();
  SiteService siteService = new SiteService();
  List<DocumentSnapshot> orders = <DocumentSnapshot>[];
  List<DocumentSnapshot> filteredOrders = <DocumentSnapshot>[];
  final _debouncer = Debouncer(milliseconds: 500);

  final db = Firestore.instance;

  @override
  void initState() {
    getOrders();
  }

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
        onChanged: (string) {
          _debouncer.run(() {
            setState(() {
              if (_character == SingleCharacter.supplier) {
                filteredOrders = orders
                    .where((o) => o.data["supplier"].contains((string)))
                    .toList();
              } else if (_character == SingleCharacter.site) {
                filteredOrders = orders
                    .where((o) => o.data["site"].contains((string)))
                    .toList();
              } else if (_character == SingleCharacter.status) {
                filteredOrders = orders
                    .where((o) => o.data["status"].contains((string)))
                    .toList();
              }
            });
          });
        },
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
                value: SingleCharacter.site,
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
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                    label: Text(
                  "Order Reference",
                  style: TextStyle(fontSize: 15.0),
                )),
                DataColumn(
                    label: Text(
                  "Supplier",
                  style: TextStyle(fontSize: 15.0),
                )),
                DataColumn(
                    label: Text(
                  "Site Manager",
                  style: TextStyle(fontSize: 15.0),
                )),
                DataColumn(
                    label: Text(
                  "Order Status",
                  style: TextStyle(fontSize: 15.0),
                )),
                DataColumn(
                    label: Text(
                  "View Order",
                  style: TextStyle(fontSize: 15.0),
                )),
              ],
              rows: filteredOrders
                  .map((order) => DataRow(cells: [
                        DataCell(Text(order.data['id'])),
                        DataCell(Text(order.data['supplier'])),
                        DataCell(Text(order.data['site'])),
                        DataCell(Text(order.data['status'])),
                        DataCell(Icon(Icons.remove_red_eye), onTap: () {
                          changeScreen(
                              context,
                              OderDetails(
                                orderId: order.data['id'],
                                site: order.data['site'],
                                supplier: order.data['supplier'],
                                status: order.data['status'],
                                product: order.data['product'],
                                quantity: order.data['quantity'],
                                unit: order.data['unit'],
                                total: order.data['total'],
                                rDate: order.data['date'].toDate(),
                                description: order.data['description'],
                                comment: order.data['comment'],
                              ));
                        }),
                      ]))
                  .toList(),
            )),
      ),
    ]);
  }

  void getOrders() async {
    List<DocumentSnapshot> data = await orderService.getOrders();
    setState(() {
      orders = data;
      filteredOrders = orders;
    });
  }
}
