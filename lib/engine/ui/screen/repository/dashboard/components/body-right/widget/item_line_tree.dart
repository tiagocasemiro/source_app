import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:source_app/engine/domain/model/git_commit.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class ItemLineTree extends StatelessWidget {
  final List<Graph> graph;
  final double singleLine = 30.0;
  final int index;

  const ItemLineTree(this.graph, this.index);

  //http://bit-booster.com/graph.html
  //https://stackoverflow.com/a/34987899/7249382

  //git log --pretty='%h|%p|%d'
  //git log --all --date-order --pretty="%H|%P|%d"

  @override
  Widget build(BuildContext context) {
    double width = graph != null? graph.length * singleLine : singleLine;

    return Visibility(
      visible: graph != null,
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

  Widget patternToWidget(String pattern) {
    String image = "";

    switch(pattern.trim()){
      case "|": {
        image = "images/flow/pipe.svg";
        break;
      }
      case "/": {
        image = "images/flow/bar.svg";
        break;
      }
      case "\\": {
        image = "images/flow/back-slash.svg";
        break;
      }
      case "-": {
        image = "images/flow/trace.svg";
        break;
      }
      case "*": {
        if(index == 0) {
          image = "images/flow/start-asterisk.svg";
        } else {
          image = "images/flow/asterisk.svg";
        }
        break;
      }

      default: {
        return null;
      }
    }

   return  SvgPicture.asset(image, height: singleLine, color: SourceColors.blue,);
  }
}
