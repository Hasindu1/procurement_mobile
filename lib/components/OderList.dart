import 'dart:async';

import 'package:flutter/material.dart';
import 'package:procurementapp/model/order.dart';
import 'package:procurementapp/pages/OrderDetails.dart';
import 'package:procurementapp/service/service_provider.dart';
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
  ServiceProvider serviceProvider = new ServiceProvider();
  List<Order> orders = <Order>[];
  List<Order> filteredOrders = <Order>[];
  final _debouncer = Debouncer(milliseconds: 500);

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
                filteredOrders =
                    orders.where((o) => o.supplier.contains((string))).toList();
              } else if (_character == SingleCharacter.site) {
                filteredOrders =
                    orders.where((o) => o.site.contains((string))).toList();
              } else if (_character == SingleCharacter.status) {
                filteredOrders =
                    orders.where((o) => o.status.contains((string))).toList();
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
                rows: filteredOrders != null
                    ? filteredOrders
                        .map((order) => DataRow(cells: [
                              DataCell(Text(order.id)),
                              DataCell(Text(order.supplier)),
                              DataCell(Text(order.site)),
                              DataCell(Text(order.status)),
                              DataCell(Icon(Icons.remove_red_eye), onTap: () {
                                changeScreen(
                                    context,
                                    OderDetails(
                                      orderId: order.id,
                                      site: order.site,
                                      supplier: order.supplier,
                                      status: order.status,
                                      product: order.product,
                                      quantity: order.quantity,
                                      unit: order.unit,
                                      rDate: order.date.toLocal(),
                                      description: order.description,
                                      comment: order.comment,
                                    ));
                              }),
                            ]))
                        .toList()
                    : [])),
      ),
    ]);
  }

//  return orders which draft is false
  void getOrders() async {
    serviceProvider.listenToOrdersRealTime().listen((orderData) {
      setState(() {
        orders = orderData;
        filteredOrders = orders;
      });
    });
  }
}
