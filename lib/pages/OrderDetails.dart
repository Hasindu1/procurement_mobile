import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:procurementapp/model/item.dart';
import 'package:procurementapp/model/site.dart';
import 'package:procurementapp/model/supplier.dart';
import 'package:procurementapp/components/Appbar.dart';
import 'package:procurementapp/components/Drawer.dart';
import 'package:procurementapp/pages/Home.dart';
import 'package:procurementapp/service/service_provider.dart';
import 'package:procurementapp/util/routes.dart';
import 'package:uuid/uuid.dart';

class OderDetails extends StatefulWidget {
  final String orderId;
  final String status;
  final String supplier;
  final String site;
  final String product;
  final int quantity;
  final double unit;
  final DateTime rDate;
  final String description;
  final String comment;

  OderDetails(
      {this.orderId,
      this.site,
      this.supplier,
      this.status,
      this.product,
      this.quantity,
      this.unit,
      this.rDate,
      this.description,
      this.comment});

  @override
  _OderDetailsState createState() => _OderDetailsState();
}

class _OderDetailsState extends State<OderDetails> {
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
  DateTime currentDate = DateTime.now();
  String status;
  double total = 0.0;

  final _formKey = GlobalKey<FormState>();

  String dropdownValue;
  DateTime date;
  bool visibility = false;
  bool calVisibility = false;

  final FocusNode _totalFocus = FocusNode();
  final FocusNode _qtyFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _qtyController.text = widget.quantity.toString();
    _unitController.text = widget.unit.toString();
    _totalController.text = (widget.quantity * widget.unit).toString();
    _descriptionController.text = widget.description;
    _commentController.text = widget.comment;
    currentDate = widget.rDate;

    getSites();
    getSuppliers();
    getItems();
    if (widget.status == 'Pending') {
      calVisibility = true;
    }
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

  List<DropdownMenuItem<String>> getItemDropdown() {
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
                        height: 20.0,
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
                          _fieldFocusChange(context, _qtyFocus, _totalFocus);
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
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: _unitController,
                        enabled: false,
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
                            return null;
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
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: _commentController,
                        decoration: InputDecoration(
                            labelText: 'Comment',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                      widget.status == 'Approved'
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      handlePlace();
                                    },
                                    color: Colors.green,
                                    child: Text(
                                      "Place order",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                SizedBox(
                                  width: 5.0,
                                ),
                                FlatButton(
                                    onPressed: () {
                                      serviceProvider
                                          .deleteOrder(widget.orderId);
                                      changeScreenReplacement(context, Home());
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
                          : widget.status == 'Rejected'
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          serviceProvider
                                              .deleteOrder(widget.orderId);
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
                                          serviceProvider
                                              .deleteOrder(widget.orderId);
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

  // get data of suppliers and assign to site list and call dropdown
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
        break;
      }
    }
  }

  // get data of sites and assign to supplier list and call dropdown
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
        break;
      }
    }
  }

  // get data of items and assign to items list and call dropdown
  void getItems() async {
    List<Item> data = await serviceProvider.getItems();
    setState(() {
      items = data;
      itemsDropDown = getItemDropdown();
      currentItem = widget.product;
    });
  }

  // change fields when selection happen in supplier dropdown
  changeSelectedSupplier(String selected) {
    setState(() {
      currentSupplier = selected;
      for (var i = 0; i < suppliers.length; i++) {
        if (suppliers[i].name == currentSupplier) {
          _supAddressController.text = suppliers[i].address;
          _supEmailController.text = suppliers[i].email;
          _supPhoneController.text = suppliers[i].contact;
          break;
        }
      }
    });
  }

  // change fields when selection happen in site dropdown
  changeSelectedSite(String selected) {
    setState(() {
      currentSite = selected;
      for (var i = 0; i < sites.length; i++) {
        if (sites[i].name == currentSite) {
          _siteAddressController.text = sites[i].address;
          _siteEmailController.text = sites[i].email;
          _sitePhoneController.text = sites[i].contact;
          break;
        }
      }
    });
  }

  // change fields when selection happen in item dropdown
  changeSelectedItem(String selected) {
    setState(() {
      currentItem = selected;
      for (var i = 0; i < items.length; i++) {
        if (items[i].name == currentItem) {
          _unitController.text = items[i].price.toString();
          total = items[i].price * int.parse(_qtyController.text);
          _totalController.text = total.toString();
          break;
        }
      }
    });
  }

  // update details regarding to order
  void handleUpdate() async {
    if (_formKey.currentState.validate()) {
      String status = "Pending";
      if (total < 100000) {
        status = 'Approved';
      }
      await serviceProvider.updateOrder(
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
      changeScreenReplacement(context, Home());
      Fluttertoast.showToast(msg: 'Order updated!');
    }
  }

  // update status of order as Placed
  void handlePlace() async {
    if (_formKey.currentState.validate()) {
      String status = 'Placed';
      await serviceProvider.updateOrder(
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
      await serviceProvider.createDelivery(
          deliveryId: Uuid().v1().toString(),
          orderRef: widget.orderId,
          item: currentItem,
          isPayed: false);
      changeScreenReplacement(context, Home());
      Fluttertoast.showToast(msg: 'Order updated!');
    }
  }

  // change focus node
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
