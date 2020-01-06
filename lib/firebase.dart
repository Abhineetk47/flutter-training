import 'package:Demoapp/flipcoin.dart';
import 'package:flutter/material.dart';

class Firestore extends StatefulWidget {
  @override
  _FirestoreState createState() => _FirestoreState();
}

class _FirestoreState extends State<Firestore> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool visibility = true;
  bool _autoValidate = false;

  String _email;

  String _password;

  String uppercase_email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Login Form'),
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
          decoration: const InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
          onSaved: (String val) {
            _email = val;
          },
        ),
        new TextFormField(
          obscureText: visibility,
          decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: GestureDetector(
                child: Icon(Icons.visibility),
                onTap: () {
                  print("object");
                  setState(() {
                    visibility = !visibility;
                  });
                },
              )),
          keyboardType: TextInputType.visiblePassword,
          validator: validatePassword,
          onSaved: (var val) {
            _password = val;
          },
        ),
        new SizedBox(
          height: 10.0,
        ),
        new RaisedButton(
          onPressed: _validateInputs,
          child: new Text('Validate'),
        )
      ],
    );
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

  String validatePassword(String value) {
    if (value.isNotEmpty) {
      Pattern pattern =
          r'^(((?=.*[a-z])(?=.*[A-Z]))|((?=.*[a-z])(?=.*[0-9]))|((?=.*[A-Z])(?=.*[0-9])))(?=.{6,})';
      RegExp regex = new RegExp(pattern);
      if (regex.hasMatch(value)) {
        return null;
      } else
        return 'Enter valid password';
    } else
      return "Enter valid password";
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
