import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NameList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //リターンはScaffoldにしないとエラーとなってしまう。
    return Scaffold(
      appBar: AppBar(
        title: Text("名前一覧ページ"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return new ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return new ListTile(
                    title: new Text(document['name']),
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}
