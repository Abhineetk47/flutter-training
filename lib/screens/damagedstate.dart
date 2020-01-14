import 'package:Demoapp/common_widgets/customcard.dart';
import 'package:Demoapp/modal/scopedmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:scoped_model/scoped_model.dart';

class Damagedassets extends StatefulWidget {
  Damagedassets({
    Key key,
    this.uid,
  }) : super(key: key); //update this to include the uid in the constructor
  final String title = "Incident Reporting";
  final String uid; //include this

  @override
  _DamagedassetsState createState() => _DamagedassetsState();
}

class _DamagedassetsState extends State<Damagedassets> {
  FirebaseModel firemodel;
  PermissionStatus _status;
  FirebaseUser currentUser;
  final db = Firestore.instance;
  DocumentReference result;
  var docRef;
  String docid;
  List<String> ids;
  @override
  initState() {
    firemodel = FirebaseModel(widget.uid);
    firemodel.taskTitleInputController = new TextEditingController();
    firemodel.taskDescripInputController = new TextEditingController();
    this.getCurrentUser();
    super.initState();
    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.camera)
        .then(firemodel.updateStatus);
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<FirebaseModel>(
      model: firemodel,
      child: Scaffold(
        body: Center(
          child: Container(
              padding: const EdgeInsets.all(20.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection("incidents")
                    .document(widget.uid)
                    .collection('damaged_assets')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  // ids.add(docid);
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      return new ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return new Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment(1, 0),
                                child: GestureDetector(
                                  onTap: () {
                                    deleteData(document.documentID);
                                  },
                                  child: Icon(Icons.cancel),
                                ),
                              ),
                              CustomCard(
                                  title: document['title'],
                                  description: document['description'],
                                  uploadedFileURL: document['image'],
                                  uid: widget.uid,
                                  docid: docid)
                            ],
                          );
                        }).toList(),
                      );
                  }
                },
              )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showDialog,
          tooltip: 'Add',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  deleteData(String docid) {
    try {
      print("starting of the delete method");
      db
          .collection("incidents")
          .document(widget.uid)
          .collection("damaged_assets")
          .document(docid)
          .delete();

      print("here is the doc id -----$docid");
    } catch (e) {
      print(" here is the exception while deleting $e");
    }
  }

  void displayOptionsDialog() async {
    optionsDialogBox();
  }

  Future<void> optionsDialogBox() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          print("reached dialog box");
          return AlertDialog(
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: new Text('Take Photo'),
                    onTap: firemodel.askPermission,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                      child: new Text('Select Image From Gallery'),
                      onTap: () {
                        firemodel.chooseFile();
                        Navigator.of(context, rootNavigator: true).pop();
                      }),
                ],
              ),
            ),
          );
        });
  }

  _showDialog() async {
    showDialog<String>(
        context: context,
        child: ScopedModel<FirebaseModel>(
          model: firemodel,
          child: ScopedModelDescendant<FirebaseModel>(
            builder: (context, child, model) {
              model = firemodel;
              return AlertDialog(
                //contentPadding: const EdgeInsets.all(16.0),
                content: SizedBox.expand(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Add your own incidents"),
                        SizedBox(
                          height: 5,
                        ),
                        firemodel.image != null
                            ? Image.asset(
                                firemodel.image.path,
                                height: 150,
                              )
                            : SizedBox(height: 10),
                        SizedBox(
                          height: 10,
                        ),
                        firemodel.image == null
                            ? RaisedButton(
                                child: Text('Choose File'),
                                onPressed: displayOptionsDialog,
                                color: Colors.cyan,
                              )
                            : Container(),
                        TextFormField(
                          controller: firemodel.taskTitleInputController,
                          decoration: InputDecoration(
                            hintText: "title",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: firemodel.taskDescripInputController,
                          decoration: InputDecoration(
                            hintText: "Description",
                            hintMaxLines: 2,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ]),
                ),
                actions: <Widget>[
                  FlatButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        firemodel.taskTitleInputController.clear();
                        firemodel.taskDescripInputController.clear();
                        firemodel.image = null;
                        Navigator.of(context, rootNavigator: true).pop();
                      }),
                  FlatButton(
                      child: Text('Add'),
                      onPressed: () async {
                        if (firemodel
                                .taskDescripInputController.text.isNotEmpty &&
                            firemodel
                                .taskTitleInputController.text.isNotEmpty) {
                          firemodel.uploadFile();
                          print(" the value of the uid is -----${widget.uid}");

                          firemodel.image = null;

                          docRef = await db
                              .collection("incidents")
                              .document(widget.uid)
                              .collection("damaged_assets")
                              .add({
                                "category": "damaged_assets",
                                "title":
                                    firemodel.taskTitleInputController.text,
                                "description":
                                    firemodel.taskDescripInputController.text,
                                "image": firemodel.uploadedFileURL
                              })
                              .then((result) => {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop(),
                                    firemodel.taskTitleInputController.clear(),
                                    firemodel.taskDescripInputController
                                        .clear(),
                                    print("objecttttttttttttt"),
                                    docid = result.documentID,
                                    print("${result.documentID}t")
                                  })
                              .catchError((err) => print(err));
                          print(
                              "here is the document id of uploaded document ${docRef.documentID}");
                        }
                      })
                ],
              );
            },
          ),
        ));
  }
}
