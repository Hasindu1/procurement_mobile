import 'package:flutter/material.dart';
import 'package:procurementapp/components/Appbar.dart';
import 'package:procurementapp/components/Drawer.dart';

class OderDetails extends StatefulWidget {
  final String orderId;
  final String status;

  OderDetails({this.orderId, this.status});

  @override
  _OderDetailsState createState() => _OderDetailsState();
}

class _OderDetailsState extends State<OderDetails> {
  final _formKey = GlobalKey<FormState>();
  DateTime date;

  @override
  void initState() {
    date = DateTime.now();
  }

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
                  RichText(
                      text: TextSpan(
                          text: "Order Reference: ",
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          children: <TextSpan>[
                        TextSpan(
                            text: widget.orderId,
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 16.0)),
                      ])),
                  SizedBox(
                    height: 10.0,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "Order Status: ",
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          children: <TextSpan>[
                          widget.status == 'Approved' ?
                          TextSpan(
                            text: widget.status,
                            style: TextStyle(
                                color: Colors.greenAccent, fontSize: 16.0))
                          : widget.status == 'Rejected' ? 
                          TextSpan(
                            text: widget.status,
                            style: TextStyle(
                                color: Colors.red, fontSize: 16.0))
                          : 
                          TextSpan(
                            text: widget.status,
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 16.0))
                      ])),
                  SizedBox(
                    height: 50.0,
                  ),
                ],
              ),
            ),
            Text(
              "Company Details",
              style: TextStyle(fontSize: 16.0),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Company Name',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Address',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText: 'Contact No',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      SizedBox(
                        height: 80.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Type of product',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Quantity',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Unit price',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Total price',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Text(
                        "Supplier Details",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Supplier name',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Address',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText: 'Contact no',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Required date",
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 16.0),
                            ),
                          ),
                          SizedBox(
                            width: 140.0,
                          ),
                          Text(
                            date.day.toString() +
                                "-" +
                                date.month.toString() +
                                "-" +
                                date.year.toString(),
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.calendar_today,
                                size: 35.0,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2020),
                                        lastDate: DateTime(2033))
                                    .then((date) {
                                  setState(() {
                                    date = date;
                                  });
                                });
                              })
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      widget.status == 'Approved'
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FlatButton(
                                    onPressed: () {},
                                    color: Colors.green,
                                    child: Text(
                                      "Save",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                SizedBox(
                                  width: 5.0,
                                ),
                                FlatButton(
                                    onPressed: () {},
                                    color: Colors.blue,
                                    child: Text(
                                      "Update",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                SizedBox(
                                  width: 5.0,
                                ),
                                FlatButton(
                                    onPressed: () {},
                                    color: Colors.red,
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ],
                            )
                          : widget.status == 'Rejected'
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () {},
                                        color: Colors.red,
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () {},
                                        color: Colors.blueAccent,
                                        child: Text(
                                          "Update",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    FlatButton(
                                        onPressed: () {},
                                        color: Colors.red,
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ],
                                )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
