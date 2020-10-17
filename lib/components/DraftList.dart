import 'package:flutter/material.dart';
import 'package:procurementapp/components/Draft_detail.dart';
import 'package:procurementapp/model/order.dart';
import 'package:procurementapp/service/service_provider.dart';
import 'package:procurementapp/util/routes.dart';

class DraftList extends StatefulWidget {
  @override
  _DraftListState createState() => _DraftListState();
}

class _DraftListState extends State<DraftList> {
  ServiceProvider serviceProvider = new ServiceProvider();
  List<Order> drafts = <Order>[];

  @override
  void initState() {
    super.initState();
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
            rows: drafts != null ? drafts
                .map((draft) => DataRow(cells: [
                      DataCell(Text(draft.id)),
                      DataCell(Text(draft.supplier)),
                      DataCell(Text(draft.site)),
                      DataCell(Icon(Icons.remove_red_eye), onTap: () {
                        changeScreenReplacement(
                            context,
                            DraftDetails(
                              orderId: draft.id,
                              site: draft.site,
                              supplier: draft.supplier,
                              product: draft.product,
                              quantity: draft.quantity,
                              unit: draft.unit,
                              rDate: draft.date.toLocal(),
                              description: draft.description,
                              comment: draft.comment,
                              draft: draft.draft,
                            ));
                      })
                    ]))
                .toList()
                : []),
      ),
    ));
  }

  // return draft orders and assign to drafts list
  void getDrafts() async {
    List<Order> data = await serviceProvider.getDrafts();
    setState(() {
      drafts = data;
    });
  }
}
