import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .title;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
        title: Text("Simple Interest Calculator App"),
    ),
    body: Form(
    child:Padding(padding:EdgeInsets.all(_minimumPadding * 2),
    child: ListView(
    children: [
    getImageAssets(),
    Padding(
    padding: EdgeInsets.only(
    top: _minimumPadding, bottom: _minimumPadding),
    child: TextField(
    keyboardType: TextInputType.number,
    style: textStyle,
    controller: principalController,
    decoration: InputDecoration(
    labelText: 'Principal',
    labelStyle: textStyle,
    hintText: 'Enter Principal e.g. 1200',
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0)),
    ),
    ),
    ),
    Padding(
    padding: EdgeInsets.only(
    top: _minimumPadding, bottom: _minimumPadding),
    child: TextField(
    style: textStyle,
    controller: roiController,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
    labelText: 'Rate Of Interest',
    hintText: 'In Percent',
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
    child: TextField(
    keyboardType: TextInputType.number,
    style: textStyle,
    controller: termController,
    decoration: InputDecoration(
    labelText: 'Term',
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
    this.displayResult = _calculateTotalReturns();
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
    )
    ,
    )
    ,
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
