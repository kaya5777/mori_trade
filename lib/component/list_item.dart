import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String title;
  final OnRemove onRemove;

  ListItem({this.title, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16.0)),
          Expanded(child: Text(this.title, style: TextStyle(fontSize: 16.0),)),
          IconButton(icon: Icon(Icons.delete),
            onPressed: () {
              if(onRemove != null) {
                onRemove(title);
              }
            },
          ),
        ],
        mainAxisSize: MainAxisSize.max,
      ),
    );
  }
}

typedef void OnRemove(String value);