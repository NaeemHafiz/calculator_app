import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Simple Interest Calculator App",
    home: SIForm(),
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
  var _currencies = {"Rupees", "Dollars", "Pounds"};
  final _minimumPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Interest Calculator App"),
      ),
      body: Container(
        child: Column(
          children: [
            getImageAssets(),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Principal',
                        hintText: 'Enter Principal e.g. 1200',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))))),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Rate Of Interest',
                  hintText: 'In Percent',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ],
        ),
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
}
