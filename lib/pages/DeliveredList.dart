import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:procurementapp/service/order.dart';

class DeliveredList extends StatefulWidget {
  @override
  _DeliveredListState createState() => _DeliveredListState();
}

class _DeliveredListState extends State<DeliveredList> {
  OrderService orderService = new OrderService();
  List<DocumentSnapshot> deliveredList = <DocumentSnapshot>[];

  @override
  void initState() {
    super.initState();
    getDelivered();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
              columns: [
                DataColumn(label: Text("Order reference")),
                DataColumn(label: Text("View"))
              ],
              rows: deliveredList
                  .map((delivered) => DataRow(cells: [
                        DataCell(Text(delivered.data['id'])),
                        DataCell(Icon(Icons.remove_red_eye), onTap: () {})
                      ]))
                  .toList()),
        ),
      ),
    );
  }

  getDelivered() async {
    List<DocumentSnapshot> data = await orderService.getDelivered();
    setState(() {});
    deliveredList = data;
  }
}
