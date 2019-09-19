import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
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

  void go() async {
    var options = const FirebaseOptions(
      apiKey: "AIzaSyDXyczRuaZWskx43U-Pamzyw1YaUag79lY",
      // authDomain: "github-issue-bot.firebaseapp.com",
      databaseURL: "https://github-issue-bot.firebaseio.com",
      // projectId: "github-issue-bot",
      storageBucket: "github-issue-bot.appspot.com",
      // messagingSenderId: "699789446244",
      googleAppID: "1:699789446244:web:7b2fc9b70a7c64c4986371",
    );

    var app =
        await FirebaseApp.configure(name: "github-issue-bot", options: options);
    var db = FirebaseDatabase(app: app);
    db.reference().child("issues").onValue.listen((v) {
      debugPrint("$v");
    });
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Hello"),
              subtitle: Text("enhancement"),
              trailing: Icon(Icons.add_comment),
            )
          ],
        ),
      ),
    );
  }
}
