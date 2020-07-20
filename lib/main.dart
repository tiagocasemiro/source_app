import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'git/git.dart';
import 'git/shell/Terminal.dart';

void main() {
  runApp(SourceApp());

  String workDirectory = "/home/tiagocasemiro/Documentos/projetos/pessoal/documentation";

  //Git("/home/tiagocasemiro/Documentos/projetos/paranaue/pos-service-gestao").branchesLocal().then((branches) => print(branches));
  //Git("/home/tiagocasemiro/Documentos/projetos/paranaue/pos-service-gestao").branchesRemote().then((branches) => print(branches));
  /*Git("/home/tiagocasemiro/Documentos/projetos/pessoal/ChuckNorrisFacts").branchesRemote().then((branches) => print(branches));
  Git("/home/tiagocasemiro/Documentos/projetos/ayla/ayla-package-application-salesman").branchesRemote().then((branches) => print(branches));
  Git("/home/tiagocasemiro/Documentos/projetos/pessoal/ChuckNorrisFacts").branch().then((branch) => print("result ->" + branch.toString()));
  Git("/home/tiagocasemiro/Documentos/projetos/ayla/ayla-package-application-salesman").branch().then((branch) => print("result ->" + branch.toString()));
  Terminal("/home/tiagocasemiro/Documentos/projetos/pessoal/ChuckNorrisFacts").ls().then((value) => print(value));*/

  //Git("/home/tiagocasemiro/Documentos/projetos/paranaue/pos-service-gestao").branch().remote().then((branches) => print(branches));
 // Git("/home/tiagocasemiro/Documentos/projetos/pessoal/TestSource").tag().all().then((branches) => print(branches));
 // Git("/home/tiagocasemiro/Documentos/projetos/pessoal/TestSource").add().all().then((branches) => print(branches));
//  Git("/home/tiagocasemiro/Documentos/projetos/pessoal/TestSource").add().files(["name"]).then((branches) => print(branches));
  //Git("/home/tiagocasemiro/Documentos/projetos/pessoal/documentation").add().files(["document_1.txt"]).then((branches) => print(branches));

  //Git(workDirectory).commit("initial commit").then((branches) => print(branches));
  //Terminal(workDirectory).pwd().then((value) => print(value));

  Git(workDirectory).push().then((branches) => print(branches));
/*  Process.start('cat', []).then((Process process) {
    process.stdout
        .transform(utf8.decoder)
        .listen((data) { print(data); });
    process.stdin.writeln('Hello, world!');
    process.stdin.writeln('Hello, galaxy!');
    process.stdin.writeln('Hello, universe!');
  });*/

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
