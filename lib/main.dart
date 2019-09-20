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
      title: Text(document["title"]),
      subtitle: Text(document["label"]),
    );
  }

  @override
  Widget build(BuildContext context) {
    // var stream = Firestore.instance.collection("issues").snapshots();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            child: Text("Hello"),
            onTap: () {
              var api = new Api();
              try {
                api.go();
              } catch (ex) {
                debugPrint("error $ex");
              }
            },
          ),
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection("issues").snapshots(),
          builder: (context, shot) {
            if (!shot.hasData) {
              return Center(
                child: Text("Loading ..."),
              );
            }

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
