import 'package:flutter/material.dart';
import 'package:procurementapp/model/order.dart';
import 'package:procurementapp/pages/DeliveredDetails.dart';
import 'package:procurementapp/service/service_provider.dart';
import 'package:procurementapp/util/routes.dart';

class DeliveredList extends StatefulWidget {
  @override
  _DeliveredListState createState() => _DeliveredListState();
}

class _DeliveredListState extends State<DeliveredList> {
  ServiceProvider serviceProvider = new ServiceProvider();
  List<Order> deliveredList = <Order>[];

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
              rows: deliveredList != null ? deliveredList
                  .map((delivered) => DataRow(cells: [
                        DataCell(Text(delivered.id)),
                        DataCell(Icon(Icons.remove_red_eye), onTap: () {
                          changeScreen(
                              context,
                              DeliveredDetails(
                                id: delivered.id,
                                product: delivered.product,
                                quantity: delivered.quantity,
                                unit: delivered.unit,
                                total: delivered.unit,
                                dDate: delivered.date.toLocal(),
                              ));
                        })
                      ]))
                  .toList() 
                  : []),
        ),
      ),
    );
  }

  getDelivered() async {
    List<Order> data = await serviceProvider.getPlacedOrders();
    setState(() {});
    deliveredList = data;
  }
}
