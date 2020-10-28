import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class ItemLineTree extends StatelessWidget {
  final String lineTree;
  final double singleLine = 30.0;

  const ItemLineTree(this.lineTree);

  //http://bit-booster.com/graph.html
  //https://stackoverflow.com/a/34987899/7249382

  //git log --pretty='%h|%p|%d'
  //git log --all --date-order --pretty="%H|%P|%d"

  @override
  Widget build(BuildContext context) {
    double width = lineTree != null? lineTree.length * singleLine : singleLine;

    return Visibility(
      visible: lineTree != null,
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
    List<String> patterns = lineTree.split("|");
    patterns.forEach((pattern) {

      if(pattern != null) {
        Widget flow = patternToWidget(pattern);
        if(flow != null) {
          line.add(patternToWidget(pattern));
        }
      }
    });

    if(line.isEmpty)
      line.add(Container());

    return line;
  }

  Widget patternToWidget(String pattern) {
    String image = "";
    switch(pattern){
      case "|": {
        image = "images/flow-vertical.svg";
        break;
      }
      case "/": {
        image = "images/flow-from-right.svg";
        break;
      }
      case "\\": {
        image = "images/flow-from-left.svg";
        break;
      }
      case "*": {
        image = "images/flow-simple-circle.svg";
        break;
      }
      default: {
        return null;
      }
    }

   return  SvgPicture.asset(image, width: singleLine, height: singleLine);
  }
}

/*
images/flow-cross-circle.svg

images/flow-from-left-circle.svg

images/flow-from-right-circle.svg
images/flow-horizontal.svg

images/flow-to-left.svg
images/flow-to-right.svg

*/
