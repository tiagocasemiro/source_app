import 'package:flutter/material.dart';

import 'git/git.dart';
import 'git/shell/Terminal.dart';

void main() {
  runApp(SourceApp());

  Git("/home/tiagocasemiro/Documentos/projetos/paranaue/pos-service-gestao").branchesLocal().then((branches) => print(branches));
  Git("/home/tiagocasemiro/Documentos/projetos/paranaue/pos-service-gestao").branchesRemote().then((branches) => print(branches));
  /*Git("/home/tiagocasemiro/Documentos/projetos/pessoal/ChuckNorrisFacts").branchesRemote().then((branches) => print(branches));
  Git("/home/tiagocasemiro/Documentos/projetos/ayla/ayla-package-application-salesman").branchesRemote().then((branches) => print(branches));
  Git("/home/tiagocasemiro/Documentos/projetos/pessoal/ChuckNorrisFacts").branch().then((branch) => print("result ->" + branch.toString()));
  Git("/home/tiagocasemiro/Documentos/projetos/ayla/ayla-package-application-salesman").branch().then((branch) => print("result ->" + branch.toString()));
  Terminal("/home/tiagocasemiro/Documentos/projetos/pessoal/ChuckNorrisFacts").ls().then((value) => print(value));*/
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
