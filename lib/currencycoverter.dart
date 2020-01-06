import 'package:Demoapp/stopwatch.dart';
import 'package:flutter/material.dart';

class PriceConversion extends StatefulWidget {
  @override
  _PriceConversionState createState() => _PriceConversionState();
}

class _PriceConversionState extends State<PriceConversion> {
  Map<String, Map<String, String>> conversionMap;
  final amountInputController = TextEditingController(text: '0');
  double inputAmount;
  double outputAmount;
  String country = 'India';
  List<String> countryList = ['India', 'USA', 'Japan', 'China'];
  bool amountValue = false;

  @override
  void initState() {
    conversionMap = {
      'India': {
        'Currency': 'Rupees',
        'Multiplier': '1',
      },
      'China': {'Currency': 'Yuan', 'Multiplier': '0.098'},
      'USA': {'Currency': 'USD', 'Multiplier': '0.014'},
      'Japan': {'Currency': 'Yen', 'Multiplier': ' 1.52'}
    };

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Currency Converter'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidate: true,
                  validator: validateInput,
                  onChanged: convert(),
                  decoration: InputDecoration(
                    hintText: 'Enter amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  controller: amountInputController,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 200,
                  child: DropdownButton(
                    items: countryList.map((country) {
                      return DropdownMenuItem(
                        child: Text(country),
                        value: country,
                      );
                    }).toList(),
                    value: country,
                    onChanged: (value) {
                      setState(() {
                        country = value;
                        amountValue = true;
                      });
                    },
                    hint: Text('Please select a country'),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Text(
                    "Your total amount is $outputAmount ${conversionMap[country]['Currency']}"),
                SizedBox(
                  height: 50,
                ),
                RaisedButton(
                  child: Text("want to see stopwatch"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Myhomepage()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  convert() {
    setState(() {
      inputAmount = double.parse(amountInputController.text);
      outputAmount =
          inputAmount * double.parse(conversionMap[country]['Multiplier']);
    });
  }

  String validateInput(String value) {
    if (value.isNotEmpty) {
      Pattern pattern1 = r'^[0-9]*$';
      RegExp regex1 = new RegExp(pattern1);
      if (regex1.hasMatch(value)) {
        return null;
      } else
        return 'Enter valid amount';
    } else
      return "Enter valid amount";
  }
}
