import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Issue {
  String title;
  String label;
  Issue(this.title, this.label);

  Issue.fromMap(Map data)
      : title = data["title"] ?? "",
        label = data["label"] ?? "";
}

class Api {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<FirebaseUser> login() async {
  //   return await _auth.signInAnonymously();
  // }

  // void go() async {
  //   var options = const FirebaseOptions(
  //     apiKey: "AIzaSyDXyczRuaZWskx43U-Pamzyw1YaUag79lY",
  //     // authDomain: "github-issue-bot.firebaseapp.com",
  //     databaseURL: "https://github-issue-bot.firebaseio.com",
  //     // projectId: "github-issue-bot",
  //     storageBucket: "github-issue-bot.appspot.com",
  //     // messagingSenderId: "699789446244",
  //     googleAppID: "1:699789446244:web:7b2fc9b70a7c64c4986371",
  //   );

  //   var app =
  //       await FirebaseApp.configure(name: "github-issue-bot", options: options);
  //   var db = FirebaseDatabase(app: app);
  //   db.reference().child("issues").onValue.listen((v) {
  //     debugPrint("$v");
  //   });
  // }
  void go() {}
}

class MyApp extends StatelessWidget {
  Widget buildItem(DocumentSnapshot document) {
    return ListTile(
      leading: Icon(Icons.home),
      title: Text(document["title"]),
      subtitle: Text(document["label"]),
      trailing: Icon(Icons.details),
    );
  }

  Future<void> go() async {
    return await Firestore.instance.collection("issues").document().setData(
      {
        "title": "title",
        "label": "label",
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Firestore.instance.collection("issues").getDocuments().then((data) {
    //   debugPrint("data - ${data}");
    // });

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            child: Text("H"),
            onTap: () {
              go().then((_) {
                debugPrint("hello, world!");
              });
            },
          ),
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection("issues").snapshots(),
          builder: (context, shot) {
            debugPrint("snapshot has data - ${shot.hasData}");
            if (!shot.hasData) {
              return Center(
                child: Text("Loading ..."),
              );
            }

            debugPrint("data length - ${shot.data.documents}");

            return ListView.builder(
              itemExtent: 80.0,
              itemCount: shot.data.documents.length,
              itemBuilder: (context, index) =>
                  buildItem(shot.data.documents[index]),
            );
          },
        ),
      ),
    );
  }
}
