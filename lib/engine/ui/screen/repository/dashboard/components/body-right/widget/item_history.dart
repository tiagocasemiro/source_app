import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class ItemHistory extends StatelessWidget {
  final Function _onClick;
  final String _hash;
  final String _message;
  final String _author;
  final String _date;
  final String _tree;
  final int _index;

  ItemHistory(this._index, this._tree, this._hash, this._message, this._author, this._date, this._onClick(String hash));

  @override
  Widget build(BuildContext context) {
    bool isPair = (_index % 2) == 0;

    return Container(
      color: isPair ? SourceColors.white : SourceColors.grey,
      child: Row(
        children: [
          Text(_tree),
          Text(_hash),
          Text(_message),
          Text(_author),
          Text(_date)
        ],
      ),
    );
  }
}
