import 'package:Demoapp/Screens/camera.dart';
import 'package:Demoapp/Screens/damagedstate.dart';
import 'package:Demoapp/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IncidentList extends StatefulWidget {
  final String uid;
  final String email;
  const IncidentList({Key key, this.uid, this.email}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return IncidentList_State();
  }
}

class IncidentList_State extends State<IncidentList> {
  final drawerItems = [
    new DrawerItem("Damaged Assets", Icons.home),
    new DrawerItem("Hygiene", Icons.assignment),
    new DrawerItem("Home to Heaven", Icons.accessibility_new),
    new DrawerItem("Good Behaviour", Icons.healing),
    new DrawerItem("See All", Icons.speaker_group),
  ];
  //var drawerOptions = [];
  int _selectedDrawerIndex = 0;
  final _scafoldkey = GlobalKey();
// Add click lisener to navigation item
  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new Damagedassets(uid: widget.uid);
      case 1:
        return new Hygiene();
      case 2:
        return new Camera();
      case 3:
        return new GoodBehaviour();
      default:
        return new Text("It is coming sooon.!!!!!!");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
  }

  @override
  Widget build(BuildContext context) {
//
    List<Widget> drawerOptions = [];
    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }
    //

    return MaterialApp(
      home: Scaffold(
        key: _scafoldkey,
        appBar: AppBar(title: Text("Incident Report"), actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (value) {
              FirebaseAuth.instance.signOut().then((result) =>
                  Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()))
                      .catchError((err) => print(err)));
            },
            itemBuilder: (context) => [
              // PopupMenuItem(
              //   value: 1,
              //   child: Text(
              //     "Logout",
              //     style: TextStyle(
              //         color: Colors.black87, fontWeight: FontWeight.w700),
              //   ),
              // ),
              // PopupMenuItem(
              //   value: 2,
              //   child: Text(
              //     "Settings",
              //     style: TextStyle(
              //         color: Colors.black87, fontWeight: FontWeight.w700),
              //   ),
              // ),
            ]..addAll(List.generate(drawerOptions.length, (index) {
                return PopupMenuItem(child: drawerOptions[index]);
              })),
            // PopupMenuItem(
            //   child: _getDrawerItemWidget(_selectedDrawerIndex),
            // )
            // PopupMenuItem(
            //   child: Damagedassets(),
            // ),
            // PopupMenuItem(
            //   height: 500,
            //   child: Column(
            //     children: drawerOptions,
            //   ),
            // ),

            icon: Icon(Icons.more_vert),
            offset: Offset(0, 100),
          ),
        ]
            // leading: FlatButton(
            //   child: Text("Log Out"),
            //   textColor: Colors.white,
            //   onPressed: () {
            //     FirebaseAuth.instance.signOut().then((result) =>
            //         Navigator.pushReplacement(context,
            //                 MaterialPageRoute(builder: (context) => Login()))
            //             .catchError((err) => print(err)));
            //   },
            // ),
            // actions: <Widget>[
            //   IconButton(
            //     icon: new Icon(Icons.menu, color: Colors.white),
            //     onPressed: () {
            //       // _scafoldkey.currentState.();
            //     },
            //   ),
            // ],
            ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  'Abhineet',
                  style: new TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                accountEmail: Text(
                  widget.email,
                  style: new TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.indigo),
                ),
                // currentAccountPicture: Image.asset('assets/images/profile.png'),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle, color: Colors.blueAccent),
              ),
              Column(
                children: <Widget>[
                  ListTile(
                    leading: new Icon(Icons.repeat),
                    title: new Text("Logout"),
                    // selected: i == _selectedDrawerIndex,
                    onTap: () {
                      FirebaseAuth.instance.signOut().then((result) =>
                          Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()))
                              .catchError((err) => print(err)));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        body: _getDrawerItemWidget(_selectedDrawerIndex),
      ),
    );
  }
}

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class Hygiene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Hygiene")),
    );
  }
}

class GoodBehaviour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("GoodBehaviour")),
    );
  }
}

// class Detailscreen extends StatelessWidget {
//   final db = Firestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Delete Data from Firestore")),
//       body: ListView(
//         padding: EdgeInsets.all(12.0),
//         children: <Widget>[
//           SizedBox(height: 20.0),
//           StreamBuilder<QuerySnapshot>(
//               stream: db.collection('info').snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return Column(
//                     children: snapshot.data.documents.map((doc) {
//                       return ListTile(
//                         title: Text(doc.data['title']),
//                         trailing: IconButton(
//                           icon: Icon(Icons.cancel),
//                           onPressed: () async {
//                             await db
//                                 .collection('info')
//                                 .document(doc.documentID)
//                                 .delete();
//                           },
//                         ),
//                       );
//                     }).toList(),
//                   );
//                 } else {
//                   return SizedBox();
//                 }
//               }),
//         ],
//       ),
//     );
//   }
// }
