import 'package:flutter/material.dart';
import 'package:procurementapp/components/Appbar.dart';
import 'package:procurementapp/components/Drawer.dart';

class DeliveredDetails extends StatelessWidget {
  final String id;
  final String product;
  final int quantity;
  final double unit;
  final double total;
  final DateTime dDate;

  DeliveredDetails(
      {this.id,
      this.product,
      this.quantity,
      this.unit,
      this.total,
      this.dDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 8.0),
                    child: RichText(
                        text: TextSpan(
                            text: "Order Reference: ",
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                            children: <TextSpan>[
                          TextSpan(
                              text: id,
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 16.0)),
                        ])),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                enabled: false,
                initialValue: product,
                decoration: InputDecoration(
                    labelText: 'Product',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                enabled: false,
                initialValue: quantity.toString(),
                decoration: InputDecoration(
                    labelText: 'Quanity',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                enabled: false,
                initialValue: quantity.toString(),
                decoration: InputDecoration(
                    labelText: 'Unit Price',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                enabled: false,
                initialValue: total.toString(),
                decoration: InputDecoration(
                    labelText: 'Total',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                enabled: false,
                initialValue: dDate.day.toString() +
                    "/" +
                    dDate.month.toString() +
                    "/" +
                    dDate.year.toString(),
                decoration: InputDecoration(
                    labelText: 'Delivere Date',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
