


import 'package:flutter/material.dart';

class ListRepositories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return  Container(
          color: Colors.white10,
          width: double.maxFinite,
          height: 100,
          margin: const EdgeInsets.all(8.0),
        );
      },
      itemCount: 15,
    );
  }
}
