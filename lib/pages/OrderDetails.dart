import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:procurementapp/components/Appbar.dart';
import 'package:procurementapp/components/Drawer.dart';
import 'package:procurementapp/pages/Home.dart';
import 'package:procurementapp/service/order.dart';
import 'package:procurementapp/service/site.dart';
import 'package:procurementapp/service/supplier.dart';
import 'package:procurementapp/util/routes.dart';

class OderDetails extends StatefulWidget {
  final String orderId;
  final String status;
  final String supplier;
  final String site;
  final String product;
  final int quantity;
  final double unit;
  final double total;
  final DateTime rDate;

  OderDetails(
      {this.orderId,
      this.site,
      this.supplier,
      this.status,
      this.product,
      this.quantity,
      this.unit,
      this.total,
      this.rDate});

  @override
  _OderDetailsState createState() => _OderDetailsState();
}

class _OderDetailsState extends State<OderDetails> {
  SiteService siteService = new SiteService();
  SupplierService supplierService = new SupplierService();
  OrderService orderService = new OrderService();

  List<DocumentSnapshot> sites = <DocumentSnapshot>[];
  List<DocumentSnapshot> suppliers = <DocumentSnapshot>[];

  TextEditingController _siteAddressController = TextEditingController();
  TextEditingController _siteEmailController = TextEditingController();
  TextEditingController _sitePhoneController = TextEditingController();

  TextEditingController _qtyController = TextEditingController();
  TextEditingController _unitController = TextEditingController();
  TextEditingController _totalController = TextEditingController();

  TextEditingController _supAddressController = TextEditingController();
  TextEditingController _supEmailController = TextEditingController();
  TextEditingController _supPhoneController = TextEditingController();

  List<DropdownMenuItem<String>> sitesDropDown = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> supplierDropDown =
      <DropdownMenuItem<String>>[];
  String currentSite;
  String currentSupplier;

  final _formKey = GlobalKey<FormState>();
  String _supplierId;
  String _siteId;
  String dropdownValue;
  DateTime date;
  bool visibility = false;
  bool calVisibility = false;

  final FocusNode _totalFocus = FocusNode();
  final FocusNode _unitFocus = FocusNode();
  final FocusNode _qtyFocus = FocusNode();

  @override
  void initState() {
    orderService.id = widget.orderId;
    orderService.site = widget.site;
    orderService.supplier = widget.supplier;
    orderService.product = widget.product;
    orderService.quantity = widget.quantity;
    orderService.unit = widget.unit;
    orderService.total = widget.total;
    orderService.date = widget.rDate;

    _qtyController.text = widget.quantity.toString();
    _unitController.text = widget.unit.toString();
    _totalController.text = widget.total.toString();

    getSites();
    getSuppliers();
    if (widget.status == 'Pending') {
      calVisibility = true;
    }
    dropdownValue = widget.product;
  }

  // return dropdown with relevant data
  List<DropdownMenuItem<String>> getSiteDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < sites.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
              child: Text(sites[i].data['name']),
              value: sites[i].data['name'],
            ));
      });
    }
    return items;
  }

  List<DropdownMenuItem<String>> getSupplierDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < suppliers.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
              child: Text(suppliers[i].data['name']),
              value: suppliers[i].data['name'],
            ));
      });
    }
    return items;
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
                        widget.status == 'Approved'
                            ? TextSpan(
                                text: widget.status,
                                style: TextStyle(
                                    color: Colors.greenAccent, fontSize: 16.0))
                            : widget.status == 'Rejected'
                                ? TextSpan(
                                    text: widget.status,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 16.0))
                                : TextSpan(
                                    text: widget.status,
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 16.0))
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                "Site: ",
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 16.0),
                              ),
                            ),
                            DropdownButton(
                              items: sitesDropDown,
                              onChanged: changeSelectedSite,
                              value: currentSite,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        enabled: visibility,
                        controller: _siteAddressController,
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
                        enabled: visibility,
                        controller: _siteEmailController,
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
                        enabled: visibility,
                        controller: _sitePhoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText: 'Contact No',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      SizedBox(
                        height: 50.0,
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
                                orderService.product = dropdownValue;
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
                        height: 20.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: _qtyController,
                        onChanged: (value) {
                          orderService.quantity = int.parse(value);
                        },
                        focusNode: _qtyFocus,
                        onFieldSubmitted: (term) {
                          _fieldFocusChange(context, _qtyFocus, _unitFocus);
                        },
                        enabled: calVisibility,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Quantity',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter valid quantity';
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: _unitController,
                        enabled: calVisibility,
                        onChanged: (value) {
                          orderService.unit = double.parse(value);
                        },
                        focusNode: _unitFocus,
                         onFieldSubmitted: (term) {
                          _fieldFocusChange(context, _unitFocus, _totalFocus);
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Unit price',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter valid unit price';
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: _totalController,
                        focusNode: _totalFocus,
                        enabled: false,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                "Supplier: ",
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 16.0),
                              ),
                            ),
                            DropdownButton(
                              items: supplierDropDown,
                              onChanged: changeSelectedSupplier,
                              value: currentSupplier,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        enabled: visibility,
                        controller: _supAddressController,
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
                        enabled: visibility,
                        controller: _supEmailController,
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
                        enabled: visibility,
                        controller: _supPhoneController,
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
                            orderService.date.day.toString() +
                                "-" +
                                orderService.date.month.toString() +
                                "-" +
                                orderService.date.year.toString(),
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
                                        initialDate: orderService.date,
                                        firstDate: DateTime(2020),
                                        lastDate: DateTime(2033))
                                    .then((date) {
                                  setState(() {
                                    orderService.date = date;
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
                        onChanged: (value) {
                          orderService.description = value;
                        },
                      ),
                      widget.status == 'Approved'
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FlatButton(
                                    onPressed: () {},
                                    color: Colors.green,
                                    child: Text(
                                      "Place order",
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
                                        onPressed: () {
                                          orderService.delete();
                                          changeScreenReplacement(
                                              context, Home());
                                          Fluttertoast.showToast(
                                              msg: 'Order deleted!');
                                        },
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
                                        onPressed: () {
                                          handleUpdate();
                                        },
                                        color: Colors.blueAccent,
                                        child: Text(
                                          "Update",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    FlatButton(
                                        onPressed: () {
                                          orderService.delete();
                                          changeScreenReplacement(
                                              context, Home());
                                          Fluttertoast.showToast(
                                              msg: 'Order deleted!');
                                        },
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

  // retrieve data
  void getSites() async {
    List<DocumentSnapshot> data = await siteService.getSites();
    setState(() {
      sites = data;
      sitesDropDown = getSiteDropdown();
      currentSite = widget.site;
    });
    for (var i = 0; i < data.length; i++) {
      if (widget.site == data[i].data['name']) {
        setState(() {
          _siteId = data[i].data['siteId'];
          _siteAddressController.text = data[i].data['address'];
          _siteEmailController.text = data[i].data['email'];
          _sitePhoneController.text = data[i].data['contact'];
        });
      }
    }
  }

  void getSuppliers() async {
    List<DocumentSnapshot> data = await supplierService.getSuppliers();
    setState(() {
      suppliers = data;
      supplierDropDown = getSupplierDropdown();
      currentSupplier = widget.supplier;
    });

    for (var i = 0; i < data.length; i++) {
      if (widget.supplier == data[i].data['name']) {
        setState(() {
          _supplierId = data[i].data['supplierId'];
          _supAddressController.text = data[i].data['address'];
          _supEmailController.text = data[i].data['email'];
          _supPhoneController.text = data[i].data['contact'];
        });
      }
    }
  }

  // change fields when selection happen
  changeSelectedSupplier(String selected) {
    setState(() {
      currentSupplier = selected;
      for (var i = 0; i < suppliers.length; i++) {
        if (suppliers[i].data['name'] == currentSupplier) {
          orderService.supplier = suppliers[i].data['name'];
          _supAddressController.text = suppliers[i].data['address'];
          _supEmailController.text = suppliers[i].data['email'];
          _supPhoneController.text = suppliers[i].data['contact'];
        }
      }
    });
  }

  changeSelectedSite(String selected) {
    setState(() {
      currentSite = selected;
      for (var i = 0; i < sites.length; i++) {
        if (sites[i].data['name'] == currentSite) {
          orderService.site = sites[0].data['name'];
          _siteAddressController.text = sites[i].data['address'];
          _siteEmailController.text = sites[i].data['email'];
          _sitePhoneController.text = sites[i].data['contact'];
        }
      }
    });
  }

  void handleUpdate() async {
    if (_formKey.currentState.validate()) {
      orderService.status = 'Pending';
      await orderService.update();
      orderService.reset();
      changeScreenReplacement(context, Home());
      Fluttertoast.showToast(msg: 'Order updated!');
    }
  }

  // change focus
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    setState(() {
      orderService.total = orderService.quantity * orderService.unit;
      _totalController.text = orderService.total.toString();
    });
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
