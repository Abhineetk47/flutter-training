import 'package:Demoapp/Screens/incidents_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  bool visibility = true;
  bool _autoValidate = false;

  String _email;

  String _password;

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
            key: _loginFormKey,
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
          controller: emailInputController,
          decoration: const InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
          onSaved: (String val) {
            _email = val;
          },
        ),
        new TextFormField(
          controller: pwdInputController,
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
          child: new Text('Login'),
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
    if (_loginFormKey.currentState.validate()) {
      _loginFormKey.currentState.save();
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((currentUser) => Firestore.instance
              .collection("incidents")
              .document(currentUser.user.uid)
              .get()
              .then((DocumentSnapshot result) => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IncidentList(
                            email: _email,
                            //title: result["fname"] + "'s Tasks",
                            uid: currentUser.user.uid,
                          ))))
              .catchError((err) => print(err)))
          .catchError((err) => print(err));
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
