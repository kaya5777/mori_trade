import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moritrade/bloc/tab_bloc.dart';
import 'package:moritrade/page/tab_page.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> tabs = <Tab>[
    Tab(
      text: 'ほしい',
      key: Key('0'),
    ),
    Tab(
      text: "あげる",
      key: Key('1'),
    ),
  ];

  static List<TabBloc> blocs = <TabBloc>[
    TabBloc(kind: 'give'),
    TabBloc(kind: 'take'),
  ];

  final List<Widget> tabPage = <Widget>[
    TabPage(bloc: blocs[0]),
    TabPage(bloc: blocs[1]),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("あつ森交換ツール（仮）"),
        bottom: TabBar(
          tabs: tabs,
          controller: _tabController,
        ),
      ),
      body: Center(
        child: TabBarView(controller: _tabController,
        children: tabPage,
      ),
      ),
      floatingActionButton: Column(
        verticalDirection: VerticalDirection.up,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        FloatingActionButton(
          onPressed: () {
            showAlertDialog(context);
          },
          tooltip: 'addItem',
          child: Icon(Icons.add),
        ),
        Padding(padding: EdgeInsets.only(top: 16.0),),
        FloatingActionButton(
          onPressed: () {
            sendMessage();
          },
          tooltip: 'send',
          child: Icon(Icons.send),
        )
      ],),
    );
  }

  void sendMessage() async {
    String message = "";
    message += "[ほしい]\n${blocs[0].createMessage()}";
    message += "[あげる]\n${blocs[1].createMessage()}";
    message += "#森";
    print(message);

    if(kIsWeb) {
      final data = ClipboardData(text: message);
      await Clipboard.setData(data);
      Fluttertoast.showToast(
          msg: "クリップボードにコピーしました",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      Share.share(message);
    }
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = '';
        return AlertDialog(
          title: Text('アイテムを追加する'),
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                    autofocus: true,
                    decoration: new InputDecoration(
                        labelText: 'アイテム', hintText: 'ex) アイアンウッドテーブルのレシピ'),
                    onChanged: (value) {
                      title = value;
                    },
                  )),
            ],
          ),
          actions: <Widget>[
            FlatButton(
                child: const Text('キャンセル'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                if(title != '') {
                  blocs[_tabController.index].addItem(title);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }
}