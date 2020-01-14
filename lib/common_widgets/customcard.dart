import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  CustomCard(
      {@required this.title,
      this.description,
      this.uploadedFileURL,
      this.uid,
      this.docid});
  //Function deletedata;
  final title;
  final description;
  final String uploadedFileURL;
  final String uid;
  final String docid;
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    print("here is the url is the image uploaded $uploadedFileURL");
    return Card(
        key: UniqueKey(),
        color: Colors.white,
        elevation: 2,
        child: Container(
            padding: const EdgeInsets.only(top: 5.0, left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                uploadedFileURL !=
                        null // uploaded image we can get through the url from the network
                    ? Image.network(
                        uploadedFileURL,
                        height: 200,
                      )
                    : Container(),
                SizedBox(
                  height: 8,
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Container(
                  alignment: Alignment(1, 0),
                  child: FlatButton(
                      child: Text(
                        "See More",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {}),
                ),
              ],
            )));
  }
}
