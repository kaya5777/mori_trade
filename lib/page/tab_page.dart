import 'package:flutter/material.dart';
import 'package:moritrade/bloc/tab_bloc.dart';
import 'package:moritrade/component/list_item.dart';

//class TabPage extends StatefulWidget {
class TabPage extends StatelessWidget {
  final TabBloc bloc;

  TabPage({this.bloc});

//  @override
//  _TabPageState createState() => _TabPageState();
//}
//
//class _TabPageState extends State<TabPage> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.outItem,
      builder: (context, snapshot) {
        if(snapshot.data == null || snapshot.data.length == 0) {
          return Center(child: Text("データがありません"),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return ListItem(
                title: snapshot.data[index],
                onRemove: (value) {
                  bloc.deleteItem(value);
                },
            );
          },
        );
      },
    );
  }
}