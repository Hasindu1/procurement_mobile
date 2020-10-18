import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:procurementapp/components/Appbar.dart';
import 'package:procurementapp/components/Drawer.dart';
import 'package:procurementapp/model/item.dart';
import 'package:procurementapp/model/site.dart';
import 'package:procurementapp/model/supplier.dart';
import 'package:procurementapp/pages/Draft.dart';
import 'package:procurementapp/service/service_provider.dart';
import 'package:procurementapp/util/routes.dart';

class DraftDetails extends StatefulWidget {
  final String orderId;
  final String supplier;
  final String site;
  final String product;
  final int quantity;
  final double total;
  final double unit;
  final DateTime rDate;
  final String description;
  final String comment;
  final bool isCompleted;

  DraftDetails(
      {this.orderId,
      this.site,
      this.supplier,
      this.product,
      this.quantity,
      this.total,
      this.unit,
      this.rDate,
      this.description,
      this.comment,
      this.isCompleted});

  @override
  _DraftDetailsState createState() => _DraftDetailsState();
}

class _DraftDetailsState extends State<DraftDetails> {
  ServiceProvider serviceProvider = new ServiceProvider();

  List<Site> sites = <Site>[];
  List<Supplier> suppliers = <Supplier>[];
  List<Item> items = <Item>[];

  TextEditingController _siteAddressController = TextEditingController();
  TextEditingController _siteEmailController = TextEditingController();
  TextEditingController _sitePhoneController = TextEditingController();

  TextEditingController _qtyController = TextEditingController();
  TextEditingController _unitController = TextEditingController();
  TextEditingController _totalController = TextEditingController();

  TextEditingController _supAddressController = TextEditingController();
  TextEditingController _supEmailController = TextEditingController();
  TextEditingController _supPhoneController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _commentController = TextEditingController();

  List<DropdownMenuItem<String>> sitesDropDown = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> itemsDropDown = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> supplierDropDown =
      <DropdownMenuItem<String>>[];
  String currentSite;
  String currentSupplier;
  String currentItem;

  final _formKey = GlobalKey<FormState>();

  DateTime currentDate;
  double total = 0.0;
  String dropdownValue;
  DateTime date;
  bool visibility = false;

  final FocusNode _totalFocus = FocusNode();
  final FocusNode _unitFocus = FocusNode();
  final FocusNode _qtyFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _totalController.text = widget.total.toString();
    _qtyController.text = widget.quantity.toString();
    _descriptionController.text = widget.description;
    _commentController.text = widget.comment;
    currentDate = widget.rDate;

    getSites();
    getSuppliers();
    getItems();
  }

  // return dropdown with relevant data
  List<DropdownMenuItem<String>> getSiteDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < sites.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
              child: Text(sites[i].name),
              value: sites[i].name,
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
              child: Text(suppliers[i].name),
              value: suppliers[i].name,
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
              child: Text(items[i].name),
              value: items[i].name,
            ));
      });
    }
    return list;
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
                        controller: _qtyController,
                        focusNode: _qtyFocus,
                        onFieldSubmitted: (term) {
                          _fieldFocusChange(context, _qtyFocus, _unitFocus);
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Quantity',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter valid quantity';
                          } else {
                            return '';
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: _unitController,
                        enabled: false,
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
                          } else {
                            return '';
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
                            currentDate.day.toString() +
                                "-" +
                                currentDate.month.toString() +
                                "-" +
                                currentDate.year.toString(),
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
                                          initialDate: currentDate,
                                          firstDate: DateTime(2020),
                                          lastDate: DateTime(2033))
                                      .then((date) {
                                    setState(() {
                                      currentDate = date;
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
                        controller: _descriptionController,
                        decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: _commentController,
                        decoration: InputDecoration(
                            labelText: 'Comment',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                              onPressed: () {
                                handleUpdate();
                              },
                              color: Colors.green,
                              child: Text(
                                "Create",
                                style: TextStyle(color: Colors.white),
                              )),
                          SizedBox(
                            width: 5.0,
                          ),
                          FlatButton(
                              onPressed: () async {
                                await serviceProvider
                                    .deleteOrder(widget.orderId);
                              },
                              color: Colors.red,
                              child: Text(
                                "Discard",
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
    List<Site> data = await serviceProvider.getSites();
    setState(() {
      sites = data;
      sitesDropDown = getSiteDropdown();
      currentSite = widget.site;
    });
    for (var i = 0; i < data.length; i++) {
      if (widget.site == data[i].name) {
        setState(() {
          _siteAddressController.text = data[i].address;
          _siteEmailController.text = data[i].email;
          _sitePhoneController.text = data[i].contact;
        });
      }
    }
  }

  void getSuppliers() async {
    List<Supplier> data = await serviceProvider.getSuppliers();
    setState(() {
      suppliers = data;
      supplierDropDown = getSupplierDropdown();
      currentSupplier = widget.supplier;
    });

    for (var i = 0; i < data.length; i++) {
      if (widget.supplier == data[i].name) {
        setState(() {
          _supAddressController.text = data[i].address;
          _supEmailController.text = data[i].email;
          _supPhoneController.text = data[i].contact;
        });
      }
    }
  }

  void getItems() async {
    List<Item> data = await serviceProvider.getItems();
    setState(() {
      items = data;
      itemsDropDown = getItemsDropdown();
      currentItem = widget.product;
    });

    for (var i = 0; i < data.length; i++) {
      if (widget.product == data[i].name) {
        setState(() {
          _unitController.text = data[i].price.toString();
          total = data[i].price * widget.quantity;
          _totalController.text = total.toString();
        });
      }
    }
  }

  // change fields when selection happen
  changeSelectedSupplier(String selected) {
    setState(() {
      currentSupplier = selected;
      for (var i = 0; i < suppliers.length; i++) {
        if (suppliers[i].name == currentSupplier) {
          _supAddressController.text = suppliers[i].address;
          _supEmailController.text = suppliers[i].email;
          _supPhoneController.text = suppliers[i].contact;
        }
      }
    });
  }

  changeSelectedSite(String selected) {
    setState(() {
      currentSite = selected;
      for (var i = 0; i < sites.length; i++) {
        if (sites[i].name == currentSite) {
          _siteAddressController.text = sites[i].address;
          _siteEmailController.text = sites[i].email;
          _sitePhoneController.text = sites[i].contact;
        }
      }
    });
  }

  changeSelectedItem(String selected) {
    setState(() {
      currentItem = selected;
      for (var i = 0; i < items.length; i++) {
        if (items[i].name == currentItem) {
          _unitController.text = items[i].price.toString();
          total = int.parse(_qtyController.text) *
              double.parse(_unitController.text);
          _totalController.text = total.toString();
        }
      }
    });
  }

  void handleUpdate() {
    String status = "Pending";
    if (total < 100000) {
      status = "Approved";
    }
    serviceProvider.updateOrder(
        id: widget.orderId,
        site: currentSite,
        supplier: currentSupplier,
        product: currentItem,
        quantity: int.parse(_qtyController.text),
        unit: double.parse(_unitController.text),
        date: currentDate,
        description: _descriptionController.text,
        comment: _commentController.text,
        status: status,
        budget: total,
        isCompleted: false);
    Fluttertoast.showToast(msg: 'Order created!');
    changeScreenReplacement(context, Draft());
  }

  // change focus
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    setState(() {
      total =
          int.parse(_qtyController.text) * double.parse(_unitController.text);
      _totalController.text = total.toString();
    });
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
