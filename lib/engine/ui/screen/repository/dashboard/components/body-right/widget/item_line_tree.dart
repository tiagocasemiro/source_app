import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:source_app/engine/domain/model/git_commit.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class ItemLineTree extends StatelessWidget {
  final List<Graph> graphs;
  final double singleLine = 30.0;
  final double width = 10.0;
  final int index;

  const ItemLineTree(this.graphs, this.index);

  //http://bit-booster.com/graph.html
  //https://stackoverflow.com/a/34987899/7249382

  //git log --pretty='%h|%p|%d'
  //git log --all --date-order --pretty="%H|%P|%d"

  @override
  Widget build(BuildContext context) {
    double width = graphs != null? graphs.length * singleLine : singleLine;

    return Visibility(
      visible: graphs != null,
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

    graphs.forEach((graph) {
      line.add(graphToWidget(graph));
    });

    return line;
  }

  Widget graphToWidget(Graph graph) {
   List<Widget> graphsDraw = List();
   graphsDraw.add(Container(height: singleLine, width: width,));

   if(graph.right_to_up) {
     graphsDraw.add(patternImage("images/flow/top-right.svg"));
   }
   if(graph.right_from_down) {
     graphsDraw.add(patternImage("images/flow/bottom-right.svg"));
   }
   if(graph.right_to_right) {
     //graphsDraw.add(SvgPicture.asset("image", height: singleLine, color: SourceColors.blue,));
   }
   if(graph.left_to_left) {
     //graphsDraw.add(SvgPicture.asset("image", height: singleLine, color: SourceColors.blue,));
   }
   if(graph.left_to_up) {
     graphsDraw.add(patternImage("images/flow/top-left.svg"));
   }
   if(graph.left_from_down) {
     graphsDraw.add(patternImage("images/flow/bottom-left.svg"));
   }
   if(graph.commit) {
     if(index == 0) {
       graphsDraw.add(patternImage("images/flow/start-commit.svg"));
     } else {
       graphsDraw.add(patternImage("images/flow/commit.svg"));
     }
   }
   if(graph.vertical) {
     graphsDraw.add(patternImage("images/flow/vertical.svg"));
   }
   if(graph.horizontal) {
     graphsDraw.add(patternImage("images/flow/horizontal.svg"));
   }

   return Stack(children: graphsDraw);
  }

  Widget patternImage(String path) {
    return Container(
      padding: EdgeInsets.all(0),
      width: width,
      child: Center(
        child: SvgPicture.asset(path,
          fit: BoxFit.fill,
          height: singleLine, color: SourceColors.blue,),
      ),
    );
  }
}
