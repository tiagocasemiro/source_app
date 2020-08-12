import 'package:flutter/material.dart';
import '../../../../source_resources.dart';

class ListRepositories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return  Container(
          color: SourceColors.background_grey,
          width: double.maxFinite,
          height: 100,
          margin: const EdgeInsets.only(left: 8.0, top: 1.0, right: 8.0, bottom: 1.0,),
        );
      },
      itemCount: 15,
    );
  }
}
