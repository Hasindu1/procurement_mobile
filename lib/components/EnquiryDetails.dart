import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:procurementapp/components/Appbar.dart';
import 'package:procurementapp/components/Drawer.dart';
import 'package:procurementapp/pages/Home.dart';
import 'package:procurementapp/service/service_provider.dart';
import 'package:procurementapp/util/routes.dart';

class EnquiryDetails extends StatelessWidget {
  final String orderRef;

  EnquiryDetails({this.orderRef});

  @override
  Widget build(BuildContext context) {
    TextEditingController _enquiryController = TextEditingController();
    ServiceProvider serviceProvider = new ServiceProvider();

    return Scaffold(
      appBar: appBar,
      drawer: MyDrawer(),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 15.0,
            ),
            RichText(
              text: TextSpan(
                  text: "Order Reference: ",
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                  children: <TextSpan>[TextSpan(text: orderRef)]),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: _enquiryController,
                decoration: InputDecoration(
                    labelText: "Enquiry",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    )),
              ),
            ),
            FlatButton(
              onPressed: () async {
                await serviceProvider.createEnquiry(
                    orderRef: orderRef, enquiry: _enquiryController.text);
                Fluttertoast.showToast(msg: "Enquiry submitted!");
                changeScreenReplacement(context, Home());
              },
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.redAccent,
            )
          ],
        ),
      ),
    );
  }
}
