import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'git/git.dart';
import 'git/shell/Terminal.dart';

void main() {
  runApp(SourceApp());

  //Git().add().files(["document_1.txt"]).then((branches) => print(branches));
  //Git().commit("linha 9 passo a passo").then((branches) => print(branches));
  //Git().push("tiagocasemiro", "password").then((branches) => print(branches));
  Git().fetch().then((value) => print(value));

}

class SourceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Source',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Container(
        color: Colors.white,
      ),
    );
  }
}
