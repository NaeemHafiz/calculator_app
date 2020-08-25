import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest Calculator App",
    home: SIForm(),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();
  var _currencies = ["Rupees", "Dollars", "Pounds"];
  final _minimumPadding = 5.0;

  var _currentItemSelected = '';

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Simple Interest Calculator App"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: [
                getImageAssets(),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: textStyle,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please enter principal amount";
                      }
                    },
                    controller: principalController,
                    decoration: InputDecoration(
                      labelText: 'Principal',
                      labelStyle: textStyle,
                      errorStyle:
                          TextStyle(color: Colors.yellowAccent, fontSize: 15.0),
                      hintText: 'Enter Principal e.g. 1200',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please enter rate of interest";
                      }
                    },
                    controller: roiController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: 'Rate Of Interest',
                      hintText: 'In Percent',
                      errorStyle:
                          TextStyle(color: Colors.yellowAccent, fontSize: 15.0),
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: textStyle,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please enter time";
                            }
                          },
                          controller: termController,
                          decoration: InputDecoration(
                            labelText: 'Term',
                            errorStyle: TextStyle(
                                color: Colors.yellowAccent, fontSize: 15.0),
                            labelStyle: textStyle,
                            hintText: 'Time in years',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currentItemSelected,
                          onChanged: (String newValueSelected) {
                            //Code to execute when menu item is selected
                            _onDropdownItemSelected(newValueSelected);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(),
                  child: Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          child: Text(
                            'Calculate',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState.validate()) {
                                this.displayResult = _calculateTotalReturns();
                              }
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Reset',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _reset();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                    this.displayResult,
                    style: textStyle,
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget getImageAssets() {
    AssetImage assetImage = AssetImage('images/image.jpg');
    Image image = Image(image: assetImage, width: 125.0, height: 125.0);
    return Container(
      margin: EdgeInsets.only(top: 70.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: image,
      ),
    );
  }

  void _onDropdownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(principalController.text);
    double term = double.parse(principalController.text);

    double totalAmountPayable = principal + (principal * roi * term);
    String result =
        'After $term years,your investment will be worth $totalAmountPayable $_currentItemSelected';
    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}
