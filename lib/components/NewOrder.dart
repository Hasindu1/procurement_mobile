import 'package:flutter/material.dart';

class NewOrder extends StatefulWidget {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  String dropdownValue = 'One';
  DateTime date;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    date = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Text(
              "Purchase A Order",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Order Refernce',
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)))),
                      SizedBox(
                        height: 50.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Company Details",
                              style: TextStyle(fontSize: 16.0),
                            )
                          ],
                        ),
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Company Name',
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)))),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                              labelText: 'Address',
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)))),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)))),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: 'Contact No',
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)))),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Row(children: <Widget>[
                          DropdownButton<String>(
                            value: dropdownValue,
                            iconSize: 24,
                            style: TextStyle(color: Colors.grey[700]),
                            elevation: 16,
                            underline: Container(
                              height: 2,
                              color: Colors.grey[400],
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            items: <String>['One', 'Two', 'Free', 'Four']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ]),
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
                                      BorderSide(color: Colors.blueAccent)))),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Unit Price',
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)))),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Total Price',
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)))),
                      SizedBox(
                        height: 50.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Supplier Details",
                              style: TextStyle(fontSize: 16.0),
                            )
                          ],
                        ),
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Supplier Name',
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)))),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                              labelText: 'Address',
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)))),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)))),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: 'Contact No',
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)))),
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
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)))),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              labelText: 'Comment',
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)))),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {},
                              child: Text(
                                "Create",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            FlatButton(
                              onPressed: () {},
                              child: Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.lightBlue,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            FlatButton(
                              onPressed: () {},
                              child: Text(
                                "Hold",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.purple,
                            ),
                          ],
                        ),
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
