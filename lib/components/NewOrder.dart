import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:procurementapp/model/item.dart';
import 'package:procurementapp/model/site.dart';
import 'package:procurementapp/model/supplier.dart';
import 'package:procurementapp/pages/Home.dart';
import 'package:procurementapp/service/service_provider.dart';
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

  ServiceProvider serviceProvider = new ServiceProvider();

  List<Site> sites = <Site>[];
  List<Supplier> suppliers = <Supplier>[];
  List<Item> items = <Item>[];
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

  final FocusNode _totalFocus = FocusNode();
  final FocusNode _qtyFocus = FocusNode();

  TextEditingController _refeController = TextEditingController();
  TextEditingController _siteAddressController = TextEditingController();
  TextEditingController _siteEmailController = TextEditingController();
  TextEditingController _sitePhoneController = TextEditingController();
  TextEditingController _qtyController = TextEditingController();
  TextEditingController _unitController = TextEditingController();
  TextEditingController _totalController = TextEditingController();

  TextEditingController _supAddressController = TextEditingController();
  TextEditingController _supEmailController = TextEditingController();
  TextEditingController _supPhoneController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  DateTime date;

  @override
  void initState() {
    super.initState();
    getSuppliers();
    getSites();
    getItems();

    date = DateTime.now();
    _refeController.text = uuid.toString();
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
                          controller: _descController,
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
                        controller: _commentController,
                        keyboardType: TextInputType.multiline,
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

  // get data of suppliers and assign to suppliers list and call dropdown
  getSuppliers() async {
    List<Supplier> data = await serviceProvider.getSuppliers();
    setState(() {
      suppliers = data;
      supplierDropDown = getSupplierDropdown();
      currentSupplier = suppliers[0].name;
      _supAddressController.text = suppliers[0].address;
      _supEmailController.text = suppliers[0].email;
      _supPhoneController.text = suppliers[0].contact;
    });
  }

  // get data of sites and assign to sites list and call dropdown
  getSites() async {
    List<Site> data = await serviceProvider.getSites();
    setState(() {
      sites = data;
      sitesDropDown = getSiteDropdown();
      currentSite = sites[0].name;
      _siteAddressController.text = sites[0].address;
      _siteEmailController.text = sites[0].email;
      _sitePhoneController.text = sites[0].contact;
    });
  }

  // get data of items and assign to items list and call dropdown
  getItems() async {
    List<Item> data = await serviceProvider.getItems();
    setState(() {
      items = data;
      itemsDropDown = getItemsDropdown();
      currentItem = items[0].name;
      _unitController.text = items[0].unit_price.toString();
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
          _unitController.text = items[i].unit_price.toString();
        }
      }
    });
  }

  // change node
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

  /* check form valid or not and
    call createOrder method defined in ServiceProvider
   */
  void handleSubmit() async {
    if (_formKey.currentState.validate()) {
      if (total <= 100000) {
        status = 'Approved';
      } else {
        status = 'Pending';
      }
      await serviceProvider.createOrder(
          id: _refeController.text,
          site: currentSite,
          supplier: currentSupplier,
          product: currentItem,
          quantity: int.parse(_qtyController.text),
          unit: double.parse(_unitController.text),
          total: double.parse(_totalController.text),
          date: currentDate,
          description: _descController.text,
          comment: _commentController.text,
          status: status,
          remarks: null,
          draft: false);
      _formKey.currentState.reset();
      changeScreenReplacement(context, Home());
      Fluttertoast.showToast(msg: "Order created");
    }
  }

  /* check form valid or not,
    check total budget and assign status,
    set draft as true and call createOrder method
    defined in ServiceProvider
   */
  void handleSave() async {
    if (_formKey.currentState.validate()) {
      if (total <= 100000) {
        status = 'Approved';
      } else {
        status = 'Pending';
      }
      await serviceProvider.createOrder(
          id: _refeController.text,
          site: currentSite,
          supplier: currentSupplier,
          product: currentItem,
          quantity: int.parse(_qtyController.text),
          unit: double.parse(_unitController.text),
          total: double.parse(_totalController.text),
          date: currentDate,
          description: _descController.text,
          comment: _commentController.text,
          status: status,
          remarks: null,
          draft: true);
      _formKey.currentState.reset();
      changeScreenReplacement(context, Home());
      Fluttertoast.showToast(msg: "Order saved");
    }
  }
}
