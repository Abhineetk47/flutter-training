import 'package:Demoapp/bookflite.dart';
import 'package:flutter/material.dart';
import 'package:Demoapp/flipcoin.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Myhome(),
    );
  }
}

class Myhome extends StatefulWidget {
  @override
  _MyhomeState createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;

  String _name;

  String _email;

  String _mobile;

  var _age;

  String uppercase_email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Registration Form'),
      ),
      body: new SingleChildScrollView(
        child: new Container(
          margin: new EdgeInsets.all(15.0),
          child: new Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: formUI(),
          ),
        ),
      ),
    );
  }

  Widget formUI() {
    return new Column(
      children: <Widget>[
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Name'),
          keyboardType: TextInputType.text,
          validator: validateName,
          onSaved: (String val) {
            _name = val;
          },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Age'),
          keyboardType: TextInputType.number,
          validator: validateAge,
          onSaved: (var val) {
            _age = val;
          },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Mobile'),
          keyboardType: TextInputType.phone,
          validator: validateMobile,
          onSaved: (String val) {
            _mobile = val;
          },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
          onSaved: (String val) {
            _email = val;
          },
        ),
        new SizedBox(
          height: 10.0,
        ),
        new RaisedButton(
          onPressed: _validateInputs,
          child: new Text('Validate'),
        ),
        RaisedButton(
          child: Text("Skip"),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BookFlite()));
          },
        )
      ],
    );
  }

  String validateName(String value) {
    if (value.length > 2) {
      Pattern pattern1 = r'^[a-zA-Z ]*$';
      RegExp regex1 = new RegExp(pattern1);
      if (regex1.hasMatch(value)) {
        return null;
      } else
        return 'Enter valid name';
    } else
      return "Enter valid name";
  }

  String validateMobile(String value) {
    if (value.isNotEmpty) {
      Pattern pattern1 =
          r'^([1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9])$';
      RegExp regex1 = new RegExp(pattern1);
      if (regex1.hasMatch(value)) {
        return null;
      } else
        return 'Enter valid mobile number';
    } else
      return "Enter valid number";
  }

  String validateAge(String value) {
    if (value.isNotEmpty) {
      Pattern pattern1 = r'^([0-9][0-9])$';
      Pattern pattern2 = r'^([1-9])$';
      RegExp regex1 = new RegExp(pattern1);
      RegExp regex2 = new RegExp(pattern2);
      if (regex1.hasMatch(value) || regex2.hasMatch(value)) {
        return null;
      } else
        return 'Enter valid age';
    } else
      return "Enter valid age";
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      uppercase_email = _email.toUpperCase();
      print("$uppercase_email");
      Navigator.push(context, MaterialPageRoute(builder: (context) => Flip()));
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
