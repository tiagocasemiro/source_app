
import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class ItemLineChangeTree extends StatelessWidget {
  final List<String> linesTree;
  final double singleLine = 30.0;

  const ItemLineChangeTree(this.linesTree);

  @override
  Widget build(BuildContext context) {
    double width = linesTree != null? linesTree.last.length * singleLine : singleLine;

    return Visibility(
      visible: linesTree != null,
      replacement: Container(width: width,),
      child: Container(
        color: SourceColors.grey[2],
        width: width,
        child: Row(
            children: buildLine()
        ),
      ),
    );
  }

  List<Widget> buildLine() {
    List<Widget> line = List();


    if(line.isEmpty)
      line.add(Container());

    return line;
  }
}
