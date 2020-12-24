import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/name_list_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

//カウント用のクラス
class CountData extends ChangeNotifier {
  int count = 0;

  void increment() {
    count = count + 1;
    // 値が変更したことを知らせる↓
    //  >> UIを再構築する
    notifyListeners();
  }
}

//親ウィジェットの生成
class MyApp extends StatelessWidget {
  final data = CountData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ChangeNotifierProvider<CountData>.value(
          value: data,
          child: CatchData(),
        ),
        appBar: AppBar(
          title: Text("タイトル"),
        ),
      ),
    );
  }
}

//子供ウィジェット
class CatchData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // // Provider.of<T>(context) でMyAppウィジェットからデータを受け取る
    final data = Provider.of<CountData>(context);
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5.0),
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                child: Text("ボタン"),
                onPressed: () {
                  //押したら数字が増える
                  data.increment();
                },
              ),
              Text("${data.count.toString()}"),
            ],
          ),
        ),
        Container(
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                child: Text("名前一覧ページへ"),
                onPressed: () {
                  //押したらページ移動
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NameList()),
                  );
                },
              ),
              Text("${data.count.toString()}"),
            ],
          ),
        ),
      ],
    );
  }
}

//更新可能なデータ
class UserState extends ChangeNotifier {
  FirebaseUser user;
}
