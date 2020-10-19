import 'package:flutter/material.dart';
import 'package:source_app/engine/domain/model/git_commit.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class ItemHistory extends StatelessWidget {
  final Function _onClick;
  final int _index;
  final GitCommit _commit;

  ItemHistory(this._index, this._commit, this._onClick(String hash));

  @override
  Widget build(BuildContext context) {
    bool isPair = (_index % 2) == 0;

    return Container(
      color: isPair ? SourceColors.white : SourceColors.grey,
      child: Row(
        children: [
          Text(_commit.asciiGraph),
          Text(_commit.abbreviatedHash),
          Text(_commit.message),
          Text(_commit.author),
          Text(_commit.date)
        ],
      ),
    );
  }
}
