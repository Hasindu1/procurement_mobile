import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:procurementapp/service/order.dart';

class DraftList extends StatefulWidget {
  @override
  _DraftListState createState() => _DraftListState();
}

class _DraftListState extends State<DraftList> {
  OrderService orderService = new OrderService();
  List<DocumentSnapshot> drafts = <DocumentSnapshot>[];

  @override
  void initState() {
    getDrafts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            columns: [
              DataColumn(label: Text("Order Reference")),
              DataColumn(label: Text("Supplier")),
              DataColumn(label: Text("Site Manager")),
              DataColumn(label: Text("View Order"))
            ],
            rows: drafts.map((draft) => DataRow(cells: [
                  DataCell(Text(draft.data['id'])),
                  DataCell(Text(draft.data['supplier'])),
                  DataCell(Text(draft.data['site'])),
                  DataCell(Icon(Icons.remove_red_eye))
                ])).toList()),
      ),
    ));
  }

  getDrafts() async {
    List<DocumentSnapshot> data = await orderService.getDrafts();
    setState(() {
      drafts = data;
    });
  }
}
