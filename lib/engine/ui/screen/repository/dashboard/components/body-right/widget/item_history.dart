import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/domain/model/git_commit.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/components/dashboard_history.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/widget/item_line_tree.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class ItemHistory extends StatelessWidget {
  final GestureTapCallback _onClick;
  final int _index;
  final GitCommit _commit;

  ItemHistory(this._index, this._commit, this._onClick());

  @override
  Widget build(BuildContext context) {
    bool isPair = (_index % 2) == 0;
    var _style = GoogleFonts.roboto(
      fontWeight: FontWeight.w500,
      color: SourceColors.blue[2],
      fontSize: 13.0,
    );

    double lineHeight = 30;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        hoverColor: SourceColors.blue[4],
        focusColor: SourceColors.blue[4],
        splashColor: SourceColors.blue[5],
        child: Container(
          color: isPair ? SourceColors.grey[11] : SourceColors.grey[10],
          child: Row(
            children: [
              Container(
                child: ItemLineTree(_commit.asciiGraph),
                width: HistoryDashboard.columnWithTreeHistory,
                height: lineHeight,),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(_commit.abbreviatedHash, style: _style, maxLines: 1,),
                width: HistoryDashboard.columnWithHashHistory,
                height: lineHeight,
              ),
              Expanded(child:
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(_commit.message, style: _style, maxLines: 1,),
                  height: lineHeight,
                )
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(_commit.author, style: _style, maxLines: 1,),
                width: HistoryDashboard.columnWithAuthorHistory,
                height: lineHeight,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(_commit.date, style: _style, maxLines: 1,),
                width: HistoryDashboard.columnWithDateHistory,
                height: lineHeight,
              ),
            ],
          ),
        ),
        onTap: _onClick
      ),
    );
  }
}
