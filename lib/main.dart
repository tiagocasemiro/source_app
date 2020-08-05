import 'package:flutter/material.dart';
import 'package:source_app/engine/domain/use.case/start_repository_usecase.dart';
import 'engine/presenter/view/main_view.dart';
import 'engine/shell/git/command/log.dart';
import 'engine/shell/git/git.dart';


void main() {
  runApp(MainView());

  //Git().add().all().call().then((branches) => print(branches));
  //Git().commit().message("commitado pelo app").call().then((branches) => print(branches));
  //Git().push("tiagocasemiro", "password").then((branches) => print(branches));
  //Git().add().all().call().then((value) => print(value));
  //Git().checkout().branch("develop").call().then((value) => print(value));
  //Git().branch().delete("develop").call().then((branches) => print(branches));
  //Git().isGitDirectory().then((branches) => print(branches));
  //Git().log().graph().pretty(Log.historyFormat).call().then((branches) => print(branches));
  //Git().restore().files(['cument_5.txt']).call();

  String _workDirectory = "/home/tiagocasemiro/Documentos/projetos/pessoal/documentation";
  String _host = "github.com";
  String _pathDotGit = "tiagocasemiro/documentation.git";
  String _username = "tiagocasemiro";
  String _password = "";

  StartRepositoryUseCase().startGitApplication();
  Git().log().graph().pretty(Log.historyFormat).call().then((branches) => print(branches));
}
