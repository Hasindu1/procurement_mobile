import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:procurementapp/pages/Home.dart';
import 'package:procurementapp/service/item.dart';
import 'package:procurementapp/service/order.dart';
import 'package:procurementapp/service/site.dart';
import 'package:procurementapp/service/supplier.dart';
import 'package:procurementapp/util/routes.dart';
import 'package:uuid/uuid.dart';

class NewOrder extends StatefulWidget {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  // variables
  var uuid = Uuid().v1();
  final _formKey = GlobalKey<FormState>();

  SupplierService supplierService = SupplierService();
  SiteService siteService = SiteService();
  OrderService orderService = OrderService();
  ItemService itemService = ItemService();

  List<DocumentSnapshot> sites = <DocumentSnapshot>[];
  List<DocumentSnapshot> suppliers = <DocumentSnapshot>[];
  List<DocumentSnapshot> items = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> sitesDropDown = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> itemsDropDown = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> supplierDropDown =
      <DropdownMenuItem<String>>[];
  String currentSite;
  String currentSupplier;
  String currentItem;

  final FocusNode _totalFocus = FocusNode();
  final FocusNode _unitFocus = FocusNode();
  final FocusNode _qtyFocus = FocusNode();

  TextEditingController _refeController = TextEditingController();
  TextEditingController _siteAddressController = TextEditingController();
  TextEditingController _siteEmailController = TextEditingController();
  TextEditingController _sitePhoneController = TextEditingController();
  TextEditingController _qtyController = TextEditingController();
  TextEditingController _unitController = TextEditingController();
  TextEditingController _totalController = TextEditingController();
  String dropdownValue = 'One';

  TextEditingController _supAddressController = TextEditingController();
  TextEditingController _supEmailController = TextEditingController();
  TextEditingController _supPhoneController = TextEditingController();
  TextEditingController _supDescController = TextEditingController();
  TextEditingController _supCommentController = TextEditingController();
  DateTime date;

  @override
  void initState() {
    super.initState();
    getSuppliers();
    getSites();
    getItems();
    date = DateTime.now();
    _refeController.text = uuid.toString();
    orderService.product = dropdownValue;
    orderService.id = _refeController.text;
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

  List<DropdownMenuItem<String>> getItemsDropdown() {
    List<DropdownMenuItem<String>> list = new List();
    for (int i = 0; i < items.length; i++) {
      setState(() {
        list.insert(
            0,
            DropdownMenuItem(
              child: Text(items[i].data['name']),
              value: items[i].data['name'],
            ));
      });
    }
    return list;
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
                          controller: _refeController,
                          enabled: false,
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
                        height: 10.0,
                      ),
                      TextFormField(
                          enabled: false,
                          controller: _siteAddressController,
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
                          enabled: false,
                          controller: _siteEmailController,
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
                          enabled: false,
                          controller: _sitePhoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: 'Contact No',
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
                        height: 10.0,
                      ),
                      TextFormField(
                          enabled: false,
                          controller: _supAddressController,
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
                          enabled: false,
                          controller: _supEmailController,
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
                          enabled: false,
                          controller: _supPhoneController,
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
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                "Item: ",
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 16.0),
                              ),
                            ),
                            DropdownButton(
                              items: itemsDropDown,
                              onChanged: changeSelectedItem,
                              value: currentItem,
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                          onChanged: (value) {
                            orderService.quantity = int.parse(value);
                          },
                          focusNode: _qtyFocus,
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(context, _qtyFocus, _totalFocus);
                          },
                          controller: _qtyController,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Enter quantity';
                            else
                              return null;
                          },
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
                          enabled: false,
                          controller: _unitController,
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
                          enabled: false,
                          controller: _totalController,
                          focusNode: _totalFocus,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Total Price',
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
                          Expanded(
                            child: IconButton(
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
                              }),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                          controller: _supDescController,
                          onChanged: (value) {
                            orderService.description = value;
                          },
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
                        controller: _supCommentController,
                        keyboardType: TextInputType.multiline,
                        onChanged: (value) {
                          orderService.comment = value;
                        },
                        decoration: InputDecoration(
                            labelText: 'Comment',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                handleSubmit();
                              },
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
                              onPressed: () {
                                handleSave();
                              },
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
                              onPressed: () {
                                handleSave();
                              },
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

  // get data
  getSuppliers() async {
    List<DocumentSnapshot> data = await supplierService.getSuppliers();
    setState(() {
      suppliers = data;
      supplierDropDown = getSupplierDropdown();
      currentSupplier = suppliers[0].data['name'];
      orderService.supplier = suppliers[0].data['name'];
      _supAddressController.text = suppliers[0].data['address'];
      _supEmailController.text = suppliers[0].data['email'];
      _supPhoneController.text = suppliers[0].data['contact'];
    });
  }

  getSites() async {
    List<DocumentSnapshot> data = await siteService.getSites();
    setState(() {
      sites = data;
      sitesDropDown = getSiteDropdown();
      currentSite = sites[0].data['name'];
      orderService.site = sites[0].data['name'];
      _siteAddressController.text = sites[0].data['address'];
      _siteEmailController.text = sites[0].data['email'];
      _sitePhoneController.text = sites[0].data['contact'];
    });
  }

  getItems() async {
    List<DocumentSnapshot> data = await itemService.getItems();

    setState(() {
      items = data;
      itemsDropDown = getItemsDropdown();
      currentItem = items[0].data['name'];
      orderService.product = items[0].data['name'];
      _unitController.text = items[0].data['unit_price'].toString();
      orderService.unit = items[0].data['unit_price'];
    });
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

  changeSelectedItem(String selected) {
    setState(() {
      currentItem = selected;
      for (var i = 0; i < items.length; i++) {
        if (items[i].data['name'] == currentItem) {
          _unitController.text = items[i].data['unit_price'].toString();
          orderService.unit = items[i].data['unit_price'];
          orderService.product = items[i].data['name'];
        }
      }
    });
  }

  // change node
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    setState(() {
      orderService.total = orderService.quantity * orderService.unit;
      _totalController.text = orderService.total.toString();
    });
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void handleSubmit() async {
    if (_formKey.currentState.validate()) {
      if (orderService.total <= 100000) {
        orderService.status = 'Approved';
      } else {
        orderService.status = 'Pending';
      }
      await orderService.createOrder();
      _formKey.currentState.reset();
      orderService.reset();
      changeScreenReplacement(context, Home());
      Fluttertoast.showToast(msg: "Order created");
    }
  }

  void handleSave() async {
    if (_formKey.currentState.validate()) {
      if (orderService.total <= 100000) {
        orderService.status = 'Approved';
      } else {
        orderService.status = 'Pending';
      }
      orderService.draft = true;
      await orderService.createOrder();
      _formKey.currentState.reset();
      orderService.reset();
      changeScreenReplacement(context, Home());
      Fluttertoast.showToast(msg: "Order saved");
    }
  }
}
